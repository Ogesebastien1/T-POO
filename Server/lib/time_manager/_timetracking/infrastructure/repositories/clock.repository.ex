defmodule TimeManager.TimeTracking.Infrastructure.ClockRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.Clock

  def get_by_user_id(user_id) do
    from(c in Clock, where: c.user_id == ^user_id)
    |> Repo.all()
  end

  def insert(clock) do
    clock
    |> Repo.insert()
  end
end
