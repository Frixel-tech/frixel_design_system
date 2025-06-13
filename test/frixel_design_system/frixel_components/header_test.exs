defmodule FrixelDesignSystem.Components.HeaderTest do
  alias FrixelDesignSystem.Components.Header
  use ComponentCase

  test "section_title" do
    # Given
    assigns = %{title: "title here", class: "flex text-center"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Header.section_title title={@title} class={@class} />
      """)}"

    # Then
    assert html =~
             "<h2 class=\"text-base-content text-center text-4xl font-slogan font-bold mt-6 mb-6 tracking-widest flex text-center\">\n  title here\n</h2>"
  end

  test "card_title" do
    # Given
    assigns = %{title: "title here", class: "flex text-center"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Header.card_title title={@title} class={@class} />
      """)}"

    # Then
    assert html =~
             "<h3 class=\"text-xl font-slogan font-bold tracking-widest flex text-center\">\n  title here\n</h3>"
  end

  test "card_subtitle" do
    # Given
    assigns = %{subtitle: "subtitle here"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Header.card_subtitle subtitle={@subtitle} />
      """)}"

    # Then
    assert html =~
             "<h4 class=\"font-title font-bold text-center xl:text-left pt-4 pb-8 tracking-wider\">\n  subtitle here\n</h4>"
  end
end
