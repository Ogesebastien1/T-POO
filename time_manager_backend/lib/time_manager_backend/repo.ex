defmodule TimeManagerBackend.Repo do
  use Ecto.Repo,
    otp_app: :time_manager_backend,
    adapter: Ecto.Adapters.Postgres
end
