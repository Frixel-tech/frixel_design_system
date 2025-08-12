defmodule FrixelDesignSystem.Components.Form do
  use Phoenix.Component
  use Gettext, backend: FrixelDesignSystemWeb.Gettext
  alias FrixelDesignSystem.Components.Button
  alias FrixelDesignSystemWeb.CoreComponents

  @doc """
  Renders the form for client submissions.

  ## Example:

      <.client_review_form phx-submit="submit_review_form" />
  """
  attr :rest, :global

  def client_review_form(assigns) do
    ~H"""
    <form class={"flex flex-col gap-8 #{@rest[:class]}"} {@rest}>
      <div class="flex gap-4">
        <div class="w-1/2">
          <.form_input
            id="author"
            class="w-full"
            name="author"
            placeholder={gettext("Your name")}
            required
          />
        </div>
        <div class="w-1/2">
          <.form_input
            id="role"
            class="w-full"
            name="role"
            placeholder={gettext("Your role")}
            required
          />
        </div>
      </div>
      <div>
        <.form_input
          id="company"
          class="w-full"
          name="company"
          placeholder={gettext("Company name")}
          required
        />
      </div>
      <div>
        <textarea
          id="content"
          name="content"
          placeholder={gettext("Write your review here...")}
          class="textarea textarea-bordered w-full input-secondary"
          rows="4"
          required
        ></textarea>
      </div>
      <Button.primary_button text={gettext("Submit review")} class="mt-4" type="submit" />
    </form>
    """
  end

  @doc """
  Renders a contact form for client interaction.

  ## Example:

      <.contact_form
        title="My form"
        title_color_class="text-emerald-400"
        card_class="bg-gray border border-red-400"
        input_color_class="input-secondary"
        input_error_class="input-red-400"
        client_needs={["website", "design", "e-commerce", "mobile app"]}
        client_budgets={["<5.000", "<10.000", "<20.000", "<50.000"]},
        booking_appointment_url="http://calendly.com/contact-me"
        phx-submit="submit_contact_form" />
  """
  attr :title, :string, default: "Contact us"
  attr :title_color_class, :string, default: "text-black"
  attr :card_class, :string, default: "border border-black"
  attr :input_color_class, :string, default: "input-neutral"
  attr :input_error_class, :string, default: "input-error"
  attr :client_needs, :list, default: nil
  attr :client_budgets, :list, default: nil
  attr :booking_appointment_url, :string, default: nil
  attr :rest, :global

  def contact_form(assigns) do
    ~H"""
    <div class={"card #{@card_class} shadow-xl justify-center py-6 px-8"}>
      <div class="flex items-center justify-between mb-8">
        <h2 class={"#{@title_color_class} text-base xl:text-2xl font-normal font-slogan tracking-widest uppercase"}>
          {@title}
        </h2>

        <div class="flex gap-4">
          <.link :if={@booking_appointment_url} href={@booking_appointment_url} target="_blank">
            <Button.secondary_button text={gettext("Book a call")} />
          </.link>
        </div>
      </div>

      <form class={"flex flex-col gap-11 #{@rest[:class]}"} {@rest}>
        <div class="flex justify-between">
          <CoreComponents.input
            id="sender_name"
            name="sender_name"
            value=""
            type="text"
            class={"input #{@input_color_class}"}
            error_class={@input_error_class}
            placeholder={gettext("Name")}
            required
          />

          <CoreComponents.input
            id="sender_email_address"
            name="sender_email_address"
            value=""
            type="email"
            class={"input #{@input_color_class}"}
            error_class={@input_error_class}
            placeholder={gettext("E-mail")}
            required
          />
        </div>

        <div class="flex justify-between">
          <CoreComponents.input
            id="sender_company"
            name="sender_company"
            value=""
            type="text"
            class={"input #{@input_color_class}"}
            error_class={@input_error_class}
            placeholder={gettext("Company (optional)")}
          />

          <CoreComponents.input
            id="sender_phone_number"
            name="sender_phone_number"
            value=""
            type="tel"
            class={"input #{@input_color_class}"}
            error_class={@input_error_class}
            placeholder={gettext("Phone (optional)")}
          />
        </div>

        <div>
          <CoreComponents.input
            id="body"
            name="body"
            value=""
            type="textarea"
            class={"textarea #{@input_color_class} w-full"}
            error_class={@input_error_class}
            placeholder={gettext("Write your message here...")}
            rows="4"
            required
          />
        </div>

        <.form_checkbox_or_radio_group
          :if={@client_needs}
          input_name="project_types[]"
          options={@client_needs}
          title={gettext("SERVICES (multiple selection)")}
        />
        <.form_checkbox_or_radio_group
          :if={@client_budgets}
          input_name="project_budget"
          options={@client_budgets}
          title={gettext("PROJECT BUDGET")}
          group_type="radio"
          other_input_type="number"
        />
        <Button.primary_button text={gettext("Send")} class="mt-4" type="submit" />
      </form>
    </div>
    """
  end

  @doc """
  Renders a customizable input field for the contact form.

  ## Form HTML attributes inside `rest` global attribute:
    - `id`: The ID of the input field.
    - `name`: The name of the input field.
    - `placeholder`: The placeholder text for the input field.
    - `class`: Additional CSS classes to apply to the input field.
    - `type`: The type of the input field (default: "text").
    - `required`: Whether the input field is required (default: true).
    - `disabled`: Whether the input field is disabled (default: false).
    - `autocomplete`: The autocomplete attribute for the input field (default: "off").
  """
  attr :rest, :global, include: ~w"name type placeholder required disbaled autocomplete"

  def form_input(assigns) do
    ~H"""
    <input
      class={"input input-secondary #{@rest[:class]}"}
      name={@rest[:name]}
      placeholder={@rest[:placeholder]}
      type={@rest[:type]}
      required={@rest[:required]}
      disabled={@rest[:disabled]}
      {@rest}
    />
    """
  end

  @doc """
  Renders a checkboxes or radio buttons group to use inside a form.

  ## Examples:

      <.form_checkbox_or_radio_group
          input_name="input_name[]"
          options={@list_of_options}
          title="Input group title"
          group_type="checkbox"
          other_input_type="text" />

        <.form_checkbox_or_radio_group
          input_name="input_name"
          options={@list_of_options}
          title="Input group title"
          group_type="radio"
          other_input_type="number"/>
  """
  attr :options, :list, required: true
  attr :title, :string, default: "Services"
  attr :group_type, :string, values: ~w(radio checkbox), default: "checkbox"
  attr :other_input_type, :string, values: ~w(text number), default: "text"
  attr :input_name, :string, required: true

  def form_checkbox_or_radio_group(assigns) do
    ~H"""
    <div>
      <h3 class="block text-base font-common font-normal my-4 tracking-widest">
        {@title}
      </h3>
      <div class="flex flex-col lg:flex-row flex-wrap gap-y-4 gap-x-3">
        <div
          :for={option <- @options}
          class={"#{option.shows_text_input_when_checked && "flex items-center gap-2"}"}
        >
          <label class="label peer flex items-center gap-2 text-sm font-common text-base-content">
            <input
              type={@group_type}
              name={@input_name}
              value={option.value}
              class={
                if @group_type == "radio",
                  do: "radio radio-secondary radio-sm",
                  else: "checkbox checkbox-secondary checkbox-md"
              }
            />
            {option.label}
          </label>

          <.form_input
            :if={option.shows_text_input_when_checked}
            type={@other_input_type}
            name={@input_name}
            required={false}
            placeholder={gettext("Specify")}
            class="hidden peer-has-checked:flex w-full"
          />
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a gallery of clickable images to be selected inside a Liveview.
  A phx-click attribute must be passed as global attribute so the
  selected image url can be stored into the Liveview socket before being
  merge into the form params map.

  ## Example:

      <.image_gallery_input
        img_urls_list=["http://...", ...]
        selected_img_url={@selected_image}
        phx-click="handle-image-selection" />
  """
  attr :img_urls_list, :list, required: true, doc: "The list of image urls."
  attr :selected_img_url, :string, default: "", doc: "The url of the icon selected by the user."
  attr :rest, :global

  def image_gallery_input(assigns) do
    ~H"""
    <span class="fieldset-label mb-1 text-sm">Choose an icon for this social media </span>
    <div class="grid grid-cols-4 mb-5 rounded-sm overflow-auto gap-4 w-full h-[50vh] p-4 border-1 border-black">
      <%= for image_url <- @img_urls_list || [] do %>
        <div
          class={
            ~s"cursor-pointer transition-transform duration-300 hover:scale-103 hover:border-[#6B4BA1] active:border-[#6B4BA1] p-1 border-4 rounded-sm #{(@selected_img_url == image_url && "border-[#6B4BA1]") || "border-base-200"}"
          }
          phx-value-url={image_url}
          {@rest}
        >
          <img id={"social-media-icon-url-#{image_url}"} src={image_url} height="200" width="200" />
        </div>
      <% end %>
    </div>
    """
  end
end
