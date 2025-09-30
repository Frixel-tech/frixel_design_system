defmodule FrixelDesignSystem.Components.Product do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext
  alias Phoenix.LiveView.JS
  import FrixelDesignSystemWeb.CoreComponents, only: [icon: 1]

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
  A component to render product thumbnail gallery

  ## Example:

      <.product_thumbnail_gallery
        product_pictures_urls_list={["/path/to/img1.webp", "/path/to/img2.webp"]}
        product_name="Product Name"
        gallery_id="desktop"
      />
  """
  attr :product_pictures_urls_list, :list,
    default: [],
    doc: "List of all product image URLs for thumbnails"

  attr :product_name, :string, required: true, doc: "Product name for alt text"

  attr :gallery_id, :string,
    default: "desktop",
    doc: "Unique identifier for this gallery instance"

  def product_thumbnail(assigns) do
    ~H"""
    <div :if={length(@product_pictures_urls_list) > 1} class="py-4">
      <div class="flex flex-wrap gap-3 justify-center">
        <button
          :for={{url, index} <- Enum.with_index(@product_pictures_urls_list)}
          type="button"
          class={[
            "flex-shrink-0 relative overflow-hidden rounded-lg border-2 transition-all duration-200 border-gray-200 hover:border-mint-green/50",
            if(index == 0, do: "thumbnail-active border-mint-green shadow-lg", else: "")
          ]}
          phx-click={
            JS.set_attribute({"src", url}, to: "#main-product-image-#{@gallery_id}")
            |> JS.remove_class("border-mint-green shadow-lg thumbnail-active", to: "button")
            |> JS.add_class("border-gray-200", to: "button")
            |> JS.add_class("border-mint-green shadow-lg thumbnail-active")
          }
        >
          <img
            src={url}
            class="w-16 h-16 object-cover object-center hover:scale-110 transition-transform duration-200"
            alt={"#{@product_name} - Image #{index + 1}"}
          />
          <div class="absolute inset-0 bg-mint-green/10 opacity-0 hover:opacity-100 transition-opacity duration-200">
          </div>
        </button>
      </div>
      <p class="text-xs text-gray-500 mt-2 text-center">Cliquez sur une image pour l'agrandir</p>
    </div>
    """
  end

  @doc """
  A component to render product image gallery with thumbnails

  ## Example:

      <.product_image_gallery
        product_illustration_url="/path/to/main/image.webp"
        product_pictures_urls_list={["/path/to/img1.webp", "/path/to/img2.webp"]}
        product_name="Product Name"
      />
  """
  attr :product_illustration_url, :string,
    default: nil,
    doc: "Main product image URL"

  attr :product_pictures_urls_list, :list,
    default: [],
    doc: "List of all product image URLs for thumbnails"

  attr :product_name, :string, required: true, doc: "Product name for alt text"

  attr :gallery_id, :string,
    default: "desktop",
    doc: "Unique identifier for this gallery instance"

  def product_image_gallery(assigns) do
    ~H"""
    <div
      class="relative flex flex-col items-center"
      phx-hook="ResetImageGallery"
      id={"gallery-#{@gallery_id}"}
      data-original-src={@product_illustration_url}
    >
      <figure :if={@product_illustration_url} class="relative overflow-hidden group">
        <img
          id={"main-product-image-#{@gallery_id}"}
          src={@product_illustration_url}
          class="w-48 h-36 sm:w-56 sm:h-42 lg:w-74 lg:h-58 object-cover object-center rounded-lg shadow-lg transition-transform duration-700 group-hover:scale-105"
          alt={@product_name}
        />
        <div class="absolute inset-0 bg-gradient-to-t from-black/20 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300">
        </div>
      </figure>

      <div :if={!@product_illustration_url} class="flex justify-center">
        <div class="w-48 h-36 sm:w-56 sm:h-42 lg:w-64 lg:h-48 bg-gradient-to-br from-mint-green/10 to-mint-green/5 flex items-center justify-center rounded-lg shadow-lg">
          <div class="text-center text-mint-green/50">
            <.icon name="hero-photo" class="size-8 mx-auto mb-2" />
            <p class="text-sm font-medium">Image non disponible</p>
          </div>
        </div>
      </div>

      <.product_thumbnail
        product_pictures_urls_list={@product_pictures_urls_list}
        product_name={@product_name}
        gallery_id={@gallery_id}
      />
    </div>
    """
  end

  @doc """
  Renders a product status indicator showing availability with color and text

  ## Examples

      <.product_status
        availability_color_class="bg-mint-green"
        availability_comment="Disponible"
        product_stock={10}
      />

      <.product_status
        availability_color_class="bg-brick-orange"
        availability_comment="Temporairement indisponible"
        product_stock={0}
        variant="detailed"
      />
  """
  attr :availability_color_class, :string,
    default: nil,
    doc: "A background color class for the status indicator dot"

  attr :availability_comment, :string,
    default: nil,
    doc: "The availability status text to display"

  attr :variant, :string,
    default: "simple",
    values: ~w(simple detailed),
    doc: "Display variant: 'simple' for compact display, 'detailed' for enhanced styling"

  attr :product_stock, :integer,
    default: nil,
    doc: "How many of this product do you have in your stock ?"

  def product_status(assigns) do
    ~H"""
    <div
      :if={@availability_comment || @product_stock}
      class={[
        "flex flex-col gap-2",
        if(@variant == "detailed", do: "p-4 bg-gray-50 rounded-xl border border-gray-200", else: "")
      ]}
    >
      <div :if={@availability_comment} class="flex items-center gap-3">
        <span
          :if={@availability_color_class}
          class={[
            "rounded-full flex-shrink-0",
            if(@variant == "detailed",
              do: "size-3 ring-2 ring-white shadow-lg",
              else: "size-2.5"
            ),
            @availability_color_class
          ]}
        />
        <span class={[
          "font-medium",
          if(@variant == "detailed", do: "text-sm text-gray-700", else: "text-xs text-gray-600")
        ]}>
          {@availability_comment}
        </span>
      </div>

      <div :if={@product_stock != nil} class="flex items-center gap-3">
        <span class={[
          "rounded-full flex-shrink-0 bg-blue-500",
          if(@variant == "detailed",
            do: "size-3 ring-2 ring-white shadow-lg",
            else: "size-2.5"
          )
        ]}>
        </span>
        <span class={[
          "font-medium",
          if(@variant == "detailed", do: "text-sm text-gray-700", else: "text-xs text-gray-600")
        ]}>
          Stock : {@product_stock}
        </span>
      </div>
    </div>
    """
  end

  @doc """
  Renders basic product information including name, price and unit type.

  ## Examples

      <.product_infos
        product_name="Big watch"
        product_price="1,000.00"
        product_unit_type="item"
      />
  """
  attr :product_name, :string, required: true, doc: "The name of your product"
  attr :product_price, :string, required: true, doc: "The price of your product"

  attr :product_unit_type, :string,
    required: true,
    doc: "The selling unit type (eg: item, m², L, Kg)"

  def product_infos(assigns) do
    ~H"""
    <div class="text-center sm:text-left space-y-4">
      <h1 class="text-2xl sm:text-3xl font-bold leading-tight">
        {@product_name}
      </h1>

      <div class="flex flex-col sm:flex-row sm:items-center gap-4">
        <div class="text-2xl sm:text-3xl font-extrabold text-mint-green">
          {@product_price}€
        </div>
        <div class="text-lg text-gray-600 font-medium">
          / {@product_unit_type}
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders product description with styled layout and fallback message.

  ## Examples

      <.product_description product_description="This is a detailed product description" />

      <.product_description product_description={nil} />
  """
  attr :product_description, :string,
    default: nil,
    doc:
      "An exhaustive description of your product to inform your customer on the product (technical details, etc)"

  def product_description(assigns) do
    ~H"""
    <div class="p-4 space-y-4">
      <div class="flex items-center gap-3 text-mint-green">
        <.icon name="hero-information-circle" class="size-4 flex-shrink-0" />
        <span class="text-xs font-medium">Description</span>
      </div>

      <div :if={@product_description} class="prose prose-xs max-w-none">
        <div class="bg-gradient-to-r from-mint-green/5 to-transparent border-l-2 border-mint-green pl-3 py-2 rounded-r-lg">
          <div class="text-sm leading-relaxed whitespace-pre-wrap break-words">
            {@product_description}
          </div>
        </div>
      </div>

      <div :if={!@product_description} class="text-center py-8 text-gray-500">
        <.icon name="hero-document-text" class="size-12 mx-auto mb-3 opacity-50" />
        <p>Aucune description disponible pour ce produit</p>
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
        to_sell={true}
        to_rent={false}
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

  attr :to_sell, :boolean,
    default: false,
    doc: "Whether the product is available for sale"

  attr :to_rent, :boolean,
    default: false,
    doc: "Whether the product is available for rent"

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
        <div class="hidden sm:block">
          <.product_status_badges to_sell={@to_sell} to_rent={@to_rent} />
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
        <div class="block sm:hidden">
          <.product_status_badges to_sell={@to_sell} to_rent={@to_rent} />
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

  @doc """
  Renders product sale and rental status badges.

  ## Examples

      <.product_status_badges to_sell={true} to_rent={false} />
      <.product_status_badges to_sell={@product.to_sell} to_rent={@product.to_rent} />
      <.product_status_badges to_sell={true} to_rent={true} class="gap-4" />
      <.product_status_badges to_sell={true} to_rent={true} compact />
  """
  attr :to_sell, :boolean, required: true, doc: "Whether the product is available for sale"
  attr :to_rent, :boolean, required: true, doc: "Whether the product is available for rent"

  attr :compact, :boolean,
    default: false,
    doc: "Whether to use compact styling for smaller spaces"

  attr :class, :string, default: "", doc: "Additional CSS classes for the container"

  def product_status_badges(assigns) do
    ~H"""
    <div class={["flex flex-col", (@compact && "gap-1") || "gap-2", @class]}>
      <.single_status_badge
        available={@to_sell}
        compact={@compact}
        color="green"
        text_on={(@compact && "Vente") || "Disponible à la vente"}
        text_off={(@compact && "Pas vente") || "Pas en vente"}
      />
      <.single_status_badge
        available={@to_rent}
        compact={@compact}
        color="blue"
        text_on={(@compact && "Location") || "Disponible en location"}
        text_off={(@compact && "Pas location") || "Pas en location"}
      />
    </div>
    """
  end

  defp single_status_badge(assigns) do
    ~H"""
    <div class={[
      "inline-flex items-center rounded-full font-medium",
      (@compact && "gap-1 px-2 py-1 text-xs") || "gap-2 px-3 py-2 text-sm",
      (@available && @color == "green" && "bg-green-100 text-green-800") ||
        (@available && @color == "blue" && "bg-blue-100 text-blue-800") ||
        "bg-gray-100 text-gray-600"
    ]}>
      <div class={[
        "rounded-full",
        (@compact && "w-1.5 h-1.5") || "w-2 h-2",
        (@available && @color == "green" && "bg-green-500") ||
          (@available && @color == "blue" && "bg-blue-500") ||
          "bg-gray-400"
      ]}>
      </div>
      {(@available && @text_on) || @text_off}
    </div>
    """
  end
end
