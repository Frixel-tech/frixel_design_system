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
    client_needs = [
      %{
        value: "A single service",
        label: "A single service",
        shows_text_input_when_checked: false
      }
    ]

    client_budgets = [
      %{value: "100K", label: "100K", shows_text_input_when_checked: false},
      %{value: "100K", label: "200K", shows_text_input_when_checked: false}
    ]

    booking_appointment_url = "https://www.booking-appointement-url.com"

    assigns = %{
      client_needs: client_needs,
      client_budgets: client_budgets,
      booking_appointment_url: booking_appointment_url,
      rest: %{class: "flew text-center"}
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.contact_form
        client_needs={@client_needs}
        client_budgets={@client_budgets}
        booking_appointment_url={@booking_appointment_url}
        rest={@rest}
      />
      """)}"

    # Then
    assert html =~
             "<div class=\"card bg-base-200 shadow-xl py-6 px-8\">\n  <div class=\"flex items-center justify-between mb-8\">\n    <h2 class=\"text-base xl:text-2xl font-normal font-slogan tracking-widest uppercase\">\n      Or contact us\n    </h2>\n\n    <div class=\"flex gap-4\">\n      <a href=\"https://www.booking-appointement-url.com\" target=\"_blank\">\n        <button class=\"btn btn-outline py-4 px-4 btn-accent text-sm md:text-base transition-transform duration-300 hover:scale-105 \">\n  Book a call\n  \n  \n</button>\n      </a>\n    </div>\n  </div>\n\n  <form class=\"flex flex-col gap-11 flew text-center\" class=\"flew text-center\">\n    <div class=\"flex gap-4\">\n      <div class=\"w-1/2\">\n        <input class=\"input input-secondary w-full\" name=\"sender_name\" placeholder=\"Name\" required id=\"sender_name\" name=\"sender_name\" required class=\"w-full\" placeholder=\"Name\">\n      </div>\n      <div class=\"w-1/2\">\n        <input class=\"input input-secondary w-full\" name=\"sender_email_address\" placeholder=\"E-mail\" type=\"email\" id=\"sender_email_address\" name=\"sender_email_address\" type=\"email\" class=\"w-full\" placeholder=\"E-mail\">\n      </div>\n    </div>\n    <div>\n      <textarea id=\"body\" name=\"body\" placeholder=\"Write your message here...\" class=\"textarea textarea-bordered w-full input-secondary\" rows=\"4\" required></textarea>\n    </div>\n    <div>\n      <input class=\"input input-secondary w-full\" name=\"sender_company\" placeholder=\"Company\" id=\"sender_company\" name=\"sender_company\" class=\"w-full\" placeholder=\"Company\">\n    </div>\n    <div>\n  <h3 class=\"block text-base font-common font-normal my-4 tracking-widest\">\n    SERVICES (multiple selection)\n  </h3>\n  <div class=\"flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3\">\n    <div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"checkbox\" name=\"project_types[]\" value=\"A single service\" class=\"checkbox checkbox-secondary checkbox-md\">\n        A single service\n      </label>\n\n      \n    </div>\n  </div>\n</div>\n    <div>\n  <h3 class=\"block text-base font-common font-normal my-4 tracking-widest\">\n    PROJECT BUDGET\n  </h3>\n  <div class=\"flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3\">\n    <div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"radio\" name=\"project_budget\" value=\"100K\" class=\"radio radio-secondary radio-sm\">\n        100K\n      </label>\n\n      \n    </div><div class=\"false\">\n      <label class=\"label peer flex items-center gap-2 text-sm font-common text-base-content\">\n        <input type=\"radio\" name=\"project_budget\" value=\"100K\" class=\"radio radio-secondary radio-sm\">\n        200K\n      </label>\n\n      \n    </div>\n  </div>\n</div>\n    <button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 mt-4\" type=\"submit\">\n  Send\n  \n  \n</button>\n  </form>\n</div>"
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

  test "image_gallery_input" do
    assigns = %{
      img_urls_list: ["http://frixel.fr"],
      selected_img_url: ""
    }

    html =
      "#{rendered_to_string(~H"""
      <Form.image_gallery_input
        img_urls_list={@img_urls_list}
        selected_img_url={@selected_img_url}
        phx-click="handle-test"
      />
      """)}"

    assert html =~
             "<div class=\"cursor-pointer transition-transform duration-300 hover:scale-103 hover:border-[#6B4BA1] active:border-[#6B4BA1] p-1 border-4 rounded-sm border-base-200\" phx-value-url=\"http://frixel.fr\" phx-click=\"handle-test\">"

    # We update the assigns
    assigns = %{
      img_urls_list: ["http://frixel.fr"],
      selected_img_url: "http://frixel.fr"
    }

    html =
      "#{rendered_to_string(~H"""
      <Form.image_gallery_input
        img_urls_list={@img_urls_list}
        selected_img_url={@selected_img_url}
        phx-click="handle-test"
      />
      """)}"

    assert html =~
             "<div class=\"cursor-pointer transition-transform duration-300 hover:scale-103 hover:border-[#6B4BA1] active:border-[#6B4BA1] p-1 border-4 rounded-sm border-[#6B4BA1]\" phx-value-url=\"http://frixel.fr\" phx-click=\"handle-test\">"
  end
end
