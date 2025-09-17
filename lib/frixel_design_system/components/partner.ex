defmodule FrixelDesignSystem.Components.Partner do
  use Phoenix.Component

  @doc """
  Renders a brand card with logo and hover effects.

  ## Examples

      <.brand_card
        brand_name="Company Name"
        logo_url="/path/to/logo.png"
        alt_text="Company Name Logo"
      />
  """
  attr :brand_name, :string, required: true
  attr :logo_url, :string, required: true
  attr :alt_text, :string, required: true
  attr :class, :string, default: ""

  def brand_showcase_card(assigns) do
    ~H"""
    <div class={[
      "group flex items-center justify-center mt-12 p-6 lg:p-8 bg-white/80 backdrop-blur-sm rounded-2xl shadow-md hover:shadow-lg border border-gray-100 hover:border-mint-green/30 transition-all duration-500 hover:scale-105 hover:-translate-y-2 h-28 lg:h-32",
      @class
    ]}>
      <div class="relative w-full h-full flex items-center justify-center overflow-hidden">
        <img
          src={@logo_url}
          alt={@alt_text}
          class="max-h-16 lg:max-h-20 max-w-full object-contain filter grayscale group-hover:grayscale-0 transition-all duration-500"
        />
      </div>
    </div>
    """
  end

  @doc """
  Renders a section title with optional description and decorative underline.

  ## Examples

      <.showcase_title title="Nos Services" />
      <.showcase_title
        title="Ils nous ont fait confiance"
        description="Des partenaires de confiance qui nous accompagnent dans notre mission."
      />
      <.showcase_title
        title="Contact"
        description="N'hésitez pas à nous contacter"
        id="contact-title"
        class="mb-20"
      />
  """
  attr :title, :string, required: true
  attr :description, :string, default: nil
  attr :id, :string, default: nil
  attr :class, :string, default: "text-center mb-8"

  attr :title_class, :string,
    default:
      "text-4xl lg:text-5xl font-title font-bold text-marine-blue mb-6 relative inline-block"

  attr :description_class, :string,
    default: "text-lg text-gray-600 max-w-2xl mx-auto leading-relaxed"

  attr :underline, :boolean, default: true

  def brand_showcase_title(assigns) do
    ~H"""
    <div
      id={@id}
      class={[@class]}
      phx-hook="FadeInAnimationHook"
    >
      <h2 class={@title_class}>
        {@title}
        <div
          :if={@underline}
          class="absolute -bottom-2 left-1/2 transform -translate-x-1/2 w-20 h-1 bg-gradient-to-r from-mint-green to-brick-orange rounded-full"
        >
        </div>
      </h2>
      <p :if={@description} class={@description_class}>
        {@description}
      </p>
    </div>
    """
  end
end
