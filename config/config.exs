# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :formerrors,
  ecto_repos: [Formerrors.Repo]

# Configures the endpoint
config :formerrors, FormerrorsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yAfI8tvar0a3KTq4lcNIOrkmL4cl182He7VdtRg2eA3z+zMjVHLXGjhtCFerqDTd",
  render_errors: [view: FormerrorsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Formerrors.PubSub,
  live_view: [signing_salt: "IFHMDFea"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
