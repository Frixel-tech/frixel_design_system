defmodule FrixelDesignSystem.Components.Product do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  attr :sorting, :string,
    default: "new products",
    values: ["new products", "price ascending", "price descending"]

  def sorting_filter(assigns) do
    ~H"""
    <details id="sorting-dropdown" class="dropdown">
      <summary class="btn m-1">Sort by : {@sorting}</summary>
      <ul class="menu dropdown-content bg-base-200 rounded-box z-1 w-52 p-2 shadow-sm">
        <li>
          <a
            phx-click={
              JS.push("sort-by", value: %{sort_by: "price descending"})
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
              JS.push("sort-by", value: %{sort_by: "price ascending"})
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
              JS.push("sort-by", value: %{sort_by: "new products"})
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

  attr :subcategory_path, :string,
    required: true,
    doc: "The subcategories static path, ex: '/subcategory"

  attr :subcategories, :list,
    default: [],
    doc:
      "A list of maps representing subcategories. It should at least have `name` and `illustration_url` keys ; ex: [%{name: 'watches', illustration_url: 'http://url.to/img'}, ...]"

  def subcategory_carousel(assigns) do
    ~H"""
    <div class="carousel carousel-center gap-4 m-auto">
      <.link :for={subcategory <- @subcategories} patch={"#{@subcategory_path}/#{subcategory[:name]}"}>
        <figure class="carousel-item flex-col">
          <img src={subcategory[:illustration_url]} />
          <figcaption class="text-center p-2">{subcategory[:name]}</figcaption>
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

  attr :product, :map,
    required: true,
    doc:
      "A map representing a product. It should at least have `name`, `price` and `illustration_url` keys, but adding a `description` key is great too ; ex: %{name: 'Awesome golden watch', price: '1000.00', illustration_url: 'http://url.to/img', description: 'Description for this awesome golden watch.'}"

  def product_card(assigns) do
    ~H"""
    <div class="card card-xl">
      <%!-- TODO : should change illustration on hover --%>
      <figure>
        <img src={@product[:illustration_url]} />
      </figure>

      <div class="card-body text-center p-4">
        <h3 class="card-title flex-col">{@product[:name]}</h3>
        <p class="text-sm">{@product[:description]}</p>
        <p class="text-sm">{@product[:price]}€</p>
      </div>
    </div>
    """
  end

  attr :product, :map,
    required: true,
    doc:
      "A map representing a product. It should at least have `name`, `price` and `illustration_url` keys, but adding a `description` key is great too ; ex: %{name: 'Awesome golden watch', price: '1000.00', illustration_url: 'http://url.to/img', description: 'Description for this awesome golden watch.'}"

  def product_details(assigns) do
    ~H"""
    <div class="py-4">
      <%!-- TODO: should be a carousel here --%>
      <figure>
        <img src={@product[:illustration_url]} class="w-screen" />
      </figure>

      <div class="p-8">
        <p class="text-sm">{@product[:description]}</p>
      </div>

      <div class="card card-xs fixed bottom-0 w-full border-t border-base-300 rounded-none p-8">
        <div class="card-body flex-row justify-between">
          <div>
            <h2 class="card-title flex-col">{@product[:name]}</h2>
            <p class="text-sm">{@product[:price]}€</p>
          </div>

          <div class="card-actions">
            <button class="btn">Add to cart</button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
