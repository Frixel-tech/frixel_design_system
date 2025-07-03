defmodule FrixelDesignSystem.Components.Menu do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  import FrixelDesignSystemWeb.CoreComponents

  alias FrixelDesignSystem.Components.Button
  alias Phoenix.LiveView.JS

  attr(:links, :list, required: true)

  @doc """
  Renders a mobile navigation menu using DaisyUI's dropdown pattern.

  ## Examples

      <.dropdown links={[
        %{path: "/about", name: "About", visibility: :visible},
        %{path: "/contact", name: "Contact", visibility: :visible}
      ]} />

  - `links`: A list of maps with keys `:path`, `:name`, and `:visibility`.
  """
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
        <div class="flex justify-center my-4">
          <.link navigate="/#contact-us">
            <Button.primary_button
              text={gettext("Contact us")}
              class="flex items-center gap-2"
              icon_button="hero-arrow-right-solid"
            />
          </.link>
        </div>
      </ul>
    </div>
    """
  end

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
            <.link navigate="/#contact-us">
              <Button.primary_button
                text={gettext("Contact us")}
                class="flex items-center gap-2"
                icon_button="hero-arrow-right-solid"
              />
            </.link>
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
  Renders a dropdown menu with a list of links.

  ## Examples

      <.dropdown_list label="Menu" type="primary" links={[
        %{path: "/about", name: "About", visibility: :visible},
        %{path: "/contact", name: "Contact", visibility: :visible}
      ]} />

  """
  attr(:links, :list, required: true)
  attr(:type, :string, default: "secondary", values: ~w"primary secondary")

  def dropdown_list(assigns) do
    ~H"""
    <div class="navbar-center hidden lg:flex">
      <ul class="menu menu-horizontal px-1">
        <li :for={link <- @links}>
          <%= if link[:dropdown] do %>
            <div class="dropdown dropdown-hover relative">
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
                class="dropdown-content menu bg-base-100 rounded-box z-50 w-130 p-2 shadow-sm fixed left-0 top-0"
              >
                <li :for={sublink <- link.dropdown}>
                  <.link
                    :if={sublink.visibility == :visible}
                    navigate={sublink.path}
                    class={"font-common font-normal whitespace-nowrap" <>
                      if @type == "primary", do: " link-primary-content", else: " link-secondary-content"}
                  >
                    {sublink.name}
                  </.link>
                </li>
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
      </ul>
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
end
