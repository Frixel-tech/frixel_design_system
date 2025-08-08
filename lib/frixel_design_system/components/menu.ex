defmodule FrixelDesignSystem.Components.Menu do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  import FrixelDesignSystemWeb.CoreComponents

  alias FrixelDesignSystem.Components.Button
  alias Phoenix.LiveView.JS

  @doc """
    A navbar component to be used inside a header (such as base_header)

    ## Examples:

         <Menu.navbar
          links={@header.links}
          enable_theme_switcher?={false}
          scrollable_links={@languages_list}
          call_to_action_name="Contact us
          call_to_action_path="/#contact-us"
        />
  """
  attr :links, :list, default: [], doc: "The list of links displayed in the navbar"

  attr :language_links, :list,
    default: nil,
    doc: "The list of languages available in a multilang application"

  attr :enable_theme_switcher?, :boolean,
    default: true,
    doc: "Condition to use or not a dark/light theme switcher"

  attr :call_to_action_path, :string,
    default: nil,
    doc: "the path of the call to action button if you want to display one."

  attr :call_to_action_name, :string,
    default: "",
    doc: "the name displayed inside the call to action button"

  def navbar(assigns) do
    ~H"""
    <div class="hidden xl:flex">
      <Menu.links_list links={@links} />

      <%!-- Pour le moment la traduction des éléments en base ne se fait pas de façon dynamique. Donc pas besoin d'appliquer de la traduction ! --%>
      <%!-- <.scrollable_links  :if={@language_links} type="primary" links={@language_links} /> --%>

      <Menu.theme_switcher :if={@enable_theme_switcher?} />
    </div>

    <div :if={@call_to_action_path} class="hidden xl:flex">
      <.link navigate={@call_to_action_path}>
        <Button.primary_button
          text={@call_to_action_name}
          class="flex items-center gap-2"
          icon_button="hero-arrow-right-solid"
        />
      </.link>
    </div>

    <div class="flex xl:hidden">
      <%!-- Pour le moment la traduction des éléments en base ne se fait pas de façon dynamique. Donc pas besoin d'appliquer dela traduction ! --%>
      <%!-- <.scrollable_links :if={@language_links}  type="primary" links={@language_links} /> --%>

      <Menu.theme_switcher :if={@enable_theme_switcher?} />

      <Menu.dropdown
        links={@links}
        call_to_action_name={@call_to_action_name}
        call_to_action_path={@call_to_action_path}
      />
    </div>
    """
  end

  @doc """
  Renders a mobile navigation menu using DaisyUI's dropdown pattern.

  ## Examples

      <.dropdown links={[
        %{path: "/about", name: "About", visibility: :visible},
        %{path: "/contact", name: "Contact", visibility: :visible}
      ]} />

  - `links`: A list of maps with keys `:path`, `:name`, and `:visibility`.
  """

  attr :links, :list, default: []
  attr :call_to_action_name, :string, default: ""
  attr :call_to_action_path, :string, default: nil

  def dropdown(assigns) do
    ~H"""
    <div
      id="dropdown-menu"
      class="dropdown dropdown-bottom dropdown-end block xl:hidden"
      phx-click={JS.toggle_class("swap-active", to: "#dropdown-button")}
      phx-click-away={JS.remove_class("swap-active", to: "#dropdown-button")}
    >
      <div
        id="dropdown-button"
        tabindex="0"
        role="button"
        aria-label={gettext("Open main menu")}
        class="swap swap-flip btn btn-ghost btn-circle"
      >
        <.icon name="hero-bars-3" id="icon-open" class="swap-off size-5" />
        <.icon name="hero-x-mark" id="icon-close" class="swap-on size-5" />
      </div>

      <ul
        tabindex="0"
        class="menu menu-sm dropdown-content bg-base-100 w-screen h-fit mt-4 shadow -right-2"
      >
        <li :for={link <- @links}>
          <a :if={link.visibility == :visible} href={link.path} class="text-xl">
            {link.name}
          </a>
        </li>

        <div :if={@call_to_action_path} class="flex justify-center my-4">
          <.link navigate={@call_to_action_path}>
            <Button.primary_button
              text={@call_to_action_name}
              class="flex items-center gap-2"
              icon_button="hero-arrow-right-solid"
            />
          </.link>
        </div>
      </ul>
    </div>
    """
  end

  slot(:bottom_content, required: false)

  attr(:links, :list,
    required: true,
    doc: "A list of maps with keys `:path`, `:name`, and `:visibility`"
  )

  @doc """
  Renders a mobile navigation menu using DaisyUI's drawer component.

  ## Examples

      <.drawer_dropdown links={[
        %{path: "/about", name: "About", visibility: :visible},
        %{path: "/contact", name: "Contact", visibility: :visible}
      ]} />

  - `links`: A list of maps with keys `:path`, `:name`, and `:visibility`.
  """
  def drawer_dropdown(assigns) do
    ~H"""
    <div class="drawer block xl:hidden">
      <input id="main-drawer" type="checkbox" class="drawer-toggle" />
      <div class="drawer-content">
        <label
          for="main-drawer"
          class="btn btn-ghost btn-circle drawer-button"
          aria-label={gettext("Open main menu")}
        >
          <.icon name="hero-bars-3" class="size-5" />
        </label>
      </div>
      <div class="drawer-side z-50">
        <label for="main-drawer" aria-label="close sidebar" class="drawer-overlay"></label>
        <ul class="menu bg-base-100 text-base-content min-h-full w-80 p-4">
          <li :for={link <- @links}>
            <a :if={link.visibility == :visible} href={link.path} class="text-xl">
              {link.name}
            </a>
          </li>
          <div class="flex justify-center my-4">
            {render_slot(@bottom_content)}
          </div>
        </ul>
      </div>
    </div>
    """
  end

  @doc """
  Renders a list of links.

  ## Examples

      <.links_list type="primary" links={[
        %{path: "/link-path", name: "About", visibility: :visible},
        %{path: "#home_anchor", name: "Contact", visibility: :hidden},
        %{path: "https://www.external-domain.com", name: "Privacy Policy", visibility: :visible}
      ]} />
  """
  attr(:links, :list, required: true)
  attr(:type, :string, default: "secondary")

  def links_list(assigns) do
    ~H"""
    <ul class="flex flex-col lg:flex-row items-center justify-end">
      <li :for={link <- @links} class="transition-transform duration-300 hover:scale-120">
        <.link
          :if={link.visibility == :visible}
          navigate={link.path}
          class={"text-black rounded-full font-common font-normal p-4 whitespace-nowrap" <> if @type == "primary", do: "link link-primary-content", else: "link link-secondary-content"}
        >
          {link.name}
        </.link>
      </li>
    </ul>
    """
  end

  @doc """
  Renders a dropdown menu with a list of links that can include both simple links and dropdown sections with categories and collections.

  ## Examples

      <.dropdown_list type="primary" links={[
        %{path: "/about", name: "About", visibility: :visible},
        %{
          name: "Products",
          dropdown: [
            %{path: "/category1", name: "Category 1", visibility: :visible},
            %{path: "/category2", name: "Category 2", visibility: :visible}
          ],
          collections: [
            %{path: "/collection1", name: "Collection 1", visibility: :visible, image_url: "/images/collection1.jpg"},
            %{path: "/collection2", name: "Collection 2", visibility: :visible, image_url: "/images/collection2.jpg"}
          ]
        }
      ]} />

  ## Attributes

  - `links`: A list of maps that can contain:
    - Simple links: `%{path: "/path", name: "Name", visibility: :visible}`
    - Dropdown links: `%{name: "Name", dropdown: [...], collections: [...]}`
      - `dropdown`: List of category links with `:path`, `:name`, and `:visibility`
      - `collections`: List of collection items with `:path`, `:name`, `:visibility`, and optional `:image_url`
  - `type`: The link styling type, either "primary" or "secondary"
  """
  attr(:links, :list, required: true)
  attr(:type, :string, default: "secondary", values: ~w"primary secondary")

  def dropdown_list(assigns) do
    ~H"""
    <div class="navbar-center menu menu-horizontal px-1 hidden lg:flex static">
      <li :for={link <- @links} class="static">
        <%= if link[:dropdown] do %>
          <div class="dropdown dropdown-hover dropdown-end block static">
            <div
              tabindex="0"
              role="button"
              class="btn m-1 bg-transparent border-none shadow-none p-0 min-h-0 h-auto"
            >
              <span class="font-common font-normal whitespace-nowrap">
                {link.name}
              </span>
            </div>
            <ul
              tabindex="0"
              class="dropdown-content bg-base-100 absolute w-screen left-[-27px] right-0 p-8 shadow-lg rounded-lg justify-center flex w-full gap-8"
            >
              <div class="w-1/4 py-8">
                <div class="text-gray-400 uppercase text-xs font-normal mb-2 px-2">
                  Catégories
                </div>
                <div class="flex flex-col gap-1">
                  <.link
                    :for={sublink <- link.dropdown}
                    :if={sublink.visibility == :visible}
                    navigate={sublink.path}
                    class="block font-common font-normal px-2 py-1 rounded transition hover:underline"
                  >
                    {sublink.name}
                  </.link>
                </div>
              </div>
              <div class="w-lg py-8">
                <div class="text-gray-400 uppercase text-xs font-normal mb-2">
                  Nos collections
                </div>
                <div class="flex flex-wrap justify-start gap-4">
                  <div :for={collection <- link.collections} class="w-55">
                    <.link
                      :if={collection.visibility == :visible}
                      navigate={collection.path}
                      class="block group"
                    >
                      <div class="overflow-hidden transition-colors duration-200">
                        <img
                          :if={collection[:image_url]}
                          src={collection.image_url}
                          alt={"Icon for #{collection.name}"}
                          class="object-cover w-55 h-30"
                        />
                      </div>
                      <span class="block text-xs px-2 py-1 font-common font-normal text-left group-hover:underline">
                        {collection.name}
                      </span>
                    </.link>
                  </div>
                </div>
              </div>
            </ul>
          </div>
        <% else %>
          <.link
            :if={link.visibility == :visible}
            navigate={link.path}
            class={"font-common font-normal whitespace-nowrap" <>
                if @type == "primary", do: " link link-primary-content", else: " link link-secondary-content"}
          >
            {link.name}
          </.link>
        <% end %>
      </li>
    </div>
    """
  end

  @doc """
  Renders a list of social media logos with links.

  ## Examples

      <.socials_list class="size-4" socials={[
        %{social_media_url: "https://github.com", icon_url: "/images/github_logo.png"},
        %{social_media_url: "https://linkedin.com", icon_url: "/images/linkedin_logo.png"}
      ]} />
  """
  attr(:socials, :list,
    required: true,
    doc: "A list of social media links, where each link is a map"
  )

  attr(:class, :string, default: "", doc: "CSS classes to customize the component.")

  def socials_list(assigns) do
    ~H"""
    <ul class={"flex items-center gap-4 #{@class}"}>
      <li :for={social <- @socials}>
        <a href={social.social_media_url} target="_blank">
          <img
            src={social.icon_url}
            alt={"Logo for #{social.social_media_url}"}
            class="size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110"
          />
        </a>
      </li>
    </ul>
    """
  end

  @doc """
  Adds a light/dark mode selector.
  """
  def theme_switcher(assigns) do
    ~H"""
    <label
      for="theme-toggle"
      id="theme-selector"
      class="swap swap-rotate"
      phx-hook="GetAndStoreThemeHook"
    >
      <input
        type="checkbox"
        id="theme-toggle"
        name="theme-toggle"
        class="theme-controller"
        phx-click={JS.dispatch("set-theme-locally")}
        aria-label={gettext("Toggle theme")}
      />

    <!-- sun icon -->
      <.icon id="sun-icon" class="size-6 text-amber-200" name="hero-sun-solid" />

    <!-- moon icon -->
      <.icon id="moon-icon" class="size-6 text-indigo-900" name="hero-moon-solid" />
    </label>
    """
  end

  @doc """
  Authentication menu for User or Admin connection

  ## Example:

    <.auth_menu
      current_scope={@current_scope}
      current_user_identifier={@current_admin.email}
      current_path={@current_path}
      log_in_path={~p"/backoffice/log-in"}
      log_out_path={~p"/backoffice/log-out"}
      settings_path={~p"/backoffice/settings"}
    />
  """
  attr :current_scope, :map,
    doc: "the session current scope as defined by the router plugs",
    required: true

  attr :current_user_identifier, :string,
    doc: "The user's name or email to display",
    required: true

  attr :current_path, :string,
    doc: "the LiveView current path as defined by the router",
    required: true

  attr :log_in_path, :string, doc: "The route path for log in", required: true
  attr :log_out_path, :string, doc: "The route path for log out", required: true

  attr :settings_path, :string,
    doc: "The route path for user settings",
    default: nil

  attr :registration_path, :string,
    doc: "The route path for user registration",
    default: nil

  def auth_menu(assigns) do
    ~H"""
    <ul class="menu menu-horizontal w-full relative z-10 flex items-center gap-4 px-4 sm:px-6 lg:px-8 justify-end text-secondary-content font-bold">
      <%= if @current_scope do %>
        <li>
          {@current_user_identifier}
        </li>
        <li :if={@settings_path}>
          <.link class={@current_path == @settings_path && "menu-active"} href={@settings_path}>
            {gettext("Settings")}
          </.link>
        </li>
        <li>
          <.link href={@log_out_path} method="delete">Log out</.link>
        </li>
      <% else %>
        <li :if={@registration_path}>
          <.link
            class={@current_path == @registration_path && "menu-active"}
            href={@registration_path}
          >
            {gettext("Register")}
          </.link>
        </li>
        <li>
          <.link class={@current_path == @log_in_path && "menu-active"} href={@log_in_path}>
            {gettext("Log in")}
          </.link>
        </li>
      <% end %>
    </ul>
    """
  end
end
