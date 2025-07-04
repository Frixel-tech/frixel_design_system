defmodule FrixelDesignSystem.Components.Company do
  use Phoenix.Component

  alias FrixelDesignSystem.Components.{Button, Header, Menu}

  @doc """
  Component to render your company logo and name as a h1 title

  ## Example:

      <.branding brand_name="My Awesome Company" brand_img="path/to/my/awesome/company.jpg" />
  """
  attr(:brand_name, :string, required: true)
  attr(:brand_img, :string, required: true)

  def branding(assigns) do
    ~H"""
    <a href="/" class="flex items-center">
      <img src={@brand_img} alt={"#{@brand_name} logo"} class="size-12 mx-auto px-1" />
      <h1
        class="btn btn-ghost hover:bg-transparent hover:border-none hover:shadow-none transition-[color] text-xl sm:text-3xl xl:text-5xl font-title font-normal"
        style="font-size: 20px;"
      >
        {@brand_name}
      </h1>
    </a>
    """
  end

  @doc """
  Component to render an introductory card of your company inside a presentation section (cf. `FrixelDesignSystem.FrixelSections.introduction_section/1`)

  ## Example:

      <.introduction_card
        title="Our awesome team"
        text="Some lines of global presentation of your company"
        img_src="path/to/your/team/or/organisation/photo.jpg" />
  """

  attr(:title, :string, default: nil, doc: "The optional subtitle to display")
  attr(:text, :string, default: nil, doc: "The optional text to display")
  attr(:img_src, :string, default: nil, doc: "The optional image source to display")

  def introduction_card(assigns) do
    ~H"""
    <div class="card card-side items-center bg-base-200 shadow-lg mb-12 lg:mx-12">
      <div class="card-body items-center lg:pl-16">
        <Header.card_title title={@title} class="card-title tracking-widest" />
        <p class="text-base mt-2">{@text}</p>
      </div>
      <figure>
        <div class="hidden xl:block px-6 rounded-lg mr-8">
          <img
            src={@img_src}
            height="80"
            width="200"
            class="w-200 ml-8 mr-6 mt-6 mb-6 rounded-lg shadow-xl"
            alt="Introduction illtustration"
          />
        </div>
      </figure>
    </div>
    """
  end

  @doc """
  Component to render your company values as cards inside a gallery (cf. `FrixelDesignSystem.FrixelSections.introduction_section/1`)

  ## Example:

      <.company_values_card
        title="Value name"
        text="Some lines describing why it matters" />
  """
  attr(:title, :string, required: true, doc: "The title of the value")
  attr(:text, :string, required: true, doc: "The description of the value")

  def company_values_card(assigns) do
    ~H"""
    <div class="card bg-base-200 w-104 h-54 shadow-sm my-6">
      <div class="card-body items-center flex-none m-auto gap-4">
        <Header.card_title title={@title} class="card-title tracking-widest" />
        <p class="text-base text-center">{@text}</p>
      </div>
    </div>
    """
  end

  @doc """
  Component to render your company services as cards inside a gallery (cf. `FrixelDesignSystem.FrixelSections.services_section/1`)

  ## Example:

      <.service_card
        modal_id="modal-id"
        logo="path/to/your/logo.png"
        name="Service name"
        description="Some lines of description to help your customer to understand what you can do for him."
      />
  """
  attr :logo, :string, required: true, doc: "The logo URL of the service"
  attr :name, :string, required: true, doc: "The name of the service"
  attr :description, :string, default: nil, doc: "The description of the service"
  attr :modal_id, :string, required: true, doc: "Unique identifier for the modal"

  def service_card(assigns) do
    ~H"""
    <label for={@modal_id} class="cursor-pointer block">
      <div class="bg-base-200 border-base-300 border w-64 h-60 flex flex-col items-center justify-center rounded-xl transform duration-300 hover:shadow-xl hover:scale-110">
        <div class="flex flex-col items-center justify-center flex-1 w-full">
          <figure class="flex justify-center">
            <img
              src={@logo}
              alt={"#{@name} illustration"}
              width="20"
              height="20"
              class="rounded-xl size-20"
            />
          </figure>
          <Header.card_title class="text-center text-base mt-6 px-4" title={@name} />
        </div>
      </div>
    </label>
    <.service_modal modal_id={@modal_id} logo={@logo} name={@name} description={@description} />
    """
  end

  @doc """
    Component to render your company services details inside a modal (cf. `FrixelDesignSystem.Components.service_card/1`)

  ## Example:

      <.service_modal
        modal_id="modal-id"
        logo="path/to/your/logo.png"
        name="Service name"
        description="Some lines of description to help your customer to understand what you can do for him."
      />

  """
  attr :modal_id, :string, required: true, doc: "Unique identifier for the modal"
  attr :logo, :string, required: true, doc: "The logo URL of the service"
  attr :name, :string, required: true, doc: "The name of the service"
  attr :description, :string, default: nil, doc: "The description of the service"

  def service_modal(assigns) do
    ~H"""
    <input type="checkbox" id={@modal_id} class="modal-toggle" />
    <div class="modal z-1001" role="dialog">
      <div class="modal-box w-full max-w-lg relative">
        <Button.close_button for={@modal_id} />
        <figure class="flex justify-center py-6">
          <img src={@logo} alt={@name} class="rounded-xl size-24" />
        </figure>
        <Header.card_title class="text-center text-2xl" title={@name} />
        <div class="text-base text-center py-4">
          <p>{@description}</p>
        </div>
      </div>
      <label class="modal-backdrop" for={@modal_id}>Close</label>
    </div>
    """
  end

  @doc """
  Component to render your company skills as cards inside a gallery (cf. `FrixelDesignSystem.FrixelSections.skills_section/1`)

  ## Example:

      <.skill_card
        logo="path/to/the/skill/illustration.png"
        name="Skills name"
      />
  """
  attr(:logo, :string, required: true, doc: "The logo URL of the skill")
  attr(:name, :string, required: true, doc: "The name of the skill")

  def skill_card(assigns) do
    ~H"""
    <div class="card bg-secondary w-56 xl:w-76 shadow-sm">
      <figure class="px-10 pt-10">
        <img src={@logo} alt={@name} class="rounded-xl w-20 lg:w-30 xl:w-30 h-30 lg:h-30 xl:h-30" />
      </figure>

      <div class="card-body items-center text-center">
        <Header.card_title class="card-title" title={@name} />
      </div>
    </div>
    """
  end

  @doc """
  Component to render a gallery of people inside an about section (cf. `FrixelDesignSystem.FrixelSections.story_section/1`)

  ## Example:

      <.trombinoscope team={@team_members_list} />
  """
  attr(:team_members, :list,
    required: true,
    doc: "A list of employees with their names and images"
  )

  def trombinoscope(assigns) do
    ~H"""
    <div class="flex flex-wrap justify-center gap-6">
      <%= for team_member <- @team_members do %>
        <.team_member_card
          img_src={team_member.avatar_url}
          name={team_member.name}
          position={team_member.job_title}
          linkedin_url={team_member.linkedin_url}
          github_url={team_member.github_url}
        />
      <% end %>
    </div>
    """
  end

  @doc """
  Component to render your employees profiles as cards inside a gallery (cf. `FrixelDesignSystem.Components.trombinoscope/1`)

  ## Example:

      <.team_member_card
        img_src="path/to/your/employee/avatar.webp"
        name="Employee Name"
        position="Employ position"
        linkedin_url="http://linkedin.com/your-employee"
        github_url="http://github.com/your-employee" />
  """
  attr(:img_src, :string, required: true, doc: "The source URL for the employee's image")
  attr(:name, :string, required: true, doc: "The name of the employee")
  attr(:position, :string, required: true, doc: "The position of the employee")
  attr(:linkedin_url, :string, required: true, doc: "The LinkedIn profile URL of the employee")
  attr(:github_url, :string, required: true, doc: "The GitHub profile URL of the employee")

  def team_member_card(assigns) do
    ~H"""
    <div class="card bg-base-200 w-64 shadow-sm">
      <figure class="px-10 pt-10">
        <img class="w-42 h-42 rounded-xl" src={@img_src} alt={@name} />
      </figure>
      <div class="card-body items-center text-center">
        <p class="card-title text-base-content">{@name}</p>
        <p class="text-sm text-base-content">{@position}</p>
        <div class="card-actions">
          <Menu.socials_list socials={[
            %{social_media_url: @linkedin_url, icon_url: "/images/linkedin_logo.png"},
            %{social_media_url: @github_url, icon_url: "/images/github_logo.png"}
          ]} />
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Component to render your former clients reviews as cards inside a gallery (cf. `FrixelDesignSystem.FrixelSections.review_section/1`)

  ## Example:

      <.review_card
        review=%{
          author_picture: "path/to/your/client/picture.jpg",
          author: "Your Client Name",
          content: "What your client said about your job for him"
        } />
  """
  attr(:review, :map, required: true)

  def review_card(assigns) do
    ~H"""
    <div class="min-h-64 max-w-xl bg-base-100 shadow-lg rounded-lg p-6 flex items-center gap-4">
      <img
        src={@review.author_picture}
        alt={"#{@review.author} profile"}
        class="w-14 h-14 md:w-24 md:h-24 xl:w-34 xl:h-34 mx-4 lg:mx-8 rounded-full object-cover border-4 border-primary"
      />
      <div>
        <p class="text-md italic font-common mb-4 break-all">"{@review.content}"</p>
        <div class="font-bold font-common text-base-content">{@review.author}</div>
        <div class="text-sm font-common text-base-content/70 whitespace-nowrap">
          {@review.role}
        </div>
      </div>
    </div>
    """
  end
end
