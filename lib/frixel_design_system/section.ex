defmodule FrixelDesignSystem.Section do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  alias FrixelDesignSystem.Components.{Button, Company, Form, Header, Menu, Project}
  alias FrixelDesignSystem.Helper

  attr :client_needs, :list, required: true
  attr :client_budgets, :list, required: true
  attr :company_description, :string, required: true
  attr :company_name, :string, required: true
  attr :company_postal_address, :string, required: true
  attr :company_email_address, :string, required: true
  attr :company_phone_number, :string, required: true
  attr :company_social_media_links, :list, required: true
  attr :company_lattitude, :string, required: true
  attr :company_longitude, :string, required: true
  attr :booking_appointment_url, :string, required: true

  def contact_section(assigns) do
    ~H"""
    <section
      id="contact-us"
      class="flex flex-col md:flex-row justify-evenly gap-x-4 lg:gap-x-8 xl:gap-x-16 pt-20"
    >
      <Form.contact_informations
        company_description={Helper.format_text(@company_description)}
        company_name={@company_name}
        company_postal_address={@company_postal_address}
        company_email_address={@company_email_address}
        company_phone_number={@company_phone_number}
        company_social_media_links={@company_social_media_links}
        company_lattitude={@company_lattitude}
        company_longitude={@company_longitude}
      />

      <Form.contact_form
        client_needs={@client_needs}
        client_budgets={@client_budgets}
        booking_appointment_url={@booking_appointment_url}
      />
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

  attr :branding_name, :string
  attr :branding_logo_url, :string
  attr :header_links, :list
  attr :language_links, :list
  attr :call_to_action_name, :string
  attr :call_to_action_path, :string

  def base_header(assigns) do
    ~H"""
    <header
      id="header"
      class="fixed top-0 bg-primary text-primary-content shadow-sm z-1 flex items-center gap-4 justify-between py-4 w-full"
    >
      <nav class="navbar max-w-450 m-auto">
        <div class="navbar-start">
          <Company.branding brand_name={@branding_name} brand_img={@branding_logo_url} />
        </div>

        <div class="navbar-end gap-4 w-full">
          <div class="hidden xl:flex">
            <Menu.links_list type="primary" links={@header_links} />
            <%!-- Pour le moment la traduction des éléments en base ne se fait pas de façon dynamique. Donc pas besoin d'appliquer de la traduction ! --%>
            <%!-- <.scrollable_links type="primary" links={@language_links} /> --%>
            <Menu.theme_switcher />
          </div>

          <div class="hidden xl:flex">
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
            <%!-- <.scrollable_links type="primary" links={@language_links} /> --%>
            <Menu.theme_switcher />
            <Menu.dropdown links={@header_links} />
          </div>
        </div>
      </nav>
    </header>
    """
  end

  attr :branding_name, :string
  attr :branding_logo_url, :string
  attr :header_links, :list
  attr :language_links, :list
  attr :call_to_action_name, :string
  attr :call_to_action_path, :string
  attr :products_links, :list, required: true

  def base_header_commerce(assigns) do
    ~H"""
    <header
      id="header"
      class="fixed top-0 bg-primary text-primary-content shadow-sm z-1 flex items-center gap-4 justify-between py-4 w-full"
    >
      <nav class="flex items-center justify-between w-full relative">
        <div class="navbar-start">
          <Company.branding brand_name={@branding_name} brand_img={@branding_logo_url} />
        </div>

        <div class="navbar-center hidden xl:flex absolute left-1/2 -translate-x-1/2">
          <Menu.dropdown_list label="Menu" type="primary" links={@products_links} />
        </div>

        <div class="navbar-end gap-4 w-full flex justify-end">
          <div class="hidden xl:flex">
            <Menu.theme_switcher />
          </div>

          <div class="hidden xl:flex">
            <.link navigate={@call_to_action_path}>
              <Button.icon_button
                icon="hero-user"
                variant="accent"
                class="flex items-center gap-2 mr-4"
              />
            </.link>
          </div>

          <div class="flex xl:hidden">
            <Menu.theme_switcher />
            <Menu.dropdown links={@header_links} />
          </div>
        </div>
      </nav>
    </header>
    """
  end

  attr :branding_name, :string
  attr :footer_links, :list
  attr :social_medias, :list

  def base_footer(assigns) do
    ~H"""
    <footer class="bg-primary text-base-content shadow-sm relative flex flex-col lg:flex-row items-center justify-between py-4 w-full">
      <nav class="navbar max-w-450 m-auto">
        <div class="navbar-start flex flex-col lg:flex-row items-center gap-4 w-full no-whitespace">
          <div class="flex flex-col lg:flex-row">
            <Menu.links_list links={@footer_links} type="primary" />
            <p class="p-4 text-black">
              Copyright © {@branding_name} {Date.utc_today().year}
            </p>
          </div>
        </div>

        <div class="navbar-center lg:navbar-end flex items-center gap-4 pr-4">
          <Menu.socials_list socials={@social_medias} />
        </div>
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

  attr :title, :string, required: true, doc: "The title to display"
  attr :subtitle, :string, required: true, doc: "The subtitle to display"
  attr :text, :string, required: true, doc: "The text to display"
  attr :img_src, :string, required: true, doc: "The image source to display"

  attr :company_values, :list,
    required: true,
    doc: "A list of values to display in the values cards"

  attr :rest, :global, doc: "Additional attributes for the section element"

  def introduction_section(assigns) do
    ~H"""
    <section id="about" class="pt-20" {@rest}>
      <Header.section_title title={@title} />
      <Company.introduction_card title={@subtitle} text={@text} img_src={@img_src} />
      <Header.section_title title={gettext("Our values in AAA")} />
      <div class="flex items-center justify-center flex-wrap gap-14">
        <%= for company_value <- @company_values do %>
          <Company.company_values_card title={company_value.name} text={company_value.description} />
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
