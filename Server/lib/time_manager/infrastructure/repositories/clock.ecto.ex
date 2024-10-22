defmodule TimeManager.TimeTracking.Infrastructure.ClockRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.{Application.ClockRepository, ClockModel}

  @behaviour ClockRepository

  @impl ClockRepository
  def get_last_by_id(user_id) do
    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id,
          order_by: [desc: c.time],
          limit: 1

      query
      |> Repo.one()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end

  @impl ClockRepository
  def insert(clock) do
    Repo.insert!(clock)
  end

  @impl ClockRepository
  def get_all() do
    Repo.all(ClockModel)
  end

  @impl ClockRepository
  def get_all_by_user(user_id) do
    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id,
          order_by: [asc: c.time]
      query
      |> Repo.all()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end
end
