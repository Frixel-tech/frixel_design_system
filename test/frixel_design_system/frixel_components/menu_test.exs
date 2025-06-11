defmodule FrixelDesignSystem.FrixelComponents.MenuTest do
  alias FrixelDesignSystem.FrixelComponents.Menu
  use ComponentCase
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  test "render a dropdown menu" do
    # Given
    links_list = [
      %{name: "Link #1", visibility: :visible, path: "www.first_path_to_link.fr"},
      %{name: "Link #2", visibility: :visible, path: "www.second_path_to_link.fr"},
      %{name: "Link #3", visibility: :hidden, path: "www.third_path_to_link.fr"},
      %{name: "Link #4", visibility: :visible, path: "www.fourth_path_to_link.fr"}
    ]

    assigns = %{links: links_list}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Menu.dropdown
        id="dropdown-menu"
        class="dropdown dropdown-bottom dropdown-end block xl:hidden"
        links={@links}
      />
      """)}"

    # Then
    assert html =~
             "<div id=\"dropdown-menu\" class=\"dropdown dropdown-bottom dropdown-end block xl:hidden\" phx-click=\"[[&quot;toggle_class&quot;,{&quot;names&quot;:[&quot;swap-active&quot;],&quot;to&quot;:&quot;#dropdown-button&quot;}]]\" phx-click-away=\"[[&quot;remove_class&quot;,{&quot;names&quot;:[&quot;swap-active&quot;],&quot;to&quot;:&quot;#dropdown-button&quot;}]]\">\n  <div id=\"dropdown-button\" tabindex=\"0\" role=\"button\" aria-label=\"Open main menu\" class=\"swap swap-flip btn btn-ghost btn-circle\">\n    <span class=\"hero-bars-3 swap-off size-5\" id=\"icon-open\"></span>\n    <span class=\"hero-x-mark swap-on size-5\" id=\"icon-close\"></span>\n  </div>\n\n  <ul tabindex=\"0\" class=\"menu menu-sm dropdown-content bg-primary w-screen h-fit mt-4 shadow -right-2\">\n    <li>\n      <a href=\"www.first_path_to_link.fr\" class=\"text-xl text-base-100\">\n        Link #1\n      </a>\n    </li><li>\n      <a href=\"www.second_path_to_link.fr\" class=\"text-xl text-base-100\">\n        Link #2\n      </a>\n    </li><li>\n      \n    </li><li>\n      <a href=\"www.fourth_path_to_link.fr\" class=\"text-xl text-base-100\">\n        Link #4\n      </a>\n    </li>\n    <div class=\"flex justify-center my-4\">\n      <a href=\"/#contact-us\" data-phx-link=\"redirect\" data-phx-link-state=\"push\">\n        <button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 flex items-center gap-2\">\n  Contact us\n  <span class=\"hero-arrow-right-solid w-5 h-5\"></span>\n  \n</button>\n      </a>\n    </div>\n  </ul>\n</div>"
  end
end
