defmodule FrixelDesignSystem.FrixelComponents.Menu do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  import FrixelDesignSystemWeb.CoreComponents

  alias FrixelDesignSystem.FrixelComponents.Button
  alias Phoenix.LiveView.JS

  attr(:links, :list, required: true)

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
        class="menu menu-sm dropdown-content bg-primary w-screen h-fit mt-4 shadow -right-2"
      >
        <li :for={link <- @links}>
          <a :if={link.visibility == :visible} href={link.path} class="text-xl text-base-100">
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
end
