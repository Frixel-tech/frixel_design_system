defmodule FrixelDesignSystem.Components.Product do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @doc """
  A dropdown component to apply a filter on the products request.

  ## Example:

      <Product.sorting_filter sorting="price ascending" event_name="sort-by" />
  """
  attr :sorting, :string,
    default: "new products",
    values: ["new products", "price ascending", "price descending"]

  attr :event_name, :string,
    required: true,
    doc: "The name of the event to trigger from the parent live view"

  def sorting_filter(assigns) do
    ~H"""
    <details id="sorting-dropdown" class="dropdown">
      <summary class="btn m-1">Sort by : {@sorting}</summary>
      <ul class="menu dropdown-content bg-base-200 rounded-box z-1 w-52 p-2 shadow-sm">
        <li>
          <a
            phx-click={
              JS.push(@event_name, value: %{sort_by: "price descending"})
              |> JS.remove_attribute("open", to: "#sorting-dropdown")
            }
            class={@sorting == "price descending" && "menu-active"}
          >
            Descending price
          </a>
        </li>
        <li>
          <a
            phx-click={
              JS.push(@event_name, value: %{sort_by: "price ascending"})
              |> JS.remove_attribute("open", to: "#sorting-dropdown")
            }
            class={@sorting == "price ascending" && "menu-active"}
          >
            Ascending price
          </a>
        </li>
        <li>
          <a
            phx-click={
              JS.push(@event_name, value: %{sort_by: "new products"})
              |> JS.remove_attribute("open", to: "#sorting-dropdown")
            }
            class={@sorting == "new products" && "menu-active"}
          >
            New products
          </a>
        </li>
      </ul>
    </details>
    """
  end

  attr :class, :string, default: ""

  attr :category_path, :string,
    required: true,
    doc: "The categories (or subcategories) static path, ex: '/category"

  attr :categories, :list,
    default: [],
    doc:
      "A list of maps or structs representing categories (or subcategories). It should at least have `name` and `illustration_url` keys ; ex: [%{name: 'watches', illustration_url: 'http://url.to/img'}, ...]"

  attr :name_key, :atom,
    required: true,
    doc: "The struct or map key under which name we can access the category name"

  attr :illustration_url_key, :atom,
    required: true,
    doc: "The struct or map key under which name we can access the category illustration url"

  def category_carousel(assigns) do
    ~H"""
    <div class={"carousel carousel-center gap-1 px-2 m-auto #{@class}"}>
      <.link
        :for={category <- @categories}
        class="carousel-item w-1/3 md:w-1/4 lg:1/5"
        patch={"#{@category_path}/#{get_in(category, [Access.key(@name_key)])}"}
      >
        <figure class="flex-col">
          <img src={get_in(category, [Access.key(@illustration_url_key)])} />
          <figcaption class="text-center pt-2">{get_in(category, [Access.key(@name_key)])}</figcaption>
        </figure>
      </.link>
    </div>
    """
  end

  attr :subcategory, :map,
    required: true,
    doc:
      "A map representing a subcategory. It should at least have `name` and `illustration_url` keys, but adding a `description` key is great too ; ex: %{name: 'watches', illustration_url: 'http://url.to/img', description: 'Description for watches subcategory.'}"

  attr :return_to, :string,
    required: true,
    doc: "The full path to return to, ex: '/categories/watches'"

  def subcategory_banner(assigns) do
    ~H"""
    <div class="card lg:card-side my-4 !items-center relative bg-base-200 shadow-sm rounded-none">
      <div class="card-body items-center">
        <.link :if={@subcategory} patch={@return_to} class="lg:absolute lg:top-4 lg:self-start">
          &lt;- Back to parent category
        </.link>
        <h2 class="card-title">{@subcategory[:name]}</h2>
        <p>{@subcategory[:description]}</p>
      </div>

      <figure class="w-full lg:w-1/2">
        <img src={@subcategory[:illustration_url]} class="w-full" />
      </figure>
    </div>
    """
  end

  attr :product_illustration_url, :string,
    default: nil,
    doc: "An image to illustrate your product"

  attr :product_name, :string, required: true, doc: "The name of your product"

  attr :product_short_description, :string,
    default: nil,
    doc: "A quick description to make your customer click on the product (marketing, needs)"

  attr :product_price, :string, required: true, doc: "The price of your product"

  def product_card(assigns) do
    ~H"""
    <div class="card card-xl">
      <%!-- TODO : should change illustration on hover --%>
      <figure :if={@product_illustration_url}>
        <img src={@product_illustration_url} />
      </figure>

      <div class="card-body text-center p-4">
        <h3 class="card-title flex-col">{@product_name}</h3>
        <p :if={@product_short_description} class="text-sm">{@product_short_description}</p>
        <p class="text-sm">{@product_price}€</p>
      </div>
    </div>
    """
  end

  attr :product_illustration_url, :string,
    default: nil,
    doc: "An image to illustrate your product"

  attr :product_name, :string, required: true, doc: "The name of your product"

  attr :product_description, :string,
    default: nil,
    doc:
      "An exhaustive description of your product to inform your customer on the product (technical details, etc)"

  attr :product_price, :string, required: true, doc: "The price of your product"

  attr :is_cart_active?, :boolean,
    default: true,
    doc: "A switch to enable or disable the 'add to cart' button"

  attr :bg_color_class, :string,
    default: "bg-white",
    doc: "A background color class used for the product details lateral panel"

  def product_details(assigns) do
    ~H"""
    <div class={"#{@bg_color_class} sm:grid sm:grid-cols-2"}>
      <%!-- TODO: should be a carousel here --%>
      <div class="sm:order-2 h-[calc(100vh-56px)] overflow-y-auto">
        <figure :if={@product_illustration_url}>
          <img src={@product_illustration_url} class="w-screen" />
        </figure>

        <div :if={@product_description} class="p-8">
          <p class="text-sm">{@product_description}</p>
        </div>
      </div>

      <div class={"#{@bg_color_class} card card-xs items-center sticky bottom-0 sm:top-1/2 sm:order-1 w-full border-t border-base-300 rounded-none p-8"}>
        <div class="card-body flex-row justify-between items-center">
          <div>
            <h2 class="card-title flex-col">{@product_name}</h2>
            <p class="text-sm">{@product_price}€</p>
          </div>

          <div :if={@is_cart_active?} class="card-actions">
            <button class="btn">Add to cart</button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
