defmodule TimeManager.Test.TeamsFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.TimeTracking.Application.TeamService

  def when_manager_creates_team(conn, team) do
    post(conn, "/api/teams", %{team: team})
  end

  def then_team_was_created(conn, team) do
    response_body = json_response(conn, 201)

    assert response_body["name"] == team["name"]
    assert response_body["manager"]["id"] == team["manager_id"]
  end

  def when_manager_adds_user_to_team(conn, team_id, user_id) do
    post(conn, "/api/teams/#{team_id}/users", %{user_id: user_id})
  end

  def given_team_exists(team) do
    team
    |> TeamService.create_team()
  end

  def then_user_was_added_to_team(conn, user) do
    response_body = json_response(conn, 201)

    # IO.inspect(response_body)
  end
end
