defmodule FrixelDesignSystem.Components.ButtonTest do
  alias FrixelDesignSystem.Components.Button
  use ComponentCase

  describe "primary_button" do
    test "with standard variant" do
      # Given
      assigns = %{
        text: "Click here",
        icon_button: "hero-arrow-right-solid",
        class: "p-4",
        variant: "standard"
      }

      # When
      html =
        "#{rendered_to_string(~H"""
        <Button.primary_button
          text={@text}
          variant={@variant}
          class={@class}
          icon_button={@icon_button}
          type="button"
        />
        """)}"

      # Then
      assert html =~
               "<button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 p-4\" type=\"button\">\n  Click here\n  <span class=\"hero-arrow-right-solid w-5 h-5\"></span>\n  \n</button>"
    end

    test "with accent variant" do
      # Given
      assigns = %{
        text: "Click here",
        icon_button: "hero-arrow-right-solid",
        class: "p-4",
        variant: "accent"
      }

      # When
      html =
        "#{rendered_to_string(~H"""
        <Button.primary_button
          text={@text}
          variant={@variant}
          class={@class}
          icon_button={@icon_button}
          type="button"
        />
        """)}"

      # Then
      assert html =~
               "<button class=\"flex btn btn-accent mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 p-4\" type=\"button\">\n  Click here\n  <span class=\"hero-arrow-right-solid w-5 h-5\"></span>\n  \n</button>"
    end
  end

  test "secondary_button" do
    # Given
    assigns = %{text: "Click here", icon_button: "hero-arrow-right-solid", class: "p-4"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Button.secondary_button text={@text} class={@class} icon_button={@icon_button} type="button" />
      """)}"

    # Then
    assert html =~
             "<button class=\"btn btn-outline py-4 px-4 btn-accent text-sm md:text-base transition-transform duration-300 hover:scale-105 p-4\" type=\"button\">\n  Click here\n  <span class=\"hero-arrow-right-solid hidden lg:block ml-2 h-4 w-4\"></span>\n  \n</button>"
  end

  test "close_button" do
    # Given
    assigns = %{for: "close-button"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Button.close_button for={@for} />
      """)}"

    # Then
    assert html =~
             "<label for=\"close-button\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>"
  end

  test "scroll_to_top_button" do
    # Given
    assigns = %{target_id: "container-where-srcoll"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Button.scroll_to_top_button target_id={@target_id} />
      """)}"

    # Then
    assert html =~
             "<a id=\"scroll-to-top\" href=\"#container-where-srcoll\" data-target-id=\"container-where-srcoll\" phx-hook=\"ScrollToTopHook\" class=\"fixed z-50 bottom-30 right-8 bg-accent text-white rounded-full shadow-lg p-4 hover:bg-primary transition-colors duration-200 flex items-center justify-center\" title=\"Go to landing section\" style=\"display:none;\">\n  <span class=\"hero-chevron-up h-7 w-7\"></span>\n</a>"
  end

  describe "icon_button" do
    test "renders with standard variant" do
      assigns = %{
        icon: "hero-arrow-right-solid",
        variant: "standard",
        class: "extra-class"
      }

      html =
        "#{rendered_to_string(~H"""
        <Button.icon_button icon={@icon} class={@class}>
          Inner Content
        </Button.icon_button>
        """)}"

      assert html =~ "<span class=\"hero-arrow-right-solid w-5 h-5\"></span>"

      assert html =~
               "<button class=\"flex btn mx-2 p-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 items-center justify-center extra-class\">"

      assert html =~ "Inner Content"
    end

    test "renders with accent variant" do
      assigns = %{
        icon: "hero-arrow-right-solid",
        variant: "accent",
        class: "extra-class"
      }

      html =
        "#{rendered_to_string(~H"""
        <Button.icon_button icon={@icon} class={@class}>
          Accent Content
        </Button.icon_button>
        """)}"

      assert html =~ "<span class=\"hero-arrow-right-solid w-5 h-5\"></span>"
      assert html =~ "Accent Content"
    end
  end
end
