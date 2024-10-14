defmodule TimeManager.TimeTracking.Infrastructure.TeamRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.TeamModel

  alias TimeManager.TimeTracking.Application.TeamRepository

  @behaviour TeamRepository

  import UUIDValidator

  def get_all() do
    TeamModel
    |> Repo.all()
  end

  def get_by_id(id) do
    TeamModel
    |> Repo.get(id)
  end

  def insert(team) do
    team
    |> Repo.insert()
  end

  def get_by_manager(manager_id) do
    TeamModel
    |> Repo.get_by(UserModel, manager_id: manager_id)
  end

  def get_by_user(user_id) do
    TeamModel
    |> Repo.get_by(UserModel, user_id: user_id)
  end

  def update(team, params) do
    team
    |> TeamModel.changeset(params)
    |> Repo.update()
  end

  def delete(team) do
    Repo.delete(team)
  end
end
