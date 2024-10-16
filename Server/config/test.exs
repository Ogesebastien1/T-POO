import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :time_manager, TimeManager.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "db_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :time_manager, TimeManagerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "77M1vFPt3Xzwtt8TJsYsoaorsPT7/WzMfwBRLx2clw5qCcdkDENR6f3hVCe+sbSC",
  server: false

# In test we don't send emails
config :time_manager, TimeManager.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
# Dependency Injection for tests :

config :time_manager,
       TimeManager.Accounts.Application.UserRepository,
       TimeManager.Accounts.Infrastructure.UserRepository

config :time_manager,
       TimeManager.TimeTracking.Application.TeamRepository,
       TimeManager.TimeTracking.Infrastructure.TeamRepository
