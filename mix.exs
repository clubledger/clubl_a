defmodule ClubLA.MixProject do
  use Mix.Project

  @version "1.1.0"

  def project do
    [
      app: :clubl_a,
      version: @version,
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ClubLA.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      {:bcrypt_elixir, "~> 2.0"},
      {:phoenix, "~> 1.6.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.0", override: true},
      {:floki, ">= 0.30.0"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.5.2"},
      {:phoenix_swoosh, "~> 1.0"},
      {:gen_smtp, "~> 1.0"},
      {:premailex, "~> 0.3.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:petal_components, "~> 0.13.4"},
      {:email_checker, "~> 0.1.2"},
      {:blankable, "~> 1.0.0"},
      {:currency_formatter, "~> 0.4"},
      {:timex, "~> 3.7", override: true},
      {:inflex, "~> 2.0.0"},
      {:query_builder, "~> 1.0"},
      {:tesla, "~> 1.4.3"},
      {:faker, git: "https://github.com/elixirs/faker"},
      {:hashids, "~> 2.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},
      {:wallaby, "~> 0.29.0", runtime: false, only: :test},
      {:heex_formatter, github: "feliperenan/heex_formatter"},
      {:oban, "~> 2.11"}
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
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": [
        "esbuild default --minify",
        "tailwind default --minify",
        "phx.digest"
      ]
    ]
  end
end
