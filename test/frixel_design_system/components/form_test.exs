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
      booking_appointment_url: booking_appointment_url
    }

    # When
    html =
      "#{rendered_to_string(~H"""
      <Form.contact_form
        title="My form"
        title_color_class="text-emerald-400"
        card_class="bg-gray border border-red-400"
        input_color_class="input-secondary"
        input_error_class="input-red-400"
        client_needs={@client_needs}
        client_budgets={@client_budgets}
        booking_appointment_url={@booking_appointment_url}
        phx-submit="submit_contact_form"
      />
      """)}"

    # Then
    assert html =~ "My form"
    assert html =~ "https://www.booking-appointement-url.com"
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
