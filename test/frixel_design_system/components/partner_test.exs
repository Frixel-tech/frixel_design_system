defmodule FrixelDesignSystem.Components.PartnerTest do
  alias FrixelDesignSystem.Components.Partner
  use ComponentCase

  describe "brand_showcase_card" do
    test "renders brand card with logo and hover effects" do
      assigns = %{
        brand_name: "Test Company",
        logo_url: "https://example.com/logo.png",
        alt_text: "Test Company Logo",
        class: "custom-class"
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_card
          brand_name={@brand_name}
          logo_url={@logo_url}
          alt_text={@alt_text}
          class={@class}
        />
        """)}"

      assert html =~ "group flex items-center justify-center mt-12"
      assert html =~ "bg-white/80 backdrop-blur-sm rounded-2xl"
      assert html =~ "hover:border-mint-green/30 transition-all duration-500"
      assert html =~ "hover:scale-105 hover:-translate-y-2"
      assert html =~ "src=\"https://example.com/logo.png\""
      assert html =~ "alt=\"Test Company Logo\""
      assert html =~ "filter grayscale group-hover:grayscale-0"
      assert html =~ "custom-class"
    end

    test "renders brand card without custom class" do
      assigns = %{
        brand_name: "Another Company",
        logo_url: "https://example.com/another-logo.png",
        alt_text: "Another Company Logo"
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_card
          brand_name={@brand_name}
          logo_url={@logo_url}
          alt_text={@alt_text}
        />
        """)}"

      assert html =~ "src=\"https://example.com/another-logo.png\""
      assert html =~ "alt=\"Another Company Logo\""
      assert html =~ "h-28 lg:h-32"
      refute html =~ "custom-class"
    end
  end

  describe "brand_showcase_title" do
    test "renders title with description and underline" do
      assigns = %{
        title: "Ils nous ont fait confiance",
        description: "Des partenaires de confiance qui nous accompagnent dans notre mission.",
        id: "partners-title",
        class: "mb-16"
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_title
          title={@title}
          description={@description}
          id={@id}
          class={@class}
        />
        """)}"

      assert html =~ "id=\"partners-title\""
      assert html =~ "mb-16"
      assert html =~ "phx-hook=\"FadeInAnimationHook\""
      assert html =~ "text-4xl lg:text-5xl font-title font-bold text-marine-blue"
      assert html =~ "Ils nous ont fait confiance"
      assert html =~ "Des partenaires de confiance qui nous accompagnent dans notre mission."
      assert html =~ "bg-gradient-to-r from-mint-green to-brick-orange rounded-full"
    end

    test "renders title without description" do
      assigns = %{
        title: "Nos Services"
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_title title={@title} />
        """)}"

      assert html =~ "Nos Services"
      assert html =~ "text-center mb-8"
      assert html =~ "phx-hook=\"FadeInAnimationHook\""
      refute html =~ "<p"
    end

    test "renders title without underline when disabled" do
      assigns = %{
        title: "Test Title",
        underline: false
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_title title={@title} underline={@underline} />
        """)}"

      assert html =~ "Test Title"
      refute html =~ "bg-gradient-to-r from-mint-green to-brick-orange"
    end

    test "renders with custom classes" do
      assigns = %{
        title: "Custom Title",
        title_class: "text-6xl font-custom",
        description_class: "text-xl text-custom",
        description: "Custom description"
      }

      html =
        "#{rendered_to_string(~H"""
        <Partner.brand_showcase_title
          title={@title}
          description={@description}
          title_class={@title_class}
          description_class={@description_class}
        />
        """)}"

      assert html =~ "text-6xl font-custom"
      assert html =~ "text-xl text-custom"
      assert html =~ "Custom Title"
      assert html =~ "Custom description"
    end
  end
end
