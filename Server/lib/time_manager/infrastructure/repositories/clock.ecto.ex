defmodule TimeManager.TimeTracking.Infrastructure.ClockRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.{Application.ClockRepository, ClockModel}

  @behaviour ClockRepository

  def get_last_by_id(user_id) do
    with user_id <- user_id do
      query =
        from c in ClockModel,
          where: c.user_id == ^user_id,
          order_by: [desc: c.inserted_at],
          limit: 1

      query
      |> Repo.one()
    else
      {:error, _} -> {:error, "is not a valid UUID"}
    end
  end

  def insert(clock) do
    Repo.insert!(clock)
  end
end
