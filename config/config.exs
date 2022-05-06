# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# SETUP_TODO - ensure these details are correct
# Option descriptions:
# app_name: This appears in your email layout and also your meta title tag
# business_name: This appears in your landing page footer next to the copyright symbol
# support_email: In your transactional emails there is a "Contact us" email - this is what will appear there
# mailer_default_from_name: The "from" name for your transactional emails
# mailer_default_from_email: The "from" email for your transactional emails
# dark_logo_for_emails: Your logo must reference a URL for email client (not a relative path)
# light_logo_for_emails: Same as above
# seo_description: Will go in your meta description tag
# css_theme_default: Can be "light" or "dark" - if "dark" it will add the class "dark" to the <html> element by default
config :clubl_a,
  app_name: "CLUBL Avail",
  business_name: "CLUB-LEDGER Services Pty Ltd",
  support_email: "info@clubledger.com",
  mailer_default_from_name: "Support",
  mailer_default_from_email: "mark@clubledger.com",
  logo_url_for_emails: "https://res.cloudinary.com/wickedsites/image/upload/v1643336799/petal/petal_logo_light_w5jvlg.png",
  seo_description: "SaaS boilerplate template powered by Elixir's Phoenix and TailwindCSS",
  css_theme_default: "light"

config :clubl_a,
  ecto_repos: [ClubLA.Repo]

# Configures the endpoint
config :clubl_a, ClubLAWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ClubLAWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ClubLA.PubSub,
  live_view: [signing_salt: "Fd8SWPu3"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :clubl_a, ClubLA.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :petal_components, :error_translator_function, {ClubLAWeb.ErrorHelpers, :translate_error}

config :tailwind,
  version: "3.0.12",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]


# Oban:
# Queues are specified as a keyword list where the key is the name of the queue and the value is the maximum number of concurrent jobs.
# The following configuration would start four queues with concurrency ranging from 5 to 50: [default: 10, mailers: 20, events: 50, media: 5]
# For now we just have one default queue with up to 5 concurrent jobs (as our database only accepts up to 10 connections so we don't want to overload it)
# Oban provides active pruning of completed, cancelled and discarded jobs - we retain jobs for 24 hours
config :clubl_a, Oban,
  repo: ClubLA.Repo,
  queues: [default: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
        {"@daily", ClubLA.Workers.ExampleWorker}
        # {"* * * * *", ClubLA.EveryMinuteWorker},
        # {"0 * * * *", ClubLA.EveryHourWorker},
        # {"0 */6 * * *", ClubLA.EverySixHoursWorker},
        # {"0 0 * * SUN", ClubLA.EverySundayWorker},
        # More examples: https://crontab.guru/examples.html
      ]}
  ]

# Specify which languages you support
# To create .po files for a language run `mix gettext.merge priv/gettext --locale fr`
# (fr is France, change to whatever language you want - make sure it's included in the locales config below)
config :clubl_a, ClubLAWeb.Gettext, allowed_locales: ~w(en fr)
config :clubl_a, :language_options, [
  %{locale: "en", flag: "🇬🇧", label: "English"},
  %{locale: "fr", flag: "🇫🇷", label: "French"},
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
