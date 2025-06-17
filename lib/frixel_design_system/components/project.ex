defmodule FrixelDesignSystem.Components.Project do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext

  import FrixelDesignSystemWeb.CoreComponents

  alias FrixelDesignSystem.Components.{Button, Header}
  alias FrixelDesignSystem.Helper

  @doc """
  Renders a project card to be used in a project gallery or a portfolio.

  ## Example:

      <.project_card
        project_id="your-project-id"
        image_sources_list="path/to/your/project/illustration.webp"
        title="Your Project Name"
        short_description="One sentence to pitch your project"
        long_description="A bigger paragraph to describe your project in details."
        tags={["Elixir", "Phoenix", "Ecto", "Absinthe"]}
        link="http://production_project.url"
        contributors={@project_contributors_list}
        tools={@project_tools_list}
      />
  """
  attr :image_sources_list, :list,
    required: true,
    doc: "The list of source URLs for the project images"

  attr :title, :string, required: true, doc: "The title of the project"

  attr :short_description, :string,
    required: true,
    doc: "The short description text of the project"

  attr :long_description, :string, required: true, doc: "The long description text of the project"

  attr :tags, :list,
    default: [],
    doc: "A list of keywords to display below the image"

  attr :project_id, :string, required: true, doc: "The unique identifier for the project"
  attr :link, :string, default: nil, doc: "The link for the project"

  attr :contributors, :list,
    default: [],
    doc: "A list of contributors with their names and images"

  attr :tools, :list,
    default: [],
    doc: "A list of tools with their names and images"

  def project_card(assigns) do
    ~H"""
    <label
      for={"modal_#{@project_id}"}
      class="card relative sm:min-w-80 w-fit sm:w-1/2 lg:w-1/3 2xl:w-1/4 m-8 bg-base-200 shadow-lg transition-transform duration-300 hover:shadow-xl hover:scale-110 cursor-pointer h-160"
    >
      <figure>
        <.carrousel image_sources_list={@image_sources_list} project_id={@project_id} />
      </figure>

      <.tags_list tags={@tags} />

      <.contributors_list contributors={@contributors} />

      <div class="card-body pb-12">
        <.project_title
          type="card"
          title={@title}
          icon_name="hero-arrow-top-right-on-square"
          link={@link}
        />

        <p class="text-base font-common">
          {Helper.format_text(@short_description)}
        </p>
      </div>
    </label>

    <.project_modal
      project_id={@project_id}
      image_sources_list={@image_sources_list}
      title={@title}
      long_description={Helper.format_text(@long_description)}
      tags={@tags}
      contributors={@contributors}
      tools={@tools}
      link={@link}
    />
    """
  end

  attr :project_id, :string, required: true, doc: "The unique identifier for the project"
  attr :image_sources_list, :list, required: true, doc: "The source URLs for the project images"
  attr :title, :string, required: true, doc: "The title of the project"
  attr :long_description, :string, required: true, doc: "The long description text of the project"

  attr :tags, :list,
    default: [],
    doc: "A list of keywords to display below the image"

  attr :contributors, :list,
    default: [],
    doc: "A list of contributors with their names and images"

  attr :tools, :list,
    default: [],
    doc: "A list of tools used for the project, with their names and images"

  attr :link, :string, default: nil, doc: "The link for the project"

  def project_modal(assigns) do
    ~H"""
    <input type="checkbox" id={@project_id} class="modal-toggle" />
    <div class="modal z-5" role="dialog">
      <div class="modal-box w-full max-w-5xl relative">
        <Button.close_button for={@project_id} />
        <figure>
          <.carrousel image_sources_list={@image_sources_list} project_id={@project_id} />
        </figure>
        <.tags_list tags={@tags} />
        <.contributors_list contributors={@contributors} />
        <div class="card-body pb-12">
          <.project_title
            type="modal"
            title={@title}
            icon_name="hero-arrow-top-right-on-square"
            link={@link}
          />
          <p class="text-base font-common">
            {@long_description}
          </p>
          <Header.card_title class="mt-5 text-left" title={gettext("Technologies used")} />
          <.tools_list class="space-x-2 my-2 gap-2" tools={@tools} />
        </div>
      </div>
      <label class="modal-backdrop" for={@project_id}>Close</label>
    </div>
    """
  end

  @doc """
  A carousel component to show some illustrations from your project.

  ## Example

      <.carrousel image_sources_list={@image_sources_list} project_id="your-project-id" />
  """
  attr :image_sources_list, :list, required: true, doc: "The source URLs for the project images"

  attr :project_id, :string,
    required: true,
    doc: "The unique identifier of the project associated to this carousel"

  def carrousel(assigns) do
    ~H"""
    <div class="carousel w-full">
      <%= for {image_source, index} <- Enum.with_index(@image_sources_list) do %>
        <div id={"/project#{@project_id}/slide#{index + 1}"} class="carousel-item relative w-full">
          <img
            src={image_source}
            alt={"Project image #{index + 1}"}
            height="80"
            width="100"
            class="mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover"
          />

          <div class="absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between">
            <a
              href={"#/project#{@project_id}/slide#{if index == 0, do: length(@image_sources_list), else: index}"}
              class="btn btn-circle"
            >
              ❮
            </a>

            <a
              href={"#/project#{@project_id}/slide#{if index == length(@image_sources_list) - 1, do: 1, else: index + 2}"}
              class="btn btn-circle"
            >
              ❯
            </a>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a clickable title redirecting to the project in production, should be rendered inside a project card or a project modal.

  ## Example :

      <.project_title title="My Project" link="http://my-project.url" icon_name="hero-arrow-top-right-on-square" type="card" />
      <.project_title title="My Project" link="http://my-project.url" icon_name="hero-arrow-top-right-on-square" type="modal" />
  """
  attr :title, :string, required: true, doc: "The title to display"
  attr :icon_name, :string, default: nil, doc: "The optional icon name to display on the right"
  attr :link, :string, default: nil, doc: "The optional link to make the icon actionable"
  attr :type, :string, values: ~w(card modal), required: true

  def project_title(%{type: "modal"} = assigns) do
    ~H"""
    <a
      href={@link}
      aria-label="modal presenting a project"
      class="card-title text-2xl font-bold font-common py-7 inline-block"
    >
      {@title}
      <.icon
        :if={@icon_name}
        name={@icon_name}
        class="size-4 pt-5 transition-transform duration-300 hover:scale-150"
      />
    </a>
    """
  end

  def project_title(%{type: "card"} = assigns) do
    ~H"""
    <a
      href={@link}
      aria-label="card presenting a project"
      class="card-title text-xl font-bold font-common py-3 inline-block"
    >
      {@title}
      <.icon
        :if={@icon_name}
        name={@icon_name}
        class="size-4 pt-5 transition-transform duration-300 hover:scale-150"
      />
    </a>
    """
  end

  @doc """
  Renders a list of tags to quickly define your project.

  <.tags_list tags={["Elixir", "Phoenix", "Ecto", "Absinthe"]} />
  """
  attr :tags, :list, required: true, doc: "A list of keywords to display as tags"

  def tags_list(assigns) do
    ~H"""
    <ul class="flex flex-wrap gap-2 pl-4 pt-6">
      <%= for tag <- @tags do %>
        <li class="badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103">
          {tag}
        </li>
      <% end %>
    </ul>
    """
  end

  attr :contributors, :list,
    required: true,
    doc:
      "A list of contributors with their names and images. Format waited : %{name: 'name', link: 'https://linkedin.fr/toto', img: 'url_of_image'}"

  def contributors_list(assigns) do
    ~H"""
    <div class="avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3">
      <%= for contributor <- @contributors do %>
        <div class="avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120">
          <div class="w-8">
            <a href={contributor.social_link} target="_blank" title={contributor.name}>
              <img class="w-4 h-4" src={contributor.avatar_url} alt={contributor.name} />
            </a>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a list of tools used to make the project to be displayed inside the project modal.

  ## Example :

      <.tools_list class="gap-2" tools={[%{name: "Elixir", website_link: "https://elixir-lang.org/", logo_url: "path/to/elixir/logo.png"}, ...]} />
  """
  attr :tools, :list,
    required: true,
    doc:
      "A list of tools with their names and images. Format waited : %{name: 'name', website_link: 'https://linkedin.fr/toto', logo_url: 'url_of_logo'}"

  attr :class, :string, default: "", doc: "Additional CSS classes to apply"

  def tools_list(assigns) do
    ~H"""
    <div class={"avatar rounded-xl flex-wrap #{@class}"}>
      <%= for tool <- @tools do %>
        <div class="avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120">
          <div class="w-12">
            <a href={tool.website_link} target="_blank" title={tool.name}>
              <img class="w-4 h-4" src={tool.logo_url} alt={tool.name} />
            </a>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
