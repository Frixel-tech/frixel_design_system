defmodule FrixelDesignSystem.Components.ProjectTest do
  alias FrixelDesignSystem.Components.Project
  use ComponentCase

  test "project_card" do
    # Given
    project_id = "your-project-id"

    image_sources_list = [
      "path/to/your/project/illustration.webp",
      "second/path/to/your/project/illustration.webp",
      "thid/path/to/your/project/illustration.webp"
    ]

    title = "Your Project Name"
    short_description = "One sentence to pitch your project"
    long_description = "A bigger paragraph to describe your project in details."
    tags = ["Elixir", "Phoenix", "Ecto", "Absinthe"]
    link = "http://production_project.url"

    contributors = [
      %{name: "name", social_link: "https://linkedin.fr/toto", avatar_url: "url_of_image"},
      %{
        name: "another name",
        social_link: "https://linkedin.fr/titi",
        avatar_url: "url_of_another_image"
      }
    ]

    tools = [
      %{
        name: "Elixir",
        website_link: "https://elixir-lang.org/",
        logo_url: "path/to/elixir/logo.png"
      },
      %{
        name: "Phoenix",
        website_link: "https://https://www.phoenixframework.org/",
        logo_url: "path/to/phoenix/logo.png"
      }
    ]

    assigns = %{
      project_id: project_id,
      image_sources_list: image_sources_list,
      title: title,
      short_description: short_description,
      long_description: long_description,
      tags: tags,
      link: link,
      contributors: contributors,
      tools: tools
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Project.project_card
        project_id={@project_id}
        image_sources_list={@image_sources_list}
        title={@title}
        short_description={@short_description}
        long_description={@long_description}
        tags={@tags}
        link={@link}
        contributors={@contributors}
        tools={@tools}
      />
      """)}"

    # Then
    assert html =~
             "<label for=\"modal_your-project-id\" class=\"card relative sm:min-w-80 w-fit sm:w-1/2 lg:w-1/3 2xl:w-1/4 m-8 bg-base-200 shadow-lg transition-transform duration-300 hover:shadow-xl hover:scale-110 cursor-pointer h-160\">\n  <figure>\n    <div class=\"carousel w-full\">\n  \n    <div id=\"/projectyour-project-id/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"path/to/your/project/illustration.webp\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide3\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectyour-project-id/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"second/path/to/your/project/illustration.webp\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide3\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectyour-project-id/slide3\" class=\"carousel-item relative w-full\">\n      <img src=\"thid/path/to/your/project/illustration.webp\" alt=\"Project image 3\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n  </figure>\n\n  <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Elixir\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Phoenix\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Ecto\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Absinthe\n    </li>\n  \n</ul>\n\n  <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://linkedin.fr/toto\" target=\"_blank\" title=\"name\">\n          <img class=\"w-4 h-4\" src=\"url_of_image\" alt=\"name\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://linkedin.fr/titi\" target=\"_blank\" title=\"another name\">\n          <img class=\"w-4 h-4\" src=\"url_of_another_image\" alt=\"another name\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n\n  <div class=\"card-body pb-12\">\n    <a href=\"http://production_project.url\" aria-label=\"card presenting a project\" class=\"card-title text-xl font-bold font-common py-3 inline-block\">\n  Your Project Name\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n\n    <p class=\"text-base font-common\">\n      One sentence to pitch your project\n    </p>\n  </div>\n</label>\n\n<input type=\"checkbox\" id=\"your-project-id\" class=\"modal-toggle\">\n<div class=\"modal z-5\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-5xl relative\">\n    <label for=\"your-project-id\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure>\n      <div class=\"carousel w-full\">\n  \n    <div id=\"/projectyour-project-id/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"path/to/your/project/illustration.webp\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide3\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectyour-project-id/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"second/path/to/your/project/illustration.webp\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide3\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectyour-project-id/slide3\" class=\"carousel-item relative w-full\">\n      <img src=\"thid/path/to/your/project/illustration.webp\" alt=\"Project image 3\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectyour-project-id/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectyour-project-id/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </figure>\n    <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Elixir\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Phoenix\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Ecto\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      Absinthe\n    </li>\n  \n</ul>\n    <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://linkedin.fr/toto\" target=\"_blank\" title=\"name\">\n          <img class=\"w-4 h-4\" src=\"url_of_image\" alt=\"name\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://linkedin.fr/titi\" target=\"_blank\" title=\"another name\">\n          <img class=\"w-4 h-4\" src=\"url_of_another_image\" alt=\"another name\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    <div class=\"card-body pb-12\">\n      <a href=\"http://production_project.url\" aria-label=\"modal presenting a project\" class=\"card-title text-2xl font-bold font-common py-7 inline-block\">\n  Your Project Name\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n      <p class=\"text-base font-common\">\n        A bigger paragraph to describe your project in details.\n      </p>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest mt-5 text-left\">\n  Technologies used\n</h3>\n      <div class=\"avatar rounded-xl flex-wrap space-x-2 my-2 gap-2\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://elixir-lang.org/\" target=\"_blank\" title=\"Elixir\">\n          <img class=\"w-4 h-4\" src=\"path/to/elixir/logo.png\" alt=\"Elixir\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://https://www.phoenixframework.org/\" target=\"_blank\" title=\"Phoenix\">\n          <img class=\"w-4 h-4\" src=\"path/to/phoenix/logo.png\" alt=\"Phoenix\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"your-project-id\">Close</label>\n</div>"
  end
end
