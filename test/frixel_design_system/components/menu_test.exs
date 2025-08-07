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
    assert html =~ "Link #1"
    assert html =~ "Link #2"
    refute html =~ "Link #3"
    assert html =~ "Link #4"
  end

  test "render a drawer dropdown menu" do
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
      <Menu.drawer_dropdown links={@links} />
      """)}"

    # Then
    assert html =~ "Link #1"
    assert html =~ "Link #2"
    refute html =~ "Link #3"
    assert html =~ "Link #4"
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

  describe "dropdown_list" do
    test "renders dropdown_list with visible links and dropdown sublinks" do
      # Given
      links = [
        %{name: "About", path: "/about", visibility: :visible},
        %{
          name: "More",
          visibility: :visible,
          dropdown: [
            %{name: "Team", path: "/team", visibility: :visible},
            %{name: "Careers", path: "/careers", visibility: :hidden},
            %{name: "Blog", path: "/blog", visibility: :visible}
          ],
          collections: [
            %{
              path: "/pret-a-porter/été",
              name: "Eté",
              visibility: :visible,
              image_url: "/images/placeholder.png"
            },
            %{
              path: "/pret-a-porter/printemps",
              name: "Printemps",
              visibility: :visible,
              image_url: "/images/placeholder.png"
            },
            %{
              path: "/pret-a-porter/autumn",
              name: "Autumn",
              visibility: :visible,
              image_url: "/images/placeholder.png"
            }
          ]
        },
        %{name: "Contact", path: "/contact", visibility: :visible}
      ]

      assigns = %{links: links, type: "primary"}

      # When
      html =
        "#{rendered_to_string(~H"""
        <Menu.dropdown_list links={@links} type={@type} />
        """)}"

      # Then
      assert html =~ "About"
      assert html =~ "Contact"
      assert html =~ "More"
      assert html =~ "Team"
      # hidden sublink should not be rendered
      refute html =~ "Careers"
      assert html =~ "Blog"
      assert html =~ "link-primary-content"
    end
  end

  describe "auth_menu" do
    test "renders settings and log-out paths when user is connected" do
      assigns = %{
        current_scope: %{},
        current_user_identifier: "test@test.com",
        current_path: "/dashboard",
        log_in_path: "/log-in",
        log_out_path: "/log-out",
        settings_path: "/settings"
      }

      html =
        "#{rendered_to_string(~H"""
        <Menu.auth_menu
          current_scope={@current_scope}
          current_user_identifier={@current_user_identifier}
          current_path={@current_path}
          log_in_path={@log_in_path}
          log_out_path={@log_out_path}
          settings_path={@settings_path}
        />
        """)}"

      assert html =~ "test@test.com"
      assert html =~ "href=\"/settings\""
      assert html =~ "href=\"/log-out\""
      refute html =~ "menu-active"
    end

    test "renders log-in with menu-active class path when user is not connected and is on log-in page" do
      assigns = %{
        current_scope: nil,
        current_user_identifier: "test@test.com",
        current_path: "/log-in",
        log_in_path: "/log-in",
        log_out_path: "/log-out",
        settings_path: "/settings",
        registration_path: "/register"
      }

      html =
        "#{rendered_to_string(~H"""
        <Menu.auth_menu
          current_scope={@current_scope}
          current_user_identifier={@current_user_identifier}
          current_path={@current_path}
          log_in_path={@log_in_path}
          log_out_path={@log_out_path}
          settings_path={@settings_path}
          registration_path={@registration_path}
        />
        """)}"

      refute html =~ "test@test.com"
      assert html =~ "href=\"/log-in\" class=\"menu-active\""
      assert html =~ "href=\"/register\""
    end
  end
end
