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

  @doc """
  Renders a carousel componant to show categories or subcategories with an horizontal scrolling gallery.

  ## Example:

    <Product.category_carousel
      category_path="/catalog/category"
      categories={@categories_list}
      name_key={:name}
      illustration_url_key={:illustration_url}
      class="bg-red-500"
    />
  """
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

  @doc """
  Renders some product informations inside a card.

  ## Example:

    <Product.product_card
      product_illustration_url="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
      product_name="Product test"
      product_short_description="This is a test product description."
      product_price="1000,00"
      product_availability_color_class="bg-emerald-400"
      product_availability_comment="Available"
    />
  """
  attr :product_illustration_url, :string,
    default: nil,
    doc: "An image to illustrate your product"

  attr :product_name, :string, required: true, doc: "The name of your product"

  attr :product_short_description, :string,
    default: nil,
    doc: "A quick description to make your customer click on the product (marketing, needs)"

  attr :product_price, :string, required: true, doc: "The price of your product"

  attr :product_unit, :string,
    default: nil,
    doc: "The selling unit type (eg: 'piece', 'm2', 'kg')"

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

        <p class="text-sm">{@product_price}€<span :if={@product_unit}> / {@product_unit}</span></p>

        <p :if={@product_availability_comment} class="text-sm flex items-center justify-center gap-2">
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

      <.product_details
        product_name="Big watch"
        product_illustration_url="/path/to/big/watch/img.webp"
        product_description="This is a really big watch to show off"
        product_price="1 000 000 000,00"
        product_unit_type="item"
        product_stock={2}
        product_availability_color_class="bg-green-500"
        product_availability_comment="Available"
        bg_color_class="bg-white"
      >
        <:actions>
            <button class="btn" phx-click="add-to-cart">Add to cart</button>
            <a href="mailto:contact@test.com">Contact us</a>
        </:actions>
      </.product_details>
  """
  attr :bg_color_class, :string,
    default: "bg-white",
    doc: "A background color class used for the product details lateral panel"

  attr :product_illustration_url, :string,
    default: nil,
    doc: "An image to illustrate your product"

  attr :product_pictures_urls_list, :list,
    default: [],
    doc: "A list of image URLs to show as thumbnails below the main image"

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

  slot :actions, doc: "A slot to put call to actions inside ex: cart button, contact links"

  def product_details(assigns) do
    ~H"""
    <div class={"#{@bg_color_class} sm:grid sm:grid-cols-2"}>
      <div class="sm:order-2 p-6 space-y-6">
        <div class="hidden sm:block">
          <.product_image_gallery
            product_illustration_url={@product_illustration_url}
            product_pictures_urls_list={@product_pictures_urls_list}
            product_name={@product_name}
            gallery_id="desktop"
          />
        </div>
        <div class="hidden sm:block">
          <.product_description product_description={@product_description} />
        </div>
      </div>

      <div class={"#{@bg_color_class} sm:order-1 p-6 sm:p-8 space-y-6"}>
        <.product_infos
          product_name={@product_name}
          product_price={@product_price}
          product_unit_type={@product_unit_type}
        />
        <div class="block sm:hidden">
          <.product_image_gallery
            product_illustration_url={@product_illustration_url}
            product_pictures_urls_list={@product_pictures_urls_list}
            product_name={@product_name}
            gallery_id="mobile"
          />
        </div>
        <.product_status
          product_stock={@product_stock}
          availability_color_class={@product_availability_color_class}
          availability_comment={@product_availability_comment}
          variant="detailed"
        />
        <div class="block sm:hidden">
          <.product_description product_description={@product_description} />
        </div>

        <div class="space-y-4">
          <div class="text-center sm:text-left">
            <h3 class="text-lg font-semibold mb-4">Nous contacter</h3>
          </div>

          <div class="flex flex-col gap-3 items-center pt-4">
            {render_slot(@actions)}
          </div>
        </div>
      </div>
    </div>
    """
  end
end
