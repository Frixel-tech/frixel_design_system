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
end
