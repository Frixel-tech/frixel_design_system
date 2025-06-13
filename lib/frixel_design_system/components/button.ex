defmodule FrixelDesignSystem.Components.Button do
  use Phoenix.Component

  import FrixelDesignSystemWeb.CoreComponents

  @doc """
  Renders a primary button.

  ## Examples

      <Button.primary_button text="Login" variant="standard" />
      <Button.primary_button text="Login" variant="accent" />
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

      <Button.secondary_button text="Take an appointment" />
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

  @doc """
  Renders a closing "x" button. Used for modals or popups

  ## Example

      <Button.close_button for="my-modal-id" />
  """

  attr(:for, :string,
    required: true,
    doc: "The unique identifier for the modal related to the button"
  )

  def close_button(assigns) do
    ~H"""
    <label
      for={@for}
      class="btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10"
    >
      <.icon name="hero-x-mark-solid" class="size-6" />
    </label>
    """
  end

  @doc """
  Renders a button to go back to the top of the page.

  ## Example:

      <.scroll_to_top_button target_id="anchor-element-id" />
  """
  attr :target_id, :string, required: true, doc: "The ID of the target element to scroll to"

  def scroll_to_top_button(assigns) do
    ~H"""
    <a
      id="scroll-to-top"
      href={"##{@target_id}"}
      data-target-id={@target_id}
      phx-hook="ScrollToTopHook"
      class="fixed z-50 bottom-30 right-8 bg-accent text-white rounded-full shadow-lg p-4 hover:bg-primary transition-colors duration-200 flex items-center justify-center"
      title="Go to landing section"
      style="display:none;"
    >
      <.icon name="hero-chevron-up" class="h-7 w-7" />
    </a>
    """
  end
end
