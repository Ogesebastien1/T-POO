defmodule TimeManager.TimeTracking.Infrastructure.TeamPresenter do
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.TeamModel
  alias TimeManager.Accounts.Infrastructure.UserPresenter
  alias TimeManager.Accounts.UserModel

  def present_team(%{team: %TeamModel{} = team}) do
    %{
      id: team.id,
      name: team.name,
      manager_id: team.manager_id
    }
  end

  def present_teams(%{teams: teams}) do
    %{data: for(team <- teams, do: present_team(%{team: team}))}
  end

  def present_team_with_manager(%{team: %TeamModel{} = team}) do
    %{
      id: team.id,
      name: team.name,
      manager: UserPresenter.present_user(%{user: team.manager})
    }
  end

  def render_result(conn, result, status \\ :ok) do
    conn
    |> put_status(status)
    |> put_view(TimeManager.TimeTracking.Infrastructure.TeamPresenter)
    |> render(:present_team_with_manager, team: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
