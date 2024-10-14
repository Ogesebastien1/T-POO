defmodule TimeManager.Test.TeamsFixture do
  def when_manager_creates_team(conn, team) do
    post(conn, "/api/teams", %{team: team})
  end
end
