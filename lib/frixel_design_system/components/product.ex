defmodule FrixelDesignSystem.Components.Product do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext
  alias Phoenix.LiveView.JS

  @doc """
  A dropdown component to apply a filter on the products request.

  ## Example:

      <Product.sorting_filter sorting="price ascending" event_name="sort-by" class="text-center" />
  """
  attr :class, :string, default: ""

  attr :sorting, :string,
    default: "new products",
    values: ["new products", "price ascending", "price descending"]

  attr :event_name, :string,
    required: true,
    doc: "The name of the event to trigger from the parent live view"

  def sorting_filter(assigns) do
    ~H"""
    <details id="sorting-dropdown" class={"dropdown #{@class}"}>
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
            {gettext("Descending price")}
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
            {gettext("Ascending price")}
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
            {gettext("New products")}
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
    <div class={"carousel carousel-center gap-1 sm:gap-2 md:gap-3 lg:gap:4 m-auto #{@class}"}>
      <.link
        :for={category <- @categories}
        class="carousel-item w-2/5 sm:w-2/7 md:w-2/9 lg:w-2/11"
        patch={"#{@category_path}/#{get_in(category, [Access.key(@name_key)])}"}
      >
        <figure class="flex-col">
          <img src={get_in(category, [Access.key(@illustration_url_key)])} />
          <figcaption class="text-center pt-2">
            {get_in(category, [Access.key(@name_key)])}
          </figcaption>
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
          ← {gettext("Back to parent category")}
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

  attr :product_availability_color_class, :string,
    default: nil,
    doc:
      "A background color class used to paint a small colored disc to show product availability or unavailability, ex: \"bg-emerald-400\" when available or \"bg-red-500\" when not available"

  attr :product_availability_comment, :string,
    default: nil,
    doc: "A short sentence to adds details about availability, ex: \"Available soon !\""

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

        <p :if={@product_availability_comment} class="flex items-center justify-center gap-2">
          <span
            :if={@product_availability_color_class}
            class={"size-2 rounded-full inline-block #{@product_availability_color_class}"}
          /> {@product_availability_comment}
        </p>
      </div>
    </div>
    """
  end

  @doc """
  A component to render all product informations

  ## Example:

      <Product.product_details
        product_name="Big watch"
        product_illustration_url="/path/to/big/watch/img.webp"
        product_description="This is a really big watch to show off"
        product_price="1 000 000 000,00"
        product_unit_type="item"
        product_stock={2}
        product_availability_color_class="bg-green-500"
        is_cart_active?={true}
        bg_color_class="bg-white"
      />
  """
  attr :bg_color_class, :string,
    default: "bg-white",
    doc: "A background color class used for the product details lateral panel"

  attr :product_illustration_url, :string,
    default: nil,
    doc: "An image to illustrate your product"

  attr :product_name, :string, required: true, doc: "The name of your product"

  attr :product_description, :string,
    default: nil,
    doc:
      "An exhaustive description of your product to inform your customer on the product (technical details, etc)"

  attr :product_price, :string, required: true, doc: "The price of your product"

  attr :product_unit_type, :string,
    required: true,
    doc: "The selling unit type (eg: item, m², L, Kg) "

  attr :product_stock, :integer,
    default: nil,
    doc: "How many of this product do you have in your stock ?"

  attr :product_availability_color_class, :string,
    default: nil,
    doc:
      "A background color class used to paint a small colored disc to show product availability or unavailability, ex: \"bg-emerald-400\" when available or \"bg-red-500\" when not available"

  attr :product_availability_comment, :string,
    default: nil,
    doc: "A short sentence to adds details about availability, ex: \"Available soon !\""

  attr :is_cart_active?, :boolean,
    default: true,
    doc: "A switch to enable or disable the 'add to cart' button"

  def product_details(assigns) do
    ~H"""
    <div class={"#{@bg_color_class} sm:grid sm:grid-cols-2"}>
      <%!-- TODO: should be a carousel here --%>
      <div class="sm:order-2 h-[calc(100vh-56px)] overflow-y-auto">
        <figure :if={@product_illustration_url}>
          <img src={@product_illustration_url} class="w-screen" />
        </figure>

        <p class="text-center mt-4">{gettext("More details below")} ↓</p>

        <div :if={@product_description} class="p-8">
          <p class="text-sm">{@product_description}</p>
        </div>
      </div>

      <div class={"#{@bg_color_class} card card-xs items-center sticky bottom-0 sm:top-1/2 sm:order-1 w-full border-t border-base-300 rounded-none p-8"}>
        <div class="card-body flex-row justify-between items-center">
          <div>
            <h2 class="card-title flex-col">{@product_name}</h2>

            <p class="text-sm">{@product_price}€ / {@product_unit_type}</p>

            <p :if={@product_stock}>{gettext("Stock")}: {@product_stock}</p>

            <p :if={@product_availability_comment}>
              <span
                :if={@product_availability_color_class}
                class={"size-2 rounded-full inline-block #{@product_availability_color_class}"}
              /> {@product_availability_comment}
            </p>
          </div>

          <div :if={@is_cart_active?} class="card-actions">
            <button class="btn">{gettext("Add to cart")}</button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
