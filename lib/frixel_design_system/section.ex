defmodule FrixelDesignSystem.Section do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  alias FrixelDesignSystem.Components.{Button, Company, Form, Header, Menu, Project}

  @doc """
  Section to contain contact informations and contact form components.

  ## Example:

        <Section.contact_section>
          <:contact_infos>
            <Company.contact_informations title="Find us">
              <:contact_details>
                <Company.contact_details
                  company_name="My Company"
                  company_description="We are awesome"
                  company_postal_address="1 Industry street, Business City"
                  company_email_address="contact@company.com"
                  company_phone_number="+1234567890"
                />
              </:contact_details>

              <:socials>
                <Menu.socials_list socials={@social_links_list} is_icon_rounded?={false} class="py-4" />
              </:socials>

              <:map>
                <Company.find_us_map
                  company_lattitude="2.2345"
                  company_longitude="4.12345678
                  marker_icon_url="/path/to/my/company/icon.mini"
                />
              </:map>
            </Company.contact_informations>
          </:contact_infos>

          <:contact_form>
            <Form.contact_form
              title="My form"
              client_needs={["website", "design", "e-commerce", "mobile app"]}
              client_budgets={["<5.000", "<10.000", "<20.000", "<50.000"]}
              booking_appointment_url="http://calendly.com/contact-me"
              phx-submit="submit_contact_form"
            />
          </:contact_form>
        </Section.contact_section>
  """
  slot :contact_infos
  slot :contact_form
  slot :map

  def contact_section(assigns) do
    ~H"""
    <section
      id="contact-us"
      class="md:grid md:grid-cols-2 md:gap-4 lg:gap-8 xl:gap-16 pt-20"
    >
      {render_slot(@contact_infos)}

      {render_slot(@contact_form)}

      {render_slot(@map)}
    </section>
    """
  end

  @doc """
  Renders a review section containing only the client form.
  """

  def client_section(assigns) do
    ~H"""
    <section class="my-16 max-w-xl mx-auto">
      <div class="card bg-base-200 shadow-xl py-6 px-8">
        <div class="flex items-center justify-between mb-8">
          <Header.card_title title={gettext("Leave a review")} />
        </div>
        <Form.client_review_form />
      </div>
    </section>
    """
  end

  @doc """
  A header section to handle branding and navigation

  ## Example:

      <.base_header class="bg-white text-marine-blue border-b border-brick-orange">
        <:branding>
          <Company.branding
            brand_name="My Business"
            brand_img="/path/to/my/logo.png"
          />
        </:branding>

        <:navbar>
          <Menu.navbar links={@links_list} enable_theme_switcher?={true} />
        </:navbar>
      </.base_header>
  """

  attr :class, :string, default: ""
  slot :branding
  slot :navbar

  def base_header(assigns) do
    ~H"""
    <header
      id="header"
      class={"fixed top-0 left-0 shadow-sm z-1 flex items-center gap-4 justify-between py-4 w-full #{@class}"}
    >
      <nav class="navbar max-w-450 m-auto">
        <div class="navbar-start">
          {render_slot(@branding)}
        </div>

        <div class="navbar-end gap-4 w-full">
          {render_slot(@navbar)}
        </div>
      </nav>
    </header>
    """
  end

  defp find_action_path(call_to_actions, type) do
    Enum.find_value(call_to_actions, fn action ->
      if action.type == type, do: action.path
    end)
  end

  @doc """
  Renders the main header for commerce pages.

  ## Example

      <.base_header_commerce
        branding_name="Frixel"
        branding_logo_url="/images/logo.png"
        header_links={@header_links}
        call_to_action_name="Sign in"
        call_to_action_path="/login"
        class="fixed top-0 left-0 right-0 bg-primary text-primary-content shadow-sm z-1 flex flex-col items-center py-4 w-full relative m-0"
      />

  - `branding_name`: The name of the brand to display
  - `branding_logo_url`: The logo image URL
  - `header_links`: List of header links
  - `call_to_action_name`: Text for the call-to-action button
  - `call_to_action_path`: Path for the call-to-action button
  - `class`: Additional CSS classes for the header (required for layout)
  """

  attr :branding_name, :string
  attr :branding_logo_url, :string
  attr :header_links, :list, required: true
  attr :call_to_actions, :list, required: true, doc: "List of call to action links"
  attr :call_to_action_path, :string
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply to the header"
  attr :is_connected, :boolean, default: false, doc: "Indicates if the user is connected"
  attr :is_admin, :boolean, default: false, doc: "Indicates if the user is an admin"
  attr :user_email, :string, default: nil, doc: "The email of the connected user"

  def base_header_commerce(assigns) do
    assigns =
      assigns
      |> assign(:admin_settings_path, find_action_path(assigns.call_to_actions, :admin_settings))
      |> assign(:admin_logout_path, find_action_path(assigns.call_to_actions, :admin_logout))
      |> assign(:settings_path, find_action_path(assigns.call_to_actions, :settings))
      |> assign(:logout_path, find_action_path(assigns.call_to_actions, :logout))
      |> assign(:login_path, find_action_path(assigns.call_to_actions, :login))

    ~H"""
    <header id="header" class={@class}>
      <nav class="absolute top-4 right-4 flex items-center gap-4">
        <div class="hidden xl:flex">
          <%= if @is_connected and @user_email do %>
            <span class="text-sm font-medium px-2 py-1 mr-4">{@user_email}</span>
          <% end %>
          <Menu.theme_switcher />
        </div>

        <div class="hidden xl:flex">
          <%= if @is_connected do %>
            <%= if @is_admin do %>
              <.link navigate={@admin_settings_path}>
                <Button.icon_button icon="hero-cog-6-tooth" class="flex items-center gap-2" />
              </.link>
              <.link href={@admin_logout_path} method="delete">
                <Button.icon_button
                  icon="hero-arrow-left-start-on-rectangle"
                  class="flex items-center gap-2"
                />
              </.link>
            <% else %>
              <.link navigate={@settings_path}>
                <Button.icon_button icon="hero-cog-6-tooth" class="flex items-center gap-2" />
              </.link>
              <.link href={@logout_path} method="delete">
                <Button.icon_button
                  icon="hero-arrow-left-start-on-rectangle"
                  class="flex items-center gap-2"
                />
              </.link>
            <% end %>
          <% else %>
            <.link navigate={@login_path}>
              <Button.icon_button icon="hero-user" class="flex items-center gap-2" />
            </.link>
          <% end %>

          <.link navigate={find_action_path(@call_to_actions, :cart)}>
            <Button.icon_button icon="hero-shopping-bag" class="flex items-center gap-2" />
          </.link>
        </div>

        <div class="flex xl:hidden">
          <Menu.theme_switcher />
          <Menu.drawer_dropdown links={@header_links} />
        </div>
      </nav>

      <div class="w-full flex flex-col items-center justify-center mb-4 gap-2 static">
        <Company.branding brand_name={@branding_name} brand_img={@branding_logo_url} />
        <Menu.dropdown_list type="primary" links={@header_links} />
      </div>
    </header>
    """
  end

  attr :class, :string, default: ""
  attr :socials_title, :string, default: nil
  slot :contact
  slot :socials
  slot :legal

  def base_footer(assigns) do
    ~H"""
    <footer
      id="footer"
      class={"footer footer-horizontal footer-center py-4 #{@class}"}
    >
      <aside class="flex justify-center flex-wrap gap-8">
        {render_slot(@contact)}
      </aside>

      <nav>
        <h6 :if={@socials_title} class="footer-title">{@socials_title}</h6>
        {render_slot(@socials)}
      </nav>

      <nav class="flex justify-center flex-wrap px-4">
        {render_slot(@legal)}
      </nav>
    </footer>
    """
  end

  attr :title, :string, required: true, doc: "The title to display in the landing section"
  attr :text, :string, required: true, doc: "The main text to display in the landing section"
  attr :subtext, :string, required: true, doc: "The subtext to display in the landing section"
  attr :logo_src, :string, required: true, doc: "The source URL for the logo image"
  attr :link_name, :string, required: true, doc: "The name of the link"
  attr :link_path, :string, required: true, doc: "The path of the link"
  attr :call_to_action_name, :string, required: true, doc: "call to action name"
  attr :call_to_action_path, :string, required: true, doc: "call to action path"
  attr :tools, :list, required: true, doc: "A list of tools to display in the landing section"

  def landing_section(assigns) do
    ~H"""
    <section
      id="landing-section"
      phx-hook="LandingAnimationHook"
      class="relative flex justify-center items-center max-w-2xl text-center mx-auto invisible"
    >
      <div class="content relative z-1">
        <figure class="flex justify-center mb-6">
          <img src={@logo_src} alt="Logo" class="h-34 w-34 object-contain rounded-2xl shadow-xl" />
        </figure>

        <h2 class="max-w-sm sm:max-w-none text-5xl sm:text-6xl font-bold font-title mx-auto pt-10 pb-15 mb-6 text-shadow-lg">
          {@title}
        </h2>

        <p class="text-base font-common mb-12">{@text}</p>

        <p class="text-base font-common font-bold">{@subtext}</p>

        <Project.tools_list class="my-8" tools={@tools} />

        <div class="flex flex-col lg:flex-row justify-center items-center gap-4 mb-4">
          <.link navigate={@call_to_action_path}>
            <Button.primary_button
              variant="accent"
              text={@call_to_action_name}
              icon_button="hero-arrow-right-solid"
            />
          </.link>

          <.link
            navigate={@link_path}
            class="underline text-xl font-slogan text-accent hover:text-primary"
          >
            {@link_name}
          </.link>
        </div>
      </div>
    </section>
    """
  end

  attr :services, :list, required: true, doc: "A list of skills to display as cards"
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply"

  def services_section(assigns) do
    ~H"""
    <section id="services" class="px-12 pt-20">
      <Header.section_title title={gettext("Our services")} class="pb-12" />
      <div class="flex justify-center flex-wrap gap-16">
        <%= for service <- @services do %>
          <Company.service_card
            modal_id={"service_modal_#{service.id}"}
            logo={service.logo}
            name={service.name}
            description={service.description}
          />
        <% end %>
      </div>
    </section>
    """
  end

  attr :section_title, :string, default: nil, doc: "The section title to display"
  attr :card_title, :string, default: nil, doc: "The card title to display"
  attr :text, :string, default: nil, doc: "The text to display"
  attr :img_src, :string, default: nil, doc: "The image source to display"

  attr :card_class, :string,
    default: "",
    doc: "The CSS classes to put style into your introduction card"

  attr :rest, :global, doc: "Additional attributes for the section element"

  def introduction_section(assigns) do
    ~H"""
    <section id="about" class="pt-20" {@rest}>
      <Header.section_title :if={@section_title} title={@section_title} />

      <Company.introduction_card
        title={@card_title}
        text={@text}
        img_src={@img_src}
        class={@card_class}
      />
    </section>
    """
  end

  attr :title, :string, default: nil, doc: "The title to display"

  attr :company_values, :list,
    required: true,
    doc: "A list of values to display in the values cards"

  attr :card_class, :string,
    default: "",
    doc: "The CSS classes to put style into your introduction card"

  def values_section(assigns) do
    ~H"""
    <section id="values">
      <Header.section_title :if={@title} title={@title} />

      <div
        class="flex items-stretch justify-center flex-wrap gap-14"
        phx-hook="DelayedFadeInAnimationHook"
        id="value-cards-container"
      >
        <%= for company_value <- @company_values do %>
          <Company.company_values_card
            title={company_value.name}
            text={company_value.description}
            class={"invisible #{@card_class}"}
          />
        <% end %>
      </div>
    </section>
    """
  end

  attr :reviews, :list, required: true

  def review_section(assigns) do
    ~H"""
    <section :if={@reviews != []} class="my-16">
      <Header.section_title title={gettext("What our clients say")} />
      <div class="flex items-center justify-center flex-wrap gap-14">
        <%= for review <- @reviews do %>
          <Company.review_card review={review} />
        <% end %>
      </div>
    </section>
    """
  end

  attr :title, :string, required: true, doc: "The section title"
  attr :description, :string, required: true, doc: "The section description"

  attr :team_members, :list,
    required: true,
    doc: "A list of employees with their names and images"

  attr :skills, :list, required: true, doc: "A list of skills to display as cards"

  def story_section(assigns) do
    ~H"""
    <section class="mt-20">
      <div>
        <Header.section_title title={@title} />

        <p class="font-common text-base mt-2 xl:px-60">
          {@description}
        </p>
      </div>

      <div class="mt-26 flex flex-col xl:flex-row items-center justify-center mx-5">
        <Company.trombinoscope team_members={@team_members} />
      </div>
    </section>
    """
  end

  attr :projects, :list, required: true, doc: "A list of projects to display"

  def projects_section(assigns) do
    ~H"""
    <section
      id="projects"
      class="flex flex-col justify-center items-center gap-4 w-full items-stretch pt-20 relative"
    >
      <Header.section_title title={gettext("Our projects")} />

      <div class="flex flex-col md:flex-row flex-wrap gap-4 justify-center items-center">
        <%= for project <- @projects do %>
          <Project.project_card
            project_id={"project-#{project.id}"}
            image_sources_list={project.illustration_urls}
            title={project.name}
            short_description={project.short_description}
            long_description={project.long_description}
            tags={project.tags}
            link={project.project_url}
            contributors={project.participants}
            tools={project.tools}
          />
        <% end %>
      </div>
    </section>
    """
  end
end
