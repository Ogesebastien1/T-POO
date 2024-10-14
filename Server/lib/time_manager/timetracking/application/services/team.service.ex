defmodule TimeManager.TimeTracking.Application.TeamService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{TeamModel, Application.TeamRepository}

  def get_teams() do
    TeamRepository.get_all()
  end

  def get_team_by_id(id) do
    case TeamRepository.get_by_id(id) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def get_team_by_manager(manager) do
    case TeamRepository.get_by_manager(manager) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def get_team_by_user(user) do
    case TeamRepository.get_by_user(user) do
      nil -> {:error, "Team not found"}
      team -> {:ok, team}
    end
  end

  def create_team(params) do
    %TeamModel{}
    |> TeamModel.changeset(params)
    |> TeamRepository.insert()
  end

  def update_team(team, update_team) do
    team
    |> TeamModel.changeset(update_team)
    |> TeamRepository.update(update_team)
  end

  def delete_team(team) do
    team
    |> TeamRepository.delete()
  end
end
