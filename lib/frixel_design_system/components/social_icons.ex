defmodule FrixelDesignSystem.Components.SocialIcons do
  use Phoenix.Component

  def social_icon(assigns), do: apply(__MODULE__, assigns.name, [assigns])

  attr :rest, :global,
    default: %{
      "aria-hidden": "true",
      fill: "none",
      width: "24",
      height: "24",
      viewBox: "0 0 24 24",
      stroke: "currentColor",
      "stroke-width": "2",
      "stroke-linecap": "round",
      "stroke-linejoin": "round"
    },
    include:
      ~w(aria-hidden width height viewBox fill stroke stroke-width stroke-linecap stroke-linejoin)

  slot :inner_block, required: true

  defp svg(assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" {@rest}>
      <%= render_slot(@inner_block) %>
    </svg>
    """
  end

  attr(:rest, :global)

  def github(assigns) do
    ~H"""
    <.svg {@rest}>
    </.svg>
    """
  end

  attr(:rest, :global)

  def linkedin(assigns) do
    ~H"""
    <.svg {@rest}>
    </.svg>
    """
  end

  attr(:rest, :global)

  def instagram(assigns) do
    ~H"""
    <.svg {@rest}>
    </.svg>
    """
  end

  attr(:rest, :global)

  def whatsapp(assigns) do
    ~H"""
    <.svg {@rest}>
    </.svg>
    """
  end
end
