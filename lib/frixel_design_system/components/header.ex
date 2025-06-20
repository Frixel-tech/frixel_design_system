defmodule FrixelDesignSystem.Components.Header do
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

  attr(:subtitle, :string, required: true, doc: "The subtitle to display")
  attr(:class, :string, default: nil, doc: "Additional CSS classes to apply")

  def card_subtitle(assigns) do
    ~H"""
    <h4 class={"font-title font-bold text-center xl:text-left pt-4 pb-8 tracking-wider #{@class}"}>
      {@subtitle}
    </h4>
    """
  end
end
