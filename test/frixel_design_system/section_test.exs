defmodule FrixelDesignSystem.SectionTest do
  alias FrixelDesignSystem.Section
  alias FrixelDesignSystem.Components.{Company, Form, Menu}
  use ComponentCase

  test "contact_section" do
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

    company_description = "This is a description with \n end of line"
    company_name = "company_name"
    company_postal_address = "company_postal_address"
    company_email_address = "33, avenue des chances, 87999, Landville"
    company_phone_number = "company_phone_number"
    company_lattitude = "12.856"
    company_longitude = "3.865"

    company_social_media_links = [
      %{social_media_url: "https://github.com", icon: "/images/github_logo.png"},
      %{social_media_url: "https://linkedin.com", icon: :linkedin, icon_class: "fill-red-500"}
    ]

    assigns = %{
      company_description: company_description,
      company_name: company_name,
      company_postal_address: company_postal_address,
      company_email_address: company_email_address,
      company_phone_number: company_phone_number,
      company_social_media_links: company_social_media_links,
      company_lattitude: company_lattitude,
      company_longitude: company_longitude,
      client_needs: client_needs,
      client_budgets: client_budgets,
      booking_appointment_url: booking_appointment_url
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.contact_section>
        <:contact_infos>
          <Company.contact_informations title="Find us">
            <:contact_details>
              <Company.contact_details
                company_name={@company_name}
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
          </Company.contact_informations>
        </:contact_infos>

        <:contact_form>
          <Form.contact_form
            title="My form"
            client_needs={@client_needs}
            client_budgets={@client_budgets}
            booking_appointment_url={@booking_appointment_url}
            phx-submit="submit_contact_form"
          />
        </:contact_form>

        <:map>
          <Company.find_us_map
            company_lattitude={@company_lattitude}
            company_longitude={@company_longitude}
            marker_icon_url="/path/to/my/company/icon.mini"
          />
        </:map>
      </Section.contact_section>
      """)}"

    assert html =~ "This is a description with \n end of line"
    assert html =~ "<img "
    assert html =~ "https://github.com"
    assert html =~ "<svg "
    assert html =~ "fill-red-500"
    assert html =~ "https://linkedin.com"
    assert html =~ "/path/to/my/company/icon.mini"
    assert html =~ "My form"
    assert html =~ "https://www.booking-appointement-url.com"
  end

  test "brand_showcase_section renders correctly with brands" do
    brands = [
      %{name: "Brand 1", logo_url: "/images/brand1.png", alt_text: "Logo Brand 1"},
      %{name: "Brand 2", logo_url: "/images/brand2.png", alt_text: "Logo Brand 2"},
      %{name: "Brand 3", logo_url: "/images/brand3.png", alt_text: "Logo Brand 3"}
    ]

    assigns = %{
      title: "Nos partenaires",
      description: "Ils nous font confiance",
      brands: brands
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.brand_showcase_section
        title={@title}
        description={@description}
        brands={@brands}
      />
      """)}"

    assert html =~ "Nos partenaires"
    assert html =~ "Ils nous font confiance"
    assert html =~ "brand-showcase-grid"
    assert html =~ "Brand 1"
    assert html =~ "/images/brand1.png"
    assert html =~ "Logo Brand 1"
  end

  test "brand_showcase_section renders correctly with more than 4 brands (carousel mode)" do
    brands = [
      %{name: "Brand 1", logo_url: "/images/brand1.png", alt_text: "Logo Brand 1"},
      %{name: "Brand 2", logo_url: "/images/brand2.png", alt_text: "Logo Brand 2"},
      %{name: "Brand 3", logo_url: "/images/brand3.png", alt_text: "Logo Brand 3"},
      %{name: "Brand 4", logo_url: "/images/brand4.png", alt_text: "Logo Brand 4"},
      %{name: "Brand 5", logo_url: "/images/brand5.png", alt_text: "Logo Brand 5"},
      %{name: "Brand 6", logo_url: "/images/brand6.png", alt_text: "Logo Brand 6"}
    ]

    assigns = %{
      title: "Nos partenaires de confiance",
      description: "Plus de 6 marques nous font confiance",
      brands: brands
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.brand_showcase_section
        title={@title}
        description={@description}
        brands={@brands}
      />
      """)}"

    assert html =~ "Nos partenaires de confiance"
    assert html =~ "Plus de 6 marques nous font confiance"

    assert html =~ "brand-showcase-carousel"
    refute html =~ "brand-showcase-grid"

    assert html =~ "phx-hook=\"BrandShowcaseAutoScroll\""

    assert html =~ "overflow-x-auto overflow-y-hidden scrollbar-hide"
    assert html =~ "animate-scroll"

    assert html =~ "Brand 1"
    assert html =~ "/images/brand1.png"
    assert html =~ "Logo Brand 1"
    assert html =~ "Brand 5"
    assert html =~ "/images/brand5.png"
    assert html =~ "Logo Brand 5"
    assert html =~ "Brand 6"
    assert html =~ "/images/brand6.png"
    assert html =~ "Logo Brand 6"

    assert html =~ "flex-shrink-0"
  end

  test "client_section" do
    assigns = %{}

    html =
      "#{rendered_to_string(~H"""
      <Section.client_section />
      """)}"

    assert html =~
             "<section class=\"my-16 max-w-xl mx-auto\">\n  <div class=\"card bg-base-200 shadow-xl py-6 px-8\">\n    <div class=\"flex items-center justify-between mb-8\">\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest \">\n  Leave a review\n</h3>\n    </div>\n    <form class=\"flex flex-col gap-8 \">\n  <div class=\"flex gap-4\">\n    <div class=\"w-1/2\">\n      <input class=\"input input-secondary w-full\" name=\"author\" placeholder=\"Your name\" required id=\"author\" name=\"author\" required class=\"w-full\" placeholder=\"Your name\">\n    </div>\n    <div class=\"w-1/2\">\n      <input class=\"input input-secondary w-full\" name=\"role\" placeholder=\"Your role\" required id=\"role\" name=\"role\" required class=\"w-full\" placeholder=\"Your role\">\n    </div>\n  </div>\n  <div>\n    <input class=\"input input-secondary w-full\" name=\"company\" placeholder=\"Company name\" required id=\"company\" name=\"company\" required class=\"w-full\" placeholder=\"Company name\">\n  </div>\n  <div>\n    <textarea id=\"content\" name=\"content\" placeholder=\"Write your review here...\" class=\"textarea textarea-bordered w-full input-secondary\" rows=\"4\" required></textarea>\n  </div>\n  <button class=\"flex btn btn-secondary mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103 mt-4\" type=\"submit\">\n  Submit review\n  \n  \n</button>\n</form>\n  </div>\n</section>"
  end

  test "base_header" do
    branding_name = "Branding name"
    branding_logo_url = "https://www.booking-appointement-url.com"
    call_to_action_name = "call to action"
    call_to_action_path = "https://www.call-to-action-path.com"

    header_links = [
      %{
        name: "Services",
        path: "/#services",
        description: "A link to go to the services section.",
        link_position: 2,
        visibility: :visible
      },
      %{
        name: "Trash",
        path: "/#trash",
        description: "A link to go to the trash section.",
        link_position: 3,
        visibility: :hidden
      },
      %{
        name: "Projets",
        path: "/#projects",
        description: "A link to go to the projects section.",
        link_position: 1,
        visibility: :visible
      }
    ]

    assigns = %{
      branding_name: branding_name,
      branding_logo_url: branding_logo_url,
      call_to_action_name: call_to_action_name,
      call_to_action_path: call_to_action_path,
      header_links: header_links,
      enable_theme_switcher?: false
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.base_header class="bg-white text-marine-blue border-b border-brick-orange">
        <:branding>
          <Company.branding
            brand_name={@branding_name}
            brand_img={@branding_logo_url}
          />
        </:branding>

        <:navbar>
          <Menu.navbar
            links={@header_links}
            enable_theme_switcher?={@enable_theme_switcher?}
            call_to_action_name={@call_to_action_name}
            call_to_action_path={@call_to_action_path}
          />
        </:navbar>
      </Section.base_header>
      """)}"

    assert html =~ "Services"
    assert html =~ "/#services"
    assert html =~ "Projets"
    assert html =~ "/#projects"
    refute html =~ "Trash"
    refute html =~ "/#trash"
    assert html =~ "Branding name"
    assert html =~ "https://www.booking-appointement-url.com"
    assert html =~ "call to action"
    assert html =~ "https://www.call-to-action-path.com"
  end

  test "base_header_commerce" do
    branding_name = "Frixel"
    branding_logo_url = "/images/logo.svg"
    is_connected = false
    is_admin = false
    user_email = nil

    call_to_actions = [
      %{type: :login, path: "/log-in"},
      %{type: :logout, path: "/log-out"},
      %{type: :settings, path: "/settings"},
      %{type: :admin_logout, path: "/admin/log-out"},
      %{type: :admin_settings, path: "/admin/settings"},
      %{type: :cart, path: "/cart"}
    ]

    header_links = [
      %{
        name: "Pret-à-porter",
        path: "/pret-a-porter",
        dropdown: [
          %{path: "/about/team", name: "T-Shirt", visibility: :visible},
          %{path: "/about/company", name: "Pants", visibility: :visible}
        ],
        collections: [
          %{
            path: "/pret-a-porter/été",
            name: "Eté",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/printemps",
            name: "Printemps",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/autumn",
            name: "Autumn",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          }
        ],
        visibility: :visible
      },
      %{
        name: "High-Tech",
        path: "/high-tech",
        dropdown: [
          %{path: "/contact/email", name: "PC", visibility: :visible},
          %{path: "/contact/phone", name: "Phone", visibility: :visible}
        ],
        collections: [
          %{
            path: "/pret-a-porter/été",
            name: "Eté",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/printemps",
            name: "Printemps",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/autumn",
            name: "Autumn",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          }
        ],
        visibility: :visible
      },
      %{
        name: "Joaillerie",
        path: "/joaillerie",
        dropdown: [
          %{path: "/contact/email", name: "PC", visibility: :visible},
          %{path: "/contact/phone", name: "Phone", visibility: :visible}
        ],
        collections: [
          %{
            path: "/pret-a-porter/été",
            name: "Eté",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/printemps",
            name: "Printemps",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/autumn",
            name: "Autumn",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          }
        ],
        visibility: :visible
      },
      %{
        name: "Accessoires",
        path: "/accessoires",
        dropdown: [
          %{path: "/contact/email", name: "PC", visibility: :visible},
          %{path: "/contact/phone", name: "Phone", visibility: :visible}
        ],
        collections: [
          %{
            path: "/pret-a-porter/été",
            name: "Eté",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/printemps",
            name: "Printemps",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/autumn",
            name: "Autumn",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          }
        ],
        visibility: :visible
      },
      %{
        name: "Cadeaux",
        path: "/cadeaux",
        dropdown: [
          %{path: "/contact/email", name: "PC", visibility: :visible},
          %{path: "/contact/phone", name: "Phone", visibility: :visible}
        ],
        collections: [
          %{
            path: "/pret-a-porter/été",
            name: "Eté",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/printemps",
            name: "Printemps",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          },
          %{
            path: "/pret-a-porter/autumn",
            name: "Autumn",
            visibility: :visible,
            image_url: "/images/placeholder.png"
          }
        ],
        visibility: :visible
      }
    ]

    assigns = %{
      branding_name: branding_name,
      branding_logo_url: branding_logo_url,
      is_connected: is_connected,
      is_admin: is_admin,
      user_email: user_email,
      call_to_actions: call_to_actions,
      header_links: header_links
    }

    html =
      "#{rendered_to_string(~H"""
      <FrixelDesignSystem.Section.base_header_commerce
        branding_name={@branding_name}
        branding_logo_url={@branding_logo_url}
        is_connected={@is_connected}
        is_admin={@is_admin}
        user_email={@user_email}
        call_to_actions={@call_to_actions}
        header_links={@header_links}
      />
      """)}"

    assert html =~ "Pret-à-porter"
    assert html =~ "/pret-a-porter"
    assert html =~ "T-Shirt"
    assert html =~ "/about/team"
    assert html =~ "High-Tech"
    assert html =~ "/high-tech"
    assert html =~ "PC"
    assert html =~ "/contact/email"
    assert html =~ "Phone"
    assert html =~ "/contact/phone"
  end

  test "base_footer" do
    branding_name = "Branding name"
    branding_logo_url = "/path/to/branding/logo.png"
    company_postal_address = "1 test street, 1234 Testville"
    company_email_address = "test@test.com"
    company_phone_number = "+1234567890"

    footer_links = [
      %{
        name: "legal-information",
        path: "/#legal-information",
        description: "A link to go to the legal-information page.",
        link_position: 2,
        visibility: :visible
      },
      %{
        name: "cgu",
        path: "/#cgu",
        description: "A link to go to the CGU page.",
        link_position: 2,
        visibility: :visible
      }
    ]

    social_medias = [
      %{social_media_url: "https://github.com", icon: "/images/github_logo.png"},
      %{social_media_url: "https://linkedin.com", icon: :linkedin, icon_class: "fill-red-500"}
    ]

    assigns = %{
      branding_name: branding_name,
      branding_logo_url: branding_logo_url,
      company_postal_address: company_postal_address,
      company_email_address: company_email_address,
      company_phone_number: company_phone_number,
      social_medias: social_medias,
      footer_links: footer_links
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.base_footer
        class="bg-sky-blue"
        socials_title="Retrouvez-nous-sur les réseaux:"
      >
        <:contact>
          <Company.contact_details
            brand_name={@branding_name}
            brand_img={@branding_logo_url}
            company_postal_address={@company_postal_address}
            company_email_address={@company_email_address}
            company_phone_number={@company_phone_number}
          />
        </:contact>

        <:socials>
          <Menu.socials_list socials={@social_medias} is_icon_rounded?={true} />
        </:socials>

        <:legal>
          <Menu.legal_and_copyright
            links={@footer_links}
            brand_name={@branding_name}
            show_made_by?={true}
          />
        </:legal>
      </Section.base_footer>
      """)}"

    assert html =~ "Branding name"
    assert html =~ "bg-sky-blue"
    assert html =~ "Retrouvez-nous-sur les réseaux:"
    assert html =~ "legal-information"
    assert html =~ "cgu"
    assert html =~ "<img "
    assert html =~ "https://github.com"
    assert html =~ "<svg "
    assert html =~ "fill-red-500"
    assert html =~ "https://linkedin.com"
  end

  test "landing_section" do
    title = "Title"
    text = "A simple text"
    subtext = "A simple subtext"
    logo_src = "/images/logo.png"
    link_name = "link_name"
    link_path = "https://wwww.link_path.fr"
    call_to_action_name = "call_to_action_name"
    call_to_action_path = "https://wwww.call_to_action_name.fr"

    tools = [
      %{
        name: "Elixir",
        description: "",
        website_link: "https://elixir-lang.org/",
        logo_url: "/images/elixir_logo.png"
      },
      %{
        name: "Phoenix",
        description: "",
        website_link: "https://www.phoenixframework.org/",
        logo_url: "/images/phoenix_logo.png"
      }
    ]

    assigns = %{
      title: title,
      text: text,
      subtext: subtext,
      logo_src: logo_src,
      link_name: link_name,
      link_path: link_path,
      call_to_action_name: call_to_action_name,
      call_to_action_path: call_to_action_path,
      tools: tools
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.landing_section
        title={@title}
        text={@text}
        subtext={@subtext}
        logo_src={@logo_src}
        link_name={@link_name}
        link_path={@link_path}
        call_to_action_name={@call_to_action_name}
        call_to_action_path={@call_to_action_path}
        tools={@tools}
      />
      """)}"

    assert html =~
             "<section id=\"landing-section\" phx-hook=\"LandingAnimationHook\" class=\"relative flex justify-center items-center max-w-2xl text-center mx-auto invisible\">\n  <div class=\"content relative z-1\">\n    <figure class=\"flex justify-center mb-6\">\n      <img src=\"/images/logo.png\" alt=\"Logo\" class=\"h-34 w-34 object-contain rounded-2xl shadow-xl\">\n    </figure>\n\n    <h2 class=\"max-w-sm sm:max-w-none text-5xl sm:text-6xl font-bold font-title mx-auto pt-10 pb-15 mb-6 text-shadow-lg\">\n      Title\n    </h2>\n\n    <p class=\"text-base font-common mb-12\">A simple text</p>\n\n    <p class=\"text-base font-common font-bold\">A simple subtext</p>\n\n    <div class=\"avatar rounded-xl flex-wrap my-8\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://elixir-lang.org/\" target=\"_blank\" title=\"Elixir\">\n          <img class=\"w-4 h-4\" src=\"/images/elixir_logo.png\" alt=\"Elixir\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://www.phoenixframework.org/\" target=\"_blank\" title=\"Phoenix\">\n          <img class=\"w-4 h-4\" src=\"/images/phoenix_logo.png\" alt=\"Phoenix\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n\n    <div class=\"flex flex-col lg:flex-row justify-center items-center gap-4 mb-4\">\n      <a href=\"https://wwww.call_to_action_name.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\">\n        <button class=\"flex btn btn-accent mx-2 px-8 py-4 rounded-sm text-base-content font-common font-normal text-sm hover:shadow-lg transition-transform duration-300 hover:scale-103\">\n  call_to_action_name\n  <span class=\"hero-arrow-right-solid w-5 h-5\"></span>\n  \n</button>\n      </a>\n\n      <a href=\"https://wwww.link_path.fr\" data-phx-link=\"redirect\" data-phx-link-state=\"push\" class=\"underline text-xl font-slogan text-accent hover:text-primary\">\n        link_name\n      </a>\n    </div>\n  </div>\n</section>"
  end

  test "services_section" do
    services = [
      %{
        id: "1",
        name: "A single service",
        logo: "/path/to/logo.png",
        description: "A single description of service #1"
      },
      %{
        id: "2",
        name: "A single service #2",
        logo: "/path/to/logo_2.png #2",
        description: "A single description of service #2"
      },
      %{
        id: "3",
        name: "A single service #3",
        logo: "/path/to/logo_3.png #3",
        description: "A single description of service #3"
      }
    ]

    assigns = %{
      class: "flex text-center p-4",
      services: services
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.services_section class={@class} services={@services} />
      """)}"

    assert html =~
             "<section id=\"services\" class=\"px-12 pt-20\">\n  <h2 class=\"text-base-content text-center text-4xl font-slogan font-bold mt-6 mb-6 tracking-widest pb-12\">\n  Our services\n</h2>\n  <div class=\"flex justify-center flex-wrap gap-16\">\n    \n      <label for=\"service_modal_1\" class=\"cursor-pointer block\">\n  <div class=\"bg-base-200 border-base-300 border w-64 h-60 flex flex-col items-center justify-center rounded-xl transform duration-300 hover:shadow-xl hover:scale-110\">\n    <div class=\"flex flex-col items-center justify-center flex-1 w-full\">\n      <figure class=\"flex justify-center\">\n        <img src=\"/path/to/logo.png\" alt=\"A single service illustration\" width=\"20\" height=\"20\" class=\"rounded-xl size-20\">\n      </figure>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-base mt-6 px-4\">\n  A single service\n</h3>\n    </div>\n  </div>\n</label>\n<input type=\"checkbox\" id=\"service_modal_1\" class=\"modal-toggle\">\n<div class=\"modal z-1001\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-lg relative\">\n    <label for=\"service_modal_1\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure class=\"flex justify-center py-6\">\n      <img src=\"/path/to/logo.png\" alt=\"A single service\" class=\"rounded-xl size-24\">\n    </figure>\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-2xl\">\n  A single service\n</h3>\n    <div class=\"text-base text-center py-4\">\n      <p>A single description of service #1</p>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"service_modal_1\">Close</label>\n</div>\n    \n      <label for=\"service_modal_2\" class=\"cursor-pointer block\">\n  <div class=\"bg-base-200 border-base-300 border w-64 h-60 flex flex-col items-center justify-center rounded-xl transform duration-300 hover:shadow-xl hover:scale-110\">\n    <div class=\"flex flex-col items-center justify-center flex-1 w-full\">\n      <figure class=\"flex justify-center\">\n        <img src=\"/path/to/logo_2.png #2\" alt=\"A single service #2 illustration\" width=\"20\" height=\"20\" class=\"rounded-xl size-20\">\n      </figure>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-base mt-6 px-4\">\n  A single service #2\n</h3>\n    </div>\n  </div>\n</label>\n<input type=\"checkbox\" id=\"service_modal_2\" class=\"modal-toggle\">\n<div class=\"modal z-1001\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-lg relative\">\n    <label for=\"service_modal_2\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure class=\"flex justify-center py-6\">\n      <img src=\"/path/to/logo_2.png #2\" alt=\"A single service #2\" class=\"rounded-xl size-24\">\n    </figure>\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-2xl\">\n  A single service #2\n</h3>\n    <div class=\"text-base text-center py-4\">\n      <p>A single description of service #2</p>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"service_modal_2\">Close</label>\n</div>\n    \n      <label for=\"service_modal_3\" class=\"cursor-pointer block\">\n  <div class=\"bg-base-200 border-base-300 border w-64 h-60 flex flex-col items-center justify-center rounded-xl transform duration-300 hover:shadow-xl hover:scale-110\">\n    <div class=\"flex flex-col items-center justify-center flex-1 w-full\">\n      <figure class=\"flex justify-center\">\n        <img src=\"/path/to/logo_3.png #3\" alt=\"A single service #3 illustration\" width=\"20\" height=\"20\" class=\"rounded-xl size-20\">\n      </figure>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-base mt-6 px-4\">\n  A single service #3\n</h3>\n    </div>\n  </div>\n</label>\n<input type=\"checkbox\" id=\"service_modal_3\" class=\"modal-toggle\">\n<div class=\"modal z-1001\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-lg relative\">\n    <label for=\"service_modal_3\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure class=\"flex justify-center py-6\">\n      <img src=\"/path/to/logo_3.png #3\" alt=\"A single service #3\" class=\"rounded-xl size-24\">\n    </figure>\n    <h3 class=\"text-xl font-slogan font-bold tracking-widest text-center text-2xl\">\n  A single service #3\n</h3>\n    <div class=\"text-base text-center py-4\">\n      <p>A single description of service #3</p>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"service_modal_3\">Close</label>\n</div>\n    \n  </div>\n</section>"
  end

  test "introduction_section" do
    assigns = %{
      section_title: "Section title",
      card_title: "Card ttitle",
      text: "Text",
      img_src: "/path/to/img_src.png"
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.introduction_section
        section_title={@section_title}
        card_title={@card_title}
        text={@text}
        img_src={@img_src}
        card_class="bg-emerald-400"
      />
      """)}"

    assert html =~ "Section title"
    assert html =~ "Card ttitle"
    assert html =~ "Text"
    assert html =~ "src=\"/path/to/img_src.png\""
  end

  test "values section" do
    company_values = [
      %{
        name: "A single value",
        description: "A single description of value"
      }
    ]

    assigns = %{
      title: "Section title",
      company_values: company_values
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.values_section title={@title} company_values={@company_values} />
      """)}"

    assert html =~ "Section title"
    assert html =~ "A single value"
    assert html =~ "A single description of value"
  end

  test "review_section" do
    reviews = [
      %{
        author_picture: "/path/to/your/client/toto.jpg",
        author: "Toto",
        role: "Head of Marketing of Simile Corp.",
        content: "Best company ever"
      },
      %{
        author_picture: "/path/to/your/client/titi.jpg",
        author: "Titi",
        role: "CEO of Simile Corp.",
        content: "The dream tem in flesh"
      }
    ]

    assigns = %{reviews: reviews}

    html =
      "#{rendered_to_string(~H"""
      <Section.review_section reviews={@reviews} />
      """)}"

    assert html =~
             "<section class=\"my-16\">\n  <h2 class=\"text-base-content text-center text-4xl font-slogan font-bold mt-6 mb-6 tracking-widest \">\n  What our clients say\n</h2>\n  <div class=\"flex items-center justify-center flex-wrap gap-14\">\n    \n      <div class=\"min-h-64 max-w-xl bg-base-100 shadow-lg rounded-lg p-6 flex items-center gap-4\">\n  <img src=\"/path/to/your/client/toto.jpg\" alt=\"Toto profile\" class=\"w-14 h-14 md:w-24 md:h-24 xl:w-34 xl:h-34 mx-4 lg:mx-8 rounded-full object-cover border-4 border-primary\">\n  <div>\n    <p class=\"text-md italic font-common mb-4 break-all\">\"Best company ever\"</p>\n    <div class=\"font-bold font-common text-base-content\">Toto</div>\n    <div class=\"text-sm font-common text-base-content/70 whitespace-nowrap\">\n      Head of Marketing of Simile Corp.\n    </div>\n  </div>\n</div>\n    \n      <div class=\"min-h-64 max-w-xl bg-base-100 shadow-lg rounded-lg p-6 flex items-center gap-4\">\n  <img src=\"/path/to/your/client/titi.jpg\" alt=\"Titi profile\" class=\"w-14 h-14 md:w-24 md:h-24 xl:w-34 xl:h-34 mx-4 lg:mx-8 rounded-full object-cover border-4 border-primary\">\n  <div>\n    <p class=\"text-md italic font-common mb-4 break-all\">\"The dream tem in flesh\"</p>\n    <div class=\"font-bold font-common text-base-content\">Titi</div>\n    <div class=\"text-sm font-common text-base-content/70 whitespace-nowrap\">\n      CEO of Simile Corp.\n    </div>\n  </div>\n</div>\n    \n  </div>\n</section>"
  end

  test "story_section" do
    team_members = [
      %{
        name: "Johanne-Franck NGBOKOLI",
        description: "",
        job_title: "Développeur Senior Fullstack",
        avatar_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1745939833/pp_2_spxojb.png",
        linkedin_url: "https://www.linkedin.com/in/johanne-franck-ngbokoli/",
        github_url: "https://github.com/FranckNGB"
      },
      %{
        name: "Simon TIRANT",
        description: "",
        job_title: "Développeur Senior Fullstack",
        avatar_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1745939834/pp_3_ry9k37.png",
        linkedin_url: "https://www.linkedin.com/in/simontirant/",
        github_url: "https://github.com/Sancxo"
      }
    ]

    skills = [
      %{
        name: "Agile",
        description: "Agilité dans la collaboration",
        logo_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1747385561/people-arrows-solid_tq3qut.svg"
      },
      %{
        name: "Elixir/Phoenix",
        description: "Expert en Elixir",
        logo_url:
          "https://res.cloudinary.com/dekpcimmm/image/upload/v1747385563/phoenix-framework-brands_mn8rju.svg"
      }
    ]

    assigns = %{
      title: "Story section",
      description: "Here a single description of the section",
      team_members: team_members,
      skills: skills
    }

    html =
      "#{rendered_to_string(~H"""
      <Section.story_section
        title={@title}
        description={@description}
        team_members={@team_members}
        skills={@skills}
      />
      """)}"

    assert html =~ "Story section"
    assert html =~ "Here a single description of the section"
  end

  test "projects_section" do
    projects = [
      %{
        id: "1",
        name: "Simple website",
        short_description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        long_description:
          "[bold Inter Gestion REIM bold] est une société de gestion de portefeuille spécialisée dans la création, la gestion et la commercialisation de SCPI (Sociétés Civiles de Placement Immobilier). Elle propose à ses clients, particuliers comme professionnels, des solutions d’investissement immobilier diversifiées et accessibles, avec une expertise reconnue dans la structuration de portefeuilles et la gestion d’actifs immobiliers.

         Dans le contexte de la refonte de son site internet corporate, nous avons réalisé un site web sur-mesure. L’objectif principal était de fournir à Inter Gestion une plateforme digitale moderne, performante et complètement autonome en matière de gestion de contenu. Nous avons donc développé un éditeur de pages personnalisé, offrant une expérience de type [bold site builder bold], directement intégrée à un panel administrateur :
         [list
          [elem [bold Édition en glisser-déposer bold] (drag & drop) afin de ré-organiser facilement les sections et blocs présents sur les pages du site web elem][elem [bold Duplication, suppression et ajout de blocs/sections bold] pour faciliter la mise en page et la gestion du contenu. elem][elem [bold Édition des textes, images, liens et composants bold] avec un rendu en temps réel elem][elem [bold Création de pages dynamiques bold] via un module personnalisable elem]
         list][text D'un point de vue technique, ce projet a été conçu avec une architecture robuste, résiliente et évolutive avec une séparation complète entre la gestion de la donnée et sa présentation.\n
         Avec cet outil, Inter Gestion peut gérer le contenu de son site corporate en toute autonomie. La mise à jour des pages (sections, blocs, images, et autres) se fait sans l'intervention des développeurs. Avec cette approche, Inter Gestion peut s'assurer d'avoir une présentation [bold claire, moderne et plus détaillée bold] de ses produits SCPI. text]
        ",
        illustration_urls: [
          "https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png",
          "https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_2.png",
          "https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png"
        ],
        project_url: "https://www.inter-gestion.com",
        tags: ["cms personnalisé", "drag n drop"],
        participants: [
          %{
            name: "Inter Gestion",
            avatar_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1748247801/favicon.svg",
            social_link: "https://www.linkedin.com/company/tit"
          },
          %{
            name: "Frixel",
            avatar_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg",
            social_link: "https://www.linkedin.com/company/frixel-tech"
          }
        ],
        tools: [
          %{
            name: "Elixir",
            website_link: "https://elixir-lang.org/",
            logo_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1748272994/1466749648elixir-logo_pdrxy6.png"
          },
          %{
            name: "Phoenix",
            website_link: "https://www.phoenixframework.org/",
            logo_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1746781053/phoenix_logo_zyugm8.png"
          }
        ]
      },
      %{
        id: "2",
        name: "Simple website",
        short_description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        long_description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\n Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        illustration_urls: [
          "https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png",
          "https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png"
        ],
        project_url: "https://www.inter-gestion.com",
        tags: ["tag", "tag#2", "tag#3", "tag#4"],
        participants: [
          %{
            name: "Frixel",
            avatar_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg",
            social_link: "https://www.linkedin.com/company/frixel-tech"
          }
        ],
        tools: [
          %{
            name: "Phoenix",
            website_link: "https://www.phoenixframework.org/",
            logo_url:
              "https://res.cloudinary.com/dekpcimmm/image/upload/v1746781053/phoenix_logo_zyugm8.png"
          }
        ]
      }
    ]

    assigns = %{projects: projects}

    html =
      "#{rendered_to_string(~H"""
      <Section.projects_section projects={@projects} />
      """)}"

    assert html =~
             "<section id=\"projects\" class=\"flex flex-col justify-center items-center gap-4 w-full items-stretch pt-20 relative\">\n  <h2 class=\"text-base-content text-center text-4xl font-slogan font-bold mt-6 mb-6 tracking-widest \">\n  Our projects\n</h2>\n\n  <div class=\"flex flex-col md:flex-row flex-wrap gap-4 justify-center items-center\">\n    \n      <label for=\"modal_project-1\" class=\"card relative sm:min-w-80 w-fit sm:w-1/2 lg:w-1/3 2xl:w-1/4 m-8 bg-base-200 shadow-lg transition-transform duration-300 hover:shadow-xl hover:scale-110 cursor-pointer h-160\">\n  <figure>\n    <div class=\"carousel w-full\">\n  \n    <div id=\"/projectproject-1/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide3\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-1/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_2.png\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide3\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-1/slide3\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png\" alt=\"Project image 3\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n  </figure>\n\n  <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      cms personnalisé\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      drag n drop\n    </li>\n  \n</ul>\n\n  <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/tit\" target=\"_blank\" title=\"Inter Gestion\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1748247801/favicon.svg\" alt=\"Inter Gestion\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/frixel-tech\" target=\"_blank\" title=\"Frixel\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg\" alt=\"Frixel\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n\n  <div class=\"card-body pb-12\">\n    <a href=\"https://www.inter-gestion.com\" aria-label=\"card presenting a project\" class=\"card-title text-xl font-bold font-common py-3 inline-block\">\n  Simple website\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n\n    <p class=\"text-base font-common\">\n      Lorem Ipsum is simply dummy text of the printing and typesetting industry\n    </p>\n  </div>\n</label>\n\n<input type=\"checkbox\" id=\"project-1\" class=\"modal-toggle\">\n<div class=\"modal z-5\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-5xl relative\">\n    <label for=\"project-1\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure>\n      <div class=\"carousel w-full\">\n  \n    <div id=\"/projectproject-1/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide3\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-1/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_2.png\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide3\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-1/slide3\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png\" alt=\"Project image 3\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-1/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-1/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </figure>\n    <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      cms personnalisé\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      drag n drop\n    </li>\n  \n</ul>\n    <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/tit\" target=\"_blank\" title=\"Inter Gestion\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1748247801/favicon.svg\" alt=\"Inter Gestion\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/frixel-tech\" target=\"_blank\" title=\"Frixel\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg\" alt=\"Frixel\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    <div class=\"card-body pb-12\">\n      <a href=\"https://www.inter-gestion.com\" aria-label=\"modal presenting a project\" class=\"card-title text-2xl font-bold font-common py-7 inline-block\">\n  Simple website\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n      <p class=\"text-base font-common\">\n        <span class=\"font-bold font-common\"> Inter Gestion REIM </span> est une société de gestion de portefeuille spécialisée dans la création, la gestion et la commercialisation de SCPI (Sociétés Civiles de Placement Immobilier). Elle propose à ses clients, particuliers comme professionnels, des solutions d’investissement immobilier diversifiées et accessibles, avec une expertise reconnue dans la structuration de portefeuilles et la gestion d’actifs immobiliers.<br /><br />         Dans le contexte de la refonte de son site internet corporate, nous avons réalisé un site web sur-mesure. L’objectif principal était de fournir à Inter Gestion une plateforme digitale moderne, performante et complètement autonome en matière de gestion de contenu. Nous avons donc développé un éditeur de pages personnalisé, offrant une expérience de type <span class=\"font-bold font-common\"> site builder </span>, directement intégrée à un panel administrateur :<br />         <ul class=\"list-disc\"><br />          <li class=\"font-common\"> <span class=\"font-bold font-common\"> Édition en glisser-déposer </span> (drag & drop) afin de ré-organiser facilement les sections et blocs présents sur les pages du site web </li><li class=\"font-common\"> <span class=\"font-bold font-common\"> Duplication, suppression et ajout de blocs/sections </span> pour faciliter la mise en page et la gestion du contenu. </li><li class=\"font-common\"> <span class=\"font-bold font-common\"> Édition des textes, images, liens et composants </span> avec un rendu en temps réel </li><li class=\"font-common\"> <span class=\"font-bold font-common\"> Création de pages dynamiques </span> via un module personnalisable </li><br />         </ul><p class=\"font-common\"> D'un point de vue technique, ce projet a été conçu avec une architecture robuste, résiliente et évolutive avec une séparation complète entre la gestion de la donnée et sa présentation.<br /><br />         Avec cet outil, Inter Gestion peut gérer le contenu de son site corporate en toute autonomie. La mise à jour des pages (sections, blocs, images, et autres) se fait sans l'intervention des développeurs. Avec cette approche, Inter Gestion peut s'assurer d'avoir une présentation <span class=\"font-bold font-common\"> claire, moderne et plus détaillée </span> de ses produits SCPI. </p><br />        \n      </p>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest mt-5 text-left\">\n  Technologies used\n</h3>\n      <div class=\"avatar rounded-xl flex-wrap space-x-2 my-2 gap-2\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://elixir-lang.org/\" target=\"_blank\" title=\"Elixir\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1748272994/1466749648elixir-logo_pdrxy6.png\" alt=\"Elixir\">\n        </a>\n      </div>\n    </div>\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://www.phoenixframework.org/\" target=\"_blank\" title=\"Phoenix\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1746781053/phoenix_logo_zyugm8.png\" alt=\"Phoenix\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"project-1\">Close</label>\n</div>\n    \n      <label for=\"modal_project-2\" class=\"card relative sm:min-w-80 w-fit sm:w-1/2 lg:w-1/3 2xl:w-1/4 m-8 bg-base-200 shadow-lg transition-transform duration-300 hover:shadow-xl hover:scale-110 cursor-pointer h-160\">\n  <figure>\n    <div class=\"carousel w-full\">\n  \n    <div id=\"/projectproject-2/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-2/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-2/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-2/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-2/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-2/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n  </figure>\n\n  <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#2\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#3\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#4\n    </li>\n  \n</ul>\n\n  <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/frixel-tech\" target=\"_blank\" title=\"Frixel\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg\" alt=\"Frixel\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n\n  <div class=\"card-body pb-12\">\n    <a href=\"https://www.inter-gestion.com\" aria-label=\"card presenting a project\" class=\"card-title text-xl font-bold font-common py-3 inline-block\">\n  Simple website\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n\n    <p class=\"text-base font-common\">\n      Lorem Ipsum is simply dummy text of the printing and typesetting industry\n    </p>\n  </div>\n</label>\n\n<input type=\"checkbox\" id=\"project-2\" class=\"modal-toggle\">\n<div class=\"modal z-5\" role=\"dialog\">\n  <div class=\"modal-box w-full max-w-5xl relative\">\n    <label for=\"project-2\" class=\"btn btn-sm rounded-full mt-2 mr-2 mr-1 btn-circle absolute top-2 right-2 transition-transform duration-300 hover:scale-110 z-10\">\n  <span class=\"hero-x-mark-solid size-6\"></span>\n</label>\n    <figure>\n      <div class=\"carousel w-full\">\n  \n    <div id=\"/projectproject-2/slide1\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image.png\" alt=\"Project image 1\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-2/slide2\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-2/slide2\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n    <div id=\"/projectproject-2/slide2\" class=\"carousel-item relative w-full\">\n      <img src=\"https://res.cloudinary.com/dekpcimmmaa/image/upload/v17459375131/image_3.png\" alt=\"Project image 2\" height=\"80\" width=\"100\" class=\"mx-auto object-contain w-full sm:w-auto w-100 h-80 xl:h-full object-cover\">\n\n      <div class=\"absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between\">\n        <a href=\"#/projectproject-2/slide1\" class=\"btn btn-circle\">\n          ❮\n        </a>\n\n        <a href=\"#/projectproject-2/slide1\" class=\"btn btn-circle\">\n          ❯\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </figure>\n    <ul class=\"flex flex-wrap gap-2 pl-4 pt-6\">\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#2\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#3\n    </li>\n  \n    <li class=\"badge badge-outline badge-primary badge-xl font-slogan text-base-content px-2 py-1 rounded transition-transform duration-300 hover:scale-103\">\n      tag#4\n    </li>\n  \n</ul>\n    <div class=\"avatar flex-wrap rounded-xl space-x-2 ml-6 mt-3\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-8\">\n        <a href=\"https://www.linkedin.com/company/frixel-tech\" target=\"_blank\" title=\"Frixel\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1745940105/frixel_logo_hfa7gn.svg\" alt=\"Frixel\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    <div class=\"card-body pb-12\">\n      <a href=\"https://www.inter-gestion.com\" aria-label=\"modal presenting a project\" class=\"card-title text-2xl font-bold font-common py-7 inline-block\">\n  Simple website\n  <span class=\"hero-arrow-top-right-on-square size-4 pt-5 transition-transform duration-300 hover:scale-150\"></span>\n</a>\n      <p class=\"text-base font-common\">\n        Lorem Ipsum is simply dummy text of the printing and typesetting industry.<br /> Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum\n      </p>\n      <h3 class=\"text-xl font-slogan font-bold tracking-widest mt-5 text-left\">\n  Technologies used\n</h3>\n      <div class=\"avatar rounded-xl flex-wrap space-x-2 my-2 gap-2\">\n  \n    <div class=\"avatar rounded-xl hover:shadow-xl transition-transform duration-300 hover:scale-120\">\n      <div class=\"w-12\">\n        <a href=\"https://www.phoenixframework.org/\" target=\"_blank\" title=\"Phoenix\">\n          <img class=\"w-4 h-4\" src=\"https://res.cloudinary.com/dekpcimmm/image/upload/v1746781053/phoenix_logo_zyugm8.png\" alt=\"Phoenix\">\n        </a>\n      </div>\n    </div>\n  \n</div>\n    </div>\n  </div>\n  <label class=\"modal-backdrop\" for=\"project-2\">Close</label>\n</div>\n    \n  </div>\n</section>"
  end
end
