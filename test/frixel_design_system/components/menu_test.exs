defmodule FrixelDesignSystem.Components.MenuTest do
  alias FrixelDesignSystem.Components.Menu
  use ComponentCase

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

  describe "links_list" do
    test "when type is primary" do
      # Given
      links_list = [
        %{name: "Link #1", visibility: :visible, path: "www.first_path_to_link.fr"},
        %{name: "Link #3", visibility: :hidden, path: "www.third_path_to_link.fr"},
        %{name: "Link #4", visibility: :visible, path: "www.fourth_path_to_link.fr"}
      ]

      assigns = %{links: links_list, type: "primary"}

      # When
      html =
        "#{rendered_to_string(~H"""
        <Menu.links_list id="dropdown-menu" type={@type} links={@links} />
        """)}"

      # Then
      assert html =~
               "<ul class=\"flex flex-col lg:flex-row items-center justify-end\">\n  <li class=\"transition-transform duration-300 hover:scale-120\">\n    <a href=\"www.first_path_to_link.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\" class=\"text-black rounded-full font-common font-normal p-4 whitespace-nowraplink link-primary-content\">\n      Link #1\n    </a>\n  </li><li class=\"transition-transform duration-300 hover:scale-120\">\n    \n  </li><li class=\"transition-transform duration-300 hover:scale-120\">\n    <a href=\"www.fourth_path_to_link.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\" class=\"text-black rounded-full font-common font-normal p-4 whitespace-nowraplink link-primary-content\">\n      Link #4\n    </a>\n  </li>\n</ul>"
    end

    test "when type is secondary" do
      # Given
      links_list = [
        %{name: "Link #1", visibility: :visible, path: "www.first_path_to_link.fr"},
        %{name: "Link #3", visibility: :hidden, path: "www.third_path_to_link.fr"},
        %{name: "Link #4", visibility: :visible, path: "www.fourth_path_to_link.fr"}
      ]

      assigns = %{links: links_list, type: "secondary"}

      # When
      html =
        "#{rendered_to_string(~H"""
        <Menu.links_list id="dropdown-menu" type={@type} links={@links} />
        """)}"

      # Then
      assert html =~
               "<ul class=\"flex flex-col lg:flex-row items-center justify-end\">\n  <li class=\"transition-transform duration-300 hover:scale-120\">\n    <a href=\"www.first_path_to_link.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\" class=\"text-black rounded-full font-common font-normal p-4 whitespace-nowraplink link-secondary-content\">\n      Link #1\n    </a>\n  </li><li class=\"transition-transform duration-300 hover:scale-120\">\n    \n  </li><li class=\"transition-transform duration-300 hover:scale-120\">\n    <a href=\"www.fourth_path_to_link.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\" class=\"text-black rounded-full font-common font-normal p-4 whitespace-nowraplink link-secondary-content\">\n      Link #4\n    </a>\n  </li>\n</ul>"
    end
  end

  test "socials_list" do
    # Given
    socials_links_list = [
      %{social_media_url: "https://github.com", icon_url: "/images/github_logo.png"},
      %{social_media_url: "https://linkedin.com", icon_url: "/images/linkedin_logo.png"}
    ]

    assigns = %{socials: socials_links_list, class: "p-36 w-32"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Menu.socials_list class={@class} socials={@socials} />
      """)}"

    # Then
    assert html =~
             "<ul class=\"flex items-center gap-4 p-36 w-32\">\n  <li>\n    <a href=\"https://github.com\" target=\"_blank\">\n      <img src=\"/images/github_logo.png\" alt=\"Logo for https://github.com\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li><li>\n    <a href=\"https://linkedin.com\" target=\"_blank\">\n      <img src=\"/images/linkedin_logo.png\" alt=\"Logo for https://linkedin.com\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li>\n</ul>"
  end

  test "theme_switcher" do
    # Given
    assigns = %{}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Menu.theme_switcher />
      """)}"

    # Then
    assert html =~
             "<label for=\"theme-toggle\" id=\"theme-selector\" class=\"swap swap-rotate\" phx-hook=\"GetAndStoreThemeHook\">\n  <input type=\"checkbox\" id=\"theme-toggle\" name=\"theme-toggle\" class=\"theme-controller\" phx-click=\"[[&quot;dispatch&quot;,{&quot;event&quot;:&quot;set-theme-locally&quot;}]]\" aria-label=\"Toggle theme\">\n  \n<!-- sun icon -->\n  <span class=\"hero-sun-solid size-6 text-amber-200\" id=\"sun-icon\"></span>\n  \n<!-- moon icon -->\n  <span class=\"hero-moon-solid size-6 text-indigo-900\" id=\"moon-icon\"></span>\n</label>"
  end
end
