defmodule FrixelDesignSystem.MixProject do
  use Mix.Project

  def project do
    [
      app: :frixel_design_system,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      compilers: [:phoenix_live_view] ++ Mix.compilers(),
      listeners: [Phoenix.CodeReloader],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        quality: :test,
        wallaby: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.8.0"},
      {:phoenix_ecto, "~> 4.5"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.1"},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.2.0",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:httpoison, "~> 2.2"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.26"},
      {:jason, "~> 1.2"},
      {:credo, "~> 1.7"},
      # For tests
      {:mimic, "~> 1.7", only: :test},
      {:bypass, "~> 2.1", only: :test},
      {:lazy_html, ">= 0.0.0", only: :test},

      # Security
      {:content_security_policy, "~> 1.0"},
      {:sobelow, "~> 0.12", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      test: ["test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind frixel_design_system", "esbuild frixel_design_system"],
      "assets.deploy": [
        "tailwind frixel_design_system --minify",
        "esbuild frixel_design_system --minify",
        "phx.digest"
      ],
      # Run to check the quality of your code
      quality: [
        "format --check-formatted",
        "sobelow --config",
        "coveralls",
        "credo"
      ]
    ]
  end
end
