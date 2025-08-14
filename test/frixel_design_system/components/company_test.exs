defmodule FrixelDesignSystem.Components.CompanyTest do
  alias FrixelDesignSystem.Components.{Company, Menu}
  use ComponentCase

  test "contact_informations" do
    # Given
    company_description = "Some description of the company"
    company_name = "Company name"
    company_img = "/path/to/my/company/logo.png"
    company_postal_address = "11 boulevard de l'ours, 30899, Mort-Sur-Sang"
    company_email_address = "email@adress.com"
    company_phone_number = "+3378767543456"

    company_social_media_links = [
      %{
        name: "Linkedin",
        social_media_url: "https://www.linkedin.com/company/frixel-tech",
        icon_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/linkedin_logo_yg8wim.png"
      },
      %{
        name: "Github",
        social_media_url: "https://github.com/Frixel-tech",
        icon_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/github_logo_bwefsq.png"
      }
    ]

    company_lattitude = "14.24676"
    company_longitude = "32.68465"

    assigns = %{
      company_description: company_description,
      company_name: company_name,
      company_img: company_img,
      company_postal_address: company_postal_address,
      company_email_address: company_email_address,
      company_phone_number: company_phone_number,
      company_social_media_links: company_social_media_links,
      company_lattitude: company_lattitude,
      company_longitude: company_longitude
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.contact_informations title="Find us" title_color_class="text-emerald-400">
        <:contact_details>
          <Company.contact_details
            text-color-class="text-blue-500"
            company_name={@company_name}
            company_img={@company_img}
            company_description={@company_description}
            company_postal_address={@company_postal_address}
            company_email_address={@company_email_address}
            company_phone_number={@company_phone_number}
          />
        </:contact_details>

        <:socials>
          <Menu.socials_list
            socials={@company_social_media_links}
            is_icon_rounded?={false}
            class="py-4"
          />
        </:socials>

        <:map>
          <Company.find_us_map
            company_lattitude={@company_lattitude}
            company_longitude={@company_longitude}
            marker_icon_url="/path/to/my/company/icon.mini"
          />
        </:map>
      </Company.contact_informations>
      """)}"

    # Then
    assert html =~ "Some description of the company"
    assert html =~ "https://github.com/Frixel-tech"
    assert html =~ "/path/to/my/company/icon.mini"
  end

  test "branding" do
    # Given
    assigns = %{brand_name: "brand_name", brand_img: "/path/to/image.png"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.branding brand_name={@brand_name} brand_img={@brand_img} />
      """)}"

    # Then
    assert html =~
             "<a href=\"/\" class=\"flex items-center\">\n  <img src=\"/path/to/image.png\" alt=\"brand_name logo\" class=\"size-12 mx-auto px-1\">\n  <h1 class=\"btn btn-ghost hover:bg-transparent hover:border-none hover:shadow-none transition-[color] text-lg sm:text-3xl xl:text-5xl font-title font-normal \">\n    brand_name\n  </h1>\n</a>"
  end

  test "introduction_card" do
    # Given
    assigns = %{title: "title here", text: "text here", img_src: "/path/to/image.png"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.introduction_card title={@title} text={@text} img_src={@img_src} />
      """)}"

    # Then
    assert html =~
             "<div class=\"card card-side items-center bg-base-200 shadow-lg mb-12 lg:mx-12\">\n  <div class=\"card-body items-center lg:pl-16\">\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest card-title tracking-widest\">\n  title here\n</h3>\n    <p class=\"text-base mt-2\">text here</p>\n  </div>\n  <figure>\n    <div class=\"hidden xl:block px-6 rounded-lg mr-8\">\n      <img src=\"/path/to/image.png\" height=\"80\" width=\"200\" class=\"w-200 ml-8 mr-6 mt-6 mb-6 rounded-lg shadow-xl\" alt=\"Introduction illtustration\">\n    </div>\n  </figure>\n</div>"
  end

  test "company_values_card" do
    # Given
    assigns = %{title: "title here", text: "text here"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.company_values_card title={@title} text={@text} />
      """)}"

    # Then
    assert html =~
             "<div class=\"card bg-base-200 w-104 h-54 shadow-sm my-6\">\n  <div class=\"card-body items-center flex-none m-auto gap-4\">\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest card-title tracking-widest\">\n  title here\n</h3>\n    <p class=\"text-base text-center\">text here</p>\n  </div>\n</div>"
  end

  test "service_card" do
    # Given
    assigns = %{
      logo: "/path/to/logo.png",
      name: "Service name",
      description: "Description here",
      modal_id: "ID of the modal"
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.service_card logo={@logo} name={@name} description={@description} modal_id={@modal_id} />
      """)}"

    # Then
    assert html =~
             "<label for=\"ID of the modal\" class=\"cursor-pointer block\">\n  <div class=\"bg-base-200 border-base-300 border w-64 h-60 flex flex-col items-center justify-center rounded-xl transform duration-300 hover:shadow-xl hover:scale-110\">\n    <div class=\"flex flex-col items-center justify-center flex-1 w-full\">\n      <figure class=\"flex justify-center\">\n        <img src=\"/path/to/logo.png\" alt=\"Service name illustration\" width=\"20\" height=\"20\" class=\"rounded-xl size-20\">\n      </figure>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-base mt-6 px-4\">\n  Service name\n</h3>\n    </div>\n  </div>\n</label>\n<input type=\"checkbox\" id=\"ID of the modal\" class=\"modal-toggle\">\n<div class=\"modal z-1001\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-lg relative\">\n    <label for=\"ID of the modal\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure class=\"flex justify-center py-6\">\n      <img src=\"/path/to/logo.png\" alt=\"Service name\" class=\"rounded-xl size-24\">\n    </figure>\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-2xl\">\n  Service name\n</h3>\n    <div class=\"text-base text-center py-4\">\n      <p>Description here</p>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"ID of the modal\">Close</label>\n</div>"
  end

  test "service_modal" do
    # Given
    assigns = %{
      logo: "/path/to/logo.png",
      name: "Service name",
      description: "Description here",
      modal_id: "ID of the modal"
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.service_modal logo={@logo} name={@name} description={@description} modal_id={@modal_id} />
      """)}"

    # Then
    assert html =~
             "<input type=\"checkbox\" id=\"ID of the modal\" class=\"modal-toggle\">\n<div class=\"modal z-1001\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-lg relative\">\n    <label for=\"ID of the modal\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure class=\"flex justify-center py-6\">\n      <img src=\"/path/to/logo.png\" alt=\"Service name\" class=\"rounded-xl size-24\">\n    </figure>\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-2xl\">\n  Service name\n</h3>\n    <div class=\"text-base text-center py-4\">\n      <p>Description here</p>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"ID of the modal\">Close</label>\n</div>"
  end

  test "skill_card" do
    # Given
    assigns = %{logo: "/path/to/logo.png", name: "Service name"}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.skill_card logo={@logo} name={@name} />
      """)}"

    # Then
    assert html =~
             "<div class=\"card bg-secondary w-56 xl:w-76 shadow-sm\">\n  <figure class=\"px-10 pt-10\">\n    <img src=\"/path/to/logo.png\" alt=\"Service name\" class=\"rounded-xl w-20 lg:w-30 xl:w-30 h-30 lg:h-30 xl:h-30\">\n  </figure>\n\n  <div class=\"card-body items-center text-center\">\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest card-title\">\n  Service name\n</h3>\n  </div>\n</div>"
  end

  test "trombinoscope" do
    # Given
    team_members_list = [
      %{
        avatar_url: "/path/to/image.png",
        name: "John Doe",
        job_title: "President",
        linkedin_url: "www.first_path_to_link.fr",
        github_url: "www.first_gt_path_to_link.fr"
      },
      %{
        avatar_url: "/path/to/image.png",
        name: "Jacques Tour",
        job_title: "Employee",
        linkedin_url: "www.second_path_to_link.fr",
        github_url: "www.second_gt_path_to_link.fr"
      }
    ]

    assigns = %{team_members: team_members_list}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.trombinoscope team_members={@team_members} />
      """)}"

    # Then
    assert html =~
             "<div class=\"flex flex-wrap justify-center gap-6\">\n  \n    <div class=\"card bg-base-200 w-64 shadow-sm\">\n  <figure class=\"px-10 pt-10\">\n    <img class=\"w-42 h-42 rounded-xl\" src=\"/path/to/image.png\" alt=\"John Doe\">\n  </figure>\n  <div class=\"card-body items-center text-center\">\n    <p class=\"card-title text-base-content\">John Doe</p>\n    <p class=\"text-sm text-base-content\">President</p>\n    <div class=\"card-actions\">\n      <ul class=\"flex items-center gap-4 \">\n  <li>\n    <a href=\"www.first_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/linkedin_logo.png\" alt=\"Logo for www.first_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li><li>\n    <a href=\"www.first_gt_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/github_logo.png\" alt=\"Logo for www.first_gt_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li>\n</ul>\n    </div>\n  </div>\n</div>\n  \n    <div class=\"card bg-base-200 w-64 shadow-sm\">\n  <figure class=\"px-10 pt-10\">\n    <img class=\"w-42 h-42 rounded-xl\" src=\"/path/to/image.png\" alt=\"Jacques Tour\">\n  </figure>\n  <div class=\"card-body items-center text-center\">\n    <p class=\"card-title text-base-content\">Jacques Tour</p>\n    <p class=\"text-sm text-base-content\">Employee</p>\n    <div class=\"card-actions\">\n      <ul class=\"flex items-center gap-4 \">\n  <li>\n    <a href=\"www.second_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/linkedin_logo.png\" alt=\"Logo for www.second_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li><li>\n    <a href=\"www.second_gt_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/github_logo.png\" alt=\"Logo for www.second_gt_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li>\n</ul>\n    </div>\n  </div>\n</div>\n  \n</div>"
  end

  test "team_member_card" do
    # Given
    assigns = %{
      img_src: "/path/to/image.png",
      name: "John Doe",
      position: "President",
      linkedin_url: "www.first_path_to_link.fr",
      github_url: "www.first_gt_path_to_link.fr"
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.team_member_card
        img_src={@img_src}
        name={@name}
        position={@position}
        linkedin_url={@linkedin_url}
        github_url={@github_url}
      />
      """)}"

    # Then
    assert html =~
             "<div class=\"card bg-base-200 w-64 shadow-sm\">\n  <figure class=\"px-10 pt-10\">\n    <img class=\"w-42 h-42 rounded-xl\" src=\"/path/to/image.png\" alt=\"John Doe\">\n  </figure>\n  <div class=\"card-body items-center text-center\">\n    <p class=\"card-title text-base-content\">John Doe</p>\n    <p class=\"text-sm text-base-content\">President</p>\n    <div class=\"card-actions\">\n      <ul class=\"flex items-center gap-4 \">\n  <li>\n    <a href=\"www.first_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/linkedin_logo.png\" alt=\"Logo for www.first_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li><li>\n    <a href=\"www.first_gt_path_to_link.fr\" target=\"_blank\">\n      <img src=\"/images/github_logo.png\" alt=\"Logo for www.first_gt_path_to_link.fr\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li>\n</ul>\n    </div>\n  </div>\n</div>"
  end

  test "review_card" do
    # Given
    assigns = %{
      review: %{
        author_picture: "/path/to/image.png",
        author: "John Doe",
        content: "Content description of the review",
        role: "Head of Marketing"
      }
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Company.review_card review={@review} />
      """)}"

    # Then
    assert html =~
             "<div class=\"min-h-64 max-w-xl bg-base-100 shadow-lg rounded-lg p-6 flex items-center gap-4\">\n  <img src=\"/path/to/image.png\" alt=\"John Doe profile\" class=\"w-14 h-14 md:w-24 md:h-24 xl:w-34 xl:h-34 mx-4 lg:mx-8 rounded-full object-cover border-4 border-primary\">\n  <div>\n    <p class=\"text-md italic font-common mb-4 break-all\">\"Content description of the review\"</p>\n    <div class=\"font-bold font-common text-base-content\">John Doe</div>\n    <div class=\"text-sm font-common text-base-content/70 whitespace-nowrap\">\n      Head of Marketing\n    </div>\n  </div>\n</div>"
  end
end
