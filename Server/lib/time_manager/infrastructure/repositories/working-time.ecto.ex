defmodule TimeManager.TimeTracking.Infrastructure.WorkingTimeRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.Application.WorkingTimeRepository

  @behaviour WorkingTimeRepository

  @impl true
  def insert(working_time) do
    working_time
    |> Repo.insert()
  end
end
