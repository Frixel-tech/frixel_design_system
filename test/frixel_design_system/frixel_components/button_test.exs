defmodule FrixelDesignSystem.FrixelComponents.ButtonTest do
  alias FrixelDesignSystem.FrixelComponents.Button
  use ComponentCase

  test "primary_button" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <Button.primary_button
        text="Click here"
        variant="standard"
        class="p-4"
        icon_button="hero-arrow-right-solid"
        type="button"
      />
      """)

    assert html =~ "<button"
    assert html =~ "btn btn-secondary"
    assert html =~ "Click here"
    assert html =~ "p-4"
    assert html =~ "<span class=\"hero-arrow-right-solid"
    assert html =~ "type=\"button\""
  end

  test "secondary_button" do
    assigns = %{}

    html =
      rendered_to_string(~H"""
      <Button.secondary_button
        text="Click here"
        class="p-4"
        icon_button="hero-arrow-right-solid"
        type="button"
      />
      """)

    assert html =~ "<button"
    assert html =~ "btn btn-outline"
    assert html =~ "Click here"
    assert html =~ "p-4"
    assert html =~ "<span class=\"hero-arrow-right-solid"
    assert html =~ "type=\"button\""
  end
end
