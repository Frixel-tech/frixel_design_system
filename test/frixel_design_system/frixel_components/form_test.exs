defmodule FrixelDesignSystem.Components.FormTest do
  alias FrixelDesignSystem.Components.Form
  use ComponentCase

  test "client_review_form" do
    # Given
    assigns = %{rest: %{class: "flew text-center"}}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.client_review_form rest={@rest} />
      """)}"

    # Then
    assert html =~
             "<form class=\"flex flex-col gap-8 flew text-center\" class=\"flew text-center\">\n  <div class=\"flex gap-4\">\n    <div class=\"w-1/2\">\n      <input class=\"input input-secondary w-full\" name=\"author\" placeholder=\"Your name\" required id=\"author\" name=\"author\" required class=\"w-full\" placeholder=\"Your name\">\n    </div>\n    <div class=\"w-1/2\">\n      <input class=\"input input-secondary w-full\" name=\"role\" placeholder=\"Your role\" required id=\"role\" name=\"role\" required class=\"w-full\" placeholder=\"Your role\">\n    </div>\n  </div>\n  <div>\n    <input class=\"input input-secondary w-full\" name=\"company\" placeholder=\"Company name\" required id=\"company\" name=\"company\" required class=\"w-full\" placeholder=\"Company name\">\n  </div>\n  <div>\n    <textarea id=\"content\" name=\"content\" placeholder=\"Write your review here...\" class=\"textarea textarea-bordered w-full input-secondary\" rows=\"4\" required></textarea>\n  </div>\n  <button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 mt-4\" type=\"submit\">\n  Submit review\n  \n  \n</button>\n</form>"
  end

  test "contact_form" do
    # Given
    services = [
      %{
        value: "A single service",
        label: "A single service",
        shows_text_input_when_checked: false
      }
    ]

    budgets = [
      %{value: "100K", label: "100K", shows_text_input_when_checked: false},
      %{value: "100K", label: "200K", shows_text_input_when_checked: false}
    ]

    booking_appointment_url = "https://www.booking-appointement-url.com"

    assigns = %{
      services: services,
      budgets: budgets,
      booking_appointment_url: booking_appointment_url,
      rest: %{class: "flew text-center"}
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.contact_form
        services={@services}
        budgets={@budgets}
        booking_appointment_url={@booking_appointment_url}
        rest={@rest}
      />
      """)}"

    # Then
    assert html =~
             "<div class=\"card bg-base-200 shadow-xl py-6 px-8\">\n  <div class=\"flex items-center justify-between mb-8\">\n    <h2 class=\"text-base xl:text-2xl font-normal font-slogan tracking-widest uppercase\">\n      Or contact us\n    </h2>\n\n    <div class=\"flex gap-4\">\n      <a href=\"https://www.booking-appointement-url.com\" target=\"_blank\">\n        <button class=\"btn btn-outline py-4 px-4 btn-accent text-sm md:text-base transition-transform duration-300 hover:scale-105 \">\n  Book a call\n  \n  \n</button>\n      </a>\n    </div>\n  </div>\n\n  <form class=\"flex flex-col gap-11 flew text-center\" class=\"flew text-center\">\n    <div class=\"flex gap-4\">\n      <div class=\"w-1/2\">\n        <input class=\"input input-secondary w-full\" name=\"sender_name\" placeholder=\"Name\" required id=\"sender_name\" name=\"sender_name\" required class=\"w-full\" placeholder=\"Name\">\n      </div>\n      <div class=\"w-1/2\">\n        <input class=\"input input-secondary w-full\" name=\"sender_email_address\" placeholder=\"E-mail\" type=\"email\" id=\"sender_email_address\" name=\"sender_email_address\" type=\"email\" class=\"w-full\" placeholder=\"E-mail\">\n      </div>\n    </div>\n    <div>\n      <textarea id=\"body\" name=\"body\" placeholder=\"Write your message here...\" class=\"textarea textarea-bordered w-full input-secondary\" rows=\"4\" required></textarea>\n    </div>\n    <div>\n      <input class=\"input input-secondary w-full\" name=\"sender_company\" placeholder=\"Company\" id=\"sender_company\" name=\"sender_company\" class=\"w-full\" placeholder=\"Company\">\n    </div>\n    <div>\n  <h3 class=\"block text-base font-common font-normal my-4 tracking-widest\">\n    SERVICES (multiple selection)\n  </h3>\n  <div class=\"flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3\">\n    <div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"checkbox\" name=\"project_types[]\" value=\"A single service\" class=\"checkbox checkbox-secondary checkbox-md\">\n        A single service\n      </label>\n\n      \n    </div>\n  </div>\n</div>\n    <div>\n  <h3 class=\"block text-base font-common font-normal my-4 tracking-widest\">\n    PROJECT BUDGET\n  </h3>\n  <div class=\"flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3\">\n    <div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"radio\" name=\"project_budget\" value=\"100K\" class=\"radio radio-secondary radio-sm\">\n        100K\n      </label>\n\n      \n    </div><div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"radio\" name=\"project_budget\" value=\"100K\" class=\"radio radio-secondary radio-sm\">\n        200K\n      </label>\n\n      \n    </div>\n  </div>\n</div>\n    <button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 mt-4\" type=\"submit\">\n  Send\n  \n  \n</button>\n  </form>\n</div>"
  end

  test "contact_informations" do
    # Given
    company_description = "Some description of the company"
    company_name = "Company name"
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
      <Form.contact_informations
        company_description={@company_description}
        company_name={@company_name}
        company_postal_address={@company_postal_address}
        company_email_address={@company_email_address}
        company_phone_number={@company_phone_number}
        company_social_media_links={@company_social_media_links}
        company_lattitude={@company_lattitude}
        company_longitude={@company_longitude}
      />
      """)}"

    # Then
    assert html =~
             "<div id=\"find-us\" class=\"mx-auto py-6 px-8 md:max-w-1/2\">\n  <div class=\"flex items-center justify-between mb-8\">\n    <h2 class=\"text-base-content text-base xl:text-xl font-bold font-slogan tracking-widest uppercase\">\n      Find us\n    </h2>\n  </div>\n\n  <div class=\"flex flex-col gap-4\">\n    <p class=\"text-base\">Some description of the company</p>\n\n    <div>\n      <ul class=\"text-base\">\n        <li>11 boulevard de l&#39;ours, 30899, Mort-Sur-Sang</li>\n\n        <li>\n          email@adress.com\n        </li>\n\n        <li>\n          <a class=\"link link-accent hover:font-bold transition-[font-weight] \" aria-label=\"Call us\" href=\"tel:+3378767543456\" target=\"_blank\">\n            +3378767543456\n          </a>\n        </li>\n      </ul>\n\n      <ul class=\"flex items-center gap-4 py-4\">\n  <li>\n    <a href=\"https://www.linkedin.com/company/frixel-tech\" target=\"_blank\">\n      <img src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/linkedin_logo_yg8wim.png\" alt=\"Logo for https://www.linkedin.com/company/frixel-tech\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li><li>\n    <a href=\"https://github.com/Frixel-tech\" target=\"_blank\">\n      <img src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/github_logo_bwefsq.png\" alt=\"Logo for https://github.com/Frixel-tech\" class=\"size-10 rounded-full hover:shadow-md transition-transform duration-300 hover:scale-110\">\n    </a>\n  </li>\n</ul>\n\n      <div id=\"leaflet-map\" phx-hook=\"LeafletHook\" data-lattitude=\"14.24676\" data-longitude=\"32.68465\" class=\"h-100 my-2 shadow-xl rounded-lg transition-transform duration-300 hover:scale-103 z-0\"></div>\n    </div>\n  </div>\n</div>"
  end

  test "form_input" do
    # Given
    assigns = %{rest: %{class: "flew text-center"}}

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.form_input rest={@rest} />
      """)}"

    # Then
    assert html =~
             "<input class=\"input input-secondary flew text-center\" class=\"flew text-center\">"
  end

  test "form_checkbox_or_radio_group" do
    # Given
    options = [
      %{
        value: "A single service",
        label: "A single service",
        shows_text_input_when_checked: true
      }
    ]

    title = "title"
    group_type = "checkbox"
    other_input_type = "text other"
    input_name = "input_name"

    assigns = %{
      options: options,
      title: title,
      group_type: group_type,
      other_input_type: other_input_type,
      input_name: input_name
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.form_checkbox_or_radio_group
        options={@options}
        title={@title}
        group_type={@group_type}
        other_input_type={@other_input_type}
        input_name={@input_name}
      />
      """)}"

    # Then
    assert html =~
             "<div>\n  <h3 class=\"block text-base font-common font-normal my-4 tracking-widest\">\n    title\n  </h3>\n  <div class=\"flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3\">\n    <div class=\"flex items-center gap-2\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"checkbox\" name=\"input_name\" value=\"A single service\" class=\"checkbox checkbox-secondary checkbox-md\">\n        A single service\n      </label>\n\n      <input class=\"input input-secondary hidden peer-has-checked:flex w-full\" name=\"input_name\" placeholder=\"Specify\" type=\"text other\" name=\"input_name\" type=\"text other\" class=\"hidden peer-has-checked:flex w-full\" placeholder=\"Specify\">\n    </div>\n  </div>\n</div>"
  end
end
