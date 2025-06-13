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
end
