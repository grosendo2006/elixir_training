# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phinx,
  ecto_repos: [Phinx.Repo]

# Configures the endpoint
config :phinx, PhinxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G9uJa9DUS32kPmxySahoUOGNvJ6SL85MFl6PtQEu2ya/jwXNCv2+YgeRU2bG+421",
  render_errors: [view: PhinxWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Phinx.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "JKSyJ/G8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
