defmodule FrixelDesignSystem.Components.ProductTest do
  alias FrixelDesignSystem.Components.Product
  use ComponentCase

  describe "sorting_filter" do
    assigns = %{sorting: "price ascending"}

    html =
      "#{rendered_to_string(~H"""
      <Product.sorting_filter sorting={@sorting} />
      """)}"

    assert html =~ "<details id=\"sorting-dropdown\" class=\"dropdown\">"
    assert html =~ "Sort by : price ascending"
    assert html =~ "class=\"menu-active\">\n        Ascending price"
  end

  describe "subcategory_carousel" do
    assigns = %{
      subcategory_path: "/subcategories",
      subcategories: [
        %{
          name: "Test subcategory",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
        },
        %{
          name: "Test subcategory 2",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1572635148818-ef6fd45eb394.webp"
        },
        %{
          name: "Test subcategory 3",
          illustration_url:
            "https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp"
        }
      ]
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.subcategory_carousel subcategory_path={@subcategory_path} subcategories={@subcategories} />
      """)}"

    assert html =~ "<div class=\"carousel"

    assert html =~
             "<a href=\"/subcategories/Test subcategory 2\" data-phx-link=\"patch\" data-phx-link-state=\"push\""

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1565098772267-60af42b81ef2.webp\">"

    assert html =~ "Test subcategory 3</figcaption>"
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
      <Product.product_card product={@product} />
      """)}"

    assert html =~ "<div class=\"card card-xl\">"

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp\">"

    assert html =~ "Product test</h3>"
    assert html =~ "This is a test product description.</p>"
    assert html =~ "1000.00€</p>"
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
        illustration_url:
          "https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
      }
    }

    html =
      "#{rendered_to_string(~H"""
      <Product.product_details product={@product} />
      """)}"

    assert html =~
             "<img src=\"https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp\""

    assert html =~ "This is a test product description.</p>"
    assert html =~ "Product test</h2>"

    assert html =~ "1000.00€</p>"
    assert html =~ "<button class=\"btn\">Add to cart</button>"
  end
end
