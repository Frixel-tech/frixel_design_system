defmodule FrixelDesignSystem.Components.ProductTest do
  alias FrixelDesignSystem.Components.Product
  use ComponentCase

  describe "sorting_filter" do
    assigns = %{sorting: "price ascending"}

    html =
      "#{rendered_to_string(~H"""
      <Product.sorting_filter sorting={@sorting} event_name="sort-by" class="text-center" />
      """)}"

    assert html =~ "<details id=\"sorting-dropdown\" class=\"dropdown text-center\">"
    assert html =~ "Sort by : price ascending"
    assert html =~ "class=\"menu-active\">\n        Ascending price"
    assert html =~ "sort-by"
  end

  describe "category_carousel" do
    assigns = %{
      category_path: "/categories",
      categories: [
        %{
          name: "Test category",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
        },
        %{
          name: "Test category 2",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
        },
        %{
          name: "Test category 3",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
        }
      ]
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.category_carousel
        category_path={@category_path}
        categories={@categories}
        name_key={:name}
        illustration_url_key={:illustration_url}
      />
      """)}"

    assert html =~ "<div class=\"carousel"

    assert html =~ "href=\"/categories/Test category 2\""

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp\">"

    assert html =~ "Test category 3"
  end

  describe "subcategory_banner" do
    assigns = %{
      subcategory: %{
        name: "Test subcategory",
        description: "This is a test description for a subcategory.",
        illustration_url:
          "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
      },
      return_to: "/categories/test_parent_category"
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.subcategory_banner subcategory={@subcategory} return_to={@return_to} />
      """)}"

    assert html =~
             "<div class=\"card lg:card-side"

    assert html =~
             "<a href=\"/categories/test_parent_category\" data-phx-link=\"patch\" data-phx-link-state=\"push\""

    assert html =~ "<h2 class=\"card-title\">Test subcategory</h2>"
    assert html =~ "<p>This is a test description for a subcategory.</p>"

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp\""
  end

  describe "product_card" do
    assigns = %{
      product: %{
        id: 1,
        category_id: 1,
        subcategory_id: nil,
        name: "Product test",
        description: "This is a test product description.",
        price: "1000.00",
        illustration_url:
          "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
      }
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.product_card
        product_illustration_url={@product.illustration_url}
        product_name={@product.name}
        product_short_description={@product.description}
        product_price={@product.price}
        product_availability_color_class="bg-emerald-400"
        product_availability_comment="Available"
      />
      """)}"

    assert html =~ "<div class=\"card card-xl\">"

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp\">"

    assert html =~ "Product test</h3>"
    assert html =~ "This is a test product description.</p>"
    assert html =~ "1000.00€</p>"
    assert html =~ "bg-emerald-400"
    assert html =~ "Available"
  end

  describe "product_details" do
    assigns = %{
      product: %{
        id: 1,
        category_id: 1,
        subcategory_id: nil,
        name: "Product test",
        description: "This is a test product description.",
        price: "1000.00",
        stock: 2,
        unit: "item",
        illustration_url:
          "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
      },
      company: %{
        email_address: "contact@test.com"
      }
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.product_details
        product_name={@product.name}
        product_illustration_url={@product.illustration_url}
        product_description={@product.description}
        product_price={@product.price}
        product_unit_type={@product.unit}
        product_stock={@product.stock}
        bg_color_class="bg-white"
        product_availability_comment="Available"
        product_availability_color_class="bg-green-500"
      >
        <:actions>
          <button class="btn" phx-click="add-to-cart">Add to cart</button>
          <a href={"mailto:#{@company.email_address}"}>Contact us</a>
        </:actions>
      </Product.product_details>
      """)}"

    assert html =~
             "src=\"https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp\""

    assert html =~ "This is a test product description."
    assert html =~ "Product test"
    assert html =~ "1000.00€"
    assert html =~ "item"
    assert html =~ "2"
    assert html =~ "bg-green-500"
    assert html =~ "Available"
    assert html =~ "bg-white"
    assert html =~ "<button class=\"btn\" phx-click=\"add-to-cart\">Add to cart</button>"
    assert html =~ "<a href=\"mailto:contact@test.com\">Contact us</a>"
  end

  describe "product_thumbnail" do
    test "renders thumbnails when multiple images provided" do
      assigns = %{
        product_pictures_urls_list: [
          "https://img.daisyui.com/images/stock/photo-1.webp",
          "https://img.daisyui.com/images/stock/photo-2.webp",
          "https://img.daisyui.com/images/stock/photo-3.webp"
        ],
        product_name: "Test Product",
        gallery_id: "test-gallery"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_thumbnail
          product_pictures_urls_list={@product_pictures_urls_list}
          product_name={@product_name}
          gallery_id={@gallery_id}
        />
        """)}"

      assert html =~ "<div class=\"py-4\">"
      assert html =~ "flex flex-wrap gap-3 justify-center"
      assert html =~ "Cliquez sur une image pour l'agrandir"
    end

    test "does not render when only one or no images" do
      assigns = %{
        product_pictures_urls_list: ["https://img.daisyui.com/images/stock/photo-1.webp"],
        product_name: "Test Product",
        gallery_id: "test-gallery"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_thumbnail
          product_pictures_urls_list={@product_pictures_urls_list}
          product_name={@product_name}
          gallery_id={@gallery_id}
        />
        """)}"

      refute html =~ "<div class=\"py-4\">"
    end
  end

  describe "product_image_gallery" do
    test "renders gallery with main image and thumbnails" do
      assigns = %{
        product_illustration_url: "https://img.daisyui.com/images/stock/main-image.webp",
        product_pictures_urls_list: [
          "https://img.daisyui.com/images/stock/photo-1.webp",
          "https://img.daisyui.com/images/stock/photo-2.webp"
        ],
        product_name: "Test Product",
        gallery_id: "desktop"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_image_gallery
          product_illustration_url={@product_illustration_url}
          product_pictures_urls_list={@product_pictures_urls_list}
          product_name={@product_name}
          gallery_id={@gallery_id}
        />
        """)}"

      assert html =~ "phx-hook=\"ResetImageGallery\""
      assert html =~ "id=\"gallery-desktop\""
      assert html =~ "data-original-src=\"https://img.daisyui.com/images/stock/main-image.webp\""
      assert html =~ "alt=\"Test Product\""
    end

    test "renders placeholder when no main image" do
      assigns = %{
        product_illustration_url: nil,
        product_pictures_urls_list: [],
        product_name: "Test Product",
        gallery_id: "desktop"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_image_gallery
          product_illustration_url={@product_illustration_url}
          product_pictures_urls_list={@product_pictures_urls_list}
          product_name={@product_name}
          gallery_id={@gallery_id}
        />
        """)}"

      assert html =~ "bg-gradient-to-br from-mint-green/10 to-mint-green/5"
      refute html =~ "<figure"
    end
  end

  describe "product_status" do
    test "renders availability status with simple variant" do
      assigns = %{
        availability_color_class: "bg-mint-green",
        availability_comment: "Disponible",
        product_stock: 10,
        variant: "simple"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status
          availability_color_class={@availability_color_class}
          availability_comment={@availability_comment}
          product_stock={@product_stock}
          variant={@variant}
        />
        """)}"

      assert html =~ "bg-mint-green"
      assert html =~ "Disponible"
      assert html =~ "Stock : 10"
      assert html =~ "text-xs text-gray-600"
      refute html =~ "p-4 bg-gray-50"
    end

    test "renders availability status with detailed variant" do
      assigns = %{
        availability_color_class: "bg-brick-orange",
        availability_comment: "Temporairement indisponible",
        product_stock: 0,
        variant: "detailed"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status
          availability_color_class={@availability_color_class}
          availability_comment={@availability_comment}
          product_stock={@product_stock}
          variant={@variant}
        />
        """)}"

      assert html =~ "bg-brick-orange"
      assert html =~ "Temporairement indisponible"
      assert html =~ "Stock : 0"
      assert html =~ "p-4 bg-gray-50 rounded-xl border border-gray-200"
      assert html =~ "text-sm text-gray-700"
    end

    test "does not render when no availability info or stock" do
      assigns = %{
        availability_color_class: nil,
        availability_comment: nil,
        product_stock: nil,
        variant: "simple"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status
          availability_color_class={@availability_color_class}
          availability_comment={@availability_comment}
          product_stock={@product_stock}
          variant={@variant}
        />
        """)}"

      assert html == ""
    end
  end

  describe "product_infos" do
    test "renders product name, price and unit type" do
      assigns = %{
        product_name: "Big watch",
        product_price: "1,000.00",
        product_unit_type: "item"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_infos
          product_name={@product_name}
          product_price={@product_price}
          product_unit_type={@product_unit_type}
        />
        """)}"

      assert html =~ "Big watch"
      assert html =~ "1,000.00€"
      assert html =~ "/ item"
      assert html =~ "text-2xl sm:text-3xl font-bold"
      assert html =~ "text-mint-green"
    end
  end

  describe "product_description" do
    test "renders description when provided" do
      assigns = %{
        product_description: "This is a detailed product description"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_description product_description={@product_description} />
        """)}"

      assert html =~ "This is a detailed product description"
      assert html =~ "Description"
      assert html =~ "hero-information-circle"
      assert html =~ "bg-gradient-to-r from-mint-green/5"
      refute html =~ "Aucune description disponible"
    end

    test "renders fallback message when no description" do
      assigns = %{
        product_description: nil
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_description product_description={@product_description} />
        """)}"

      assert html =~ "Aucune description disponible pour ce produit"
      assert html =~ "hero-document-text"
      refute html =~ "bg-gradient-to-r from-mint-green/5"
    end
  end

  describe "product_status_badges" do
    test "renders both sale and rental badges when both are true" do
      assigns = %{
        to_sell: true,
        to_rent: true,
        compact: false,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Disponible à la vente"
      assert html =~ "Disponible en location"
      assert html =~ "bg-green-100 text-green-800"
      assert html =~ "bg-blue-100 text-blue-800"
      assert html =~ "bg-green-500"
      assert html =~ "bg-blue-500"
    end

    test "renders unavailable badges when both are false" do
      assigns = %{
        to_sell: false,
        to_rent: false,
        compact: false,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Pas en vente"
      assert html =~ "Pas en location"
      assert html =~ "bg-gray-100 text-gray-600"
      assert html =~ "bg-gray-400"
      refute html =~ "bg-green-100"
      refute html =~ "bg-blue-100"
    end

    test "renders only sale badge as available when to_sell is true and to_rent is false" do
      assigns = %{
        to_sell: true,
        to_rent: false,
        compact: false,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Disponible à la vente"
      assert html =~ "Pas en location"
      assert html =~ "bg-green-100 text-green-800"
      assert html =~ "bg-green-500"
      assert html =~ "bg-gray-100 text-gray-600"
      assert html =~ "bg-gray-400"
    end

    test "renders only rental badge as available when to_sell is false and to_rent is true" do
      assigns = %{
        to_sell: false,
        to_rent: true,
        compact: false,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Pas en vente"
      assert html =~ "Disponible en location"
      assert html =~ "bg-blue-100 text-blue-800"
      assert html =~ "bg-blue-500"
      assert html =~ "bg-gray-100 text-gray-600"
      assert html =~ "bg-gray-400"
    end

    test "renders compact version when compact is true" do
      assigns = %{
        to_sell: true,
        to_rent: true,
        compact: true,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Vente"
      assert html =~ "Location"
      assert html =~ "text-xs"
      assert html =~ "px-2 py-1"
      assert html =~ "gap-1"
      assert html =~ "w-1.5 h-1.5"
      refute html =~ "Disponible à la vente"
      refute html =~ "Disponible en location"
    end

    test "renders compact unavailable version when compact is true and both are false" do
      assigns = %{
        to_sell: false,
        to_rent: false,
        compact: true,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "Pas vente"
      assert html =~ "Pas location"
      assert html =~ "text-xs"
      assert html =~ "px-2 py-1"
      refute html =~ "Pas en vente"
      refute html =~ "Pas en location"
    end

    test "applies custom class to container" do
      assigns = %{
        to_sell: true,
        to_rent: false,
        compact: false,
        class: "custom-spacing gap-4"
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "custom-spacing gap-4"
    end

    test "applies correct gap classes for compact and normal modes" do
      # Test normal mode
      assigns = %{
        to_sell: true,
        to_rent: true,
        compact: false,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "gap-2"

      # Test compact mode
      assigns = %{
        to_sell: true,
        to_rent: true,
        compact: true,
        class: ""
      }

      html =
        "#{rendered_to_string(~H"""
        <Product.product_status_badges
          to_sell={@to_sell}
          to_rent={@to_rent}
          compact={@compact}
          class={@class}
        />
        """)}"

      assert html =~ "gap-1"
    end
  end
end
