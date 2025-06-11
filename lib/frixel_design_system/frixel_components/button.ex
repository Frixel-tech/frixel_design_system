defmodule FrixelDesignSystem.FrixelComponents.Button do
  use Phoenix.Component

  import FrixelDesignSystemWeb.CoreComponents

  @doc """
  Renders a primary button.

  ## Examples

      <.primary_button text="Login" variant="standard" />
      <.primary_button text="Login" variant="accent" />
  """
  attr(:text, :string, required: true)

  attr(:icon_button, :string,
    default: nil,
    doc: "The name of the icon to display to the right of the text"
  )

  attr(:class, :string, default: nil)

  attr(:variant, :string,
    values: ~w(standard accent),
    default: "standard",
    doc: "The button style variant"
  )

  attr(:rest, :global)
  slot(:inner_block, required: false)

  def primary_button(assigns) do
    ~H"""
    <button
      class={[
        case @variant do
          "standard" ->
            "flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103"

          "accent" ->
            "flex btn btn-accent mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103"
        end,
        @class
      ]}
      {@rest}
    >
      {@text}
      <.icon :if={@icon_button} name={@icon_button} class="w-5 h-5" />
      {render_slot(@inner_block)}
    </button>
    """
  end

  @doc """
  Renders a secondary button.

  ## Examples

      <.secondary_button text="Take an appointment" />
  """
  attr(:text, :string, required: true)
  attr(:class, :string, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: false)

  attr(:icon_button, :string,
    default: nil,
    doc: "The name of the icon to display to the right of the text"
  )

  def secondary_button(assigns) do
    ~H"""
    <button
      class={[
        "btn btn-outline py-4 px-4 btn-accent text-sm md:text-base transition-transform duration-300 hover:scale-105",
        @class
      ]}
      {@rest}
    >
      {@text}
      <.icon :if={@icon_button} name={@icon_button} class="hidden lg:block ml-2 h-4 w-4" />
      {render_slot(@inner_block)}
    </button>
    """
  end

  attr(:id, :string, required: true, doc: "The unique identifier for the modal")

  def close_button(assigns) do
    ~H"""
    <label
      for={@id}
      class="btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10"
    >
      <.icon name="hero-x-mark-solid" class="size-6" />
    </label>
    """
  end
end
