defmodule FrixelDesignSystem.FrixelComponents.Header do
  use Phoenix.Component

  attr(:title, :string, required: true, doc: "The title to display")
  attr(:class, :string, default: nil, doc: "Additional CSS classes to apply")

  def section_title(assigns) do
    ~H"""
    <h2 class={"text-base-content text-center text-4xl font-slogan font-bold mt-6 mb-6 tracking-widest #{@class}"}>
      {@title}
    </h2>
    """
  end

  attr(:title, :string, required: true, doc: "The title to display")
  attr(:class, :string, default: nil, doc: "Additional CSS classes to apply")

  def card_title(assigns) do
    ~H"""
    <h3 class={"text-xl font-slogan font-bold tracking-widest #{@class}"}>
      {@title}
    </h3>
    """
  end
end
