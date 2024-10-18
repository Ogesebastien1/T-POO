defmodule TimeManagerWeb.TeamsTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth}
  import TimeManagerWeb.Test.UserBuilder
  alias TimeManager.Test.TeamsFixture

  @moduletag :integration
  @moduletag :teams

  setup do
    manager1 = user(1, :manager)

    user1 = user(1)
    user2 = user(2)
    user3 = user(3)
    user4 = user(4)
    user5 = user(5)
    user6 = user(6)

    registred_users =
      Registration.given_existing_users([manager1, user1, user2, user3, user4, user5, user6])

    manager_id = List.last(registred_users).id

    manager_auth_response = Auth.login_pass(manager1["email"], manager1["password"])

    manager_token = Auth.extract_auth_token(manager_auth_response)

    [manager_id: manager_id, manager_token: manager_token, users: registred_users]
  end

  describe "As a Manager, " do
    test "I can create a blank team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      team_params = %{
        "name" => "Team 1",
        "manager_id" => manager_id
      }

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_manager_creates_team(team_params)
      |> TeamsFixture.then_team_was_created(team_params)
    end

    test "I can add a user to my team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = List.first(users)

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.then_user_was_added_to_team(team, [user1])
    end

    test "I can add multiple users to my team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)
        |> TeamsFixture.then_user_was_added_to_team(team, [user1, user2])
    end

    test "I can't add a user to a team multiple times", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.then_conflict_response()
    end

    test "I can get a team by id", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      _team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_user_gets_team(team.id)
        |> TeamsFixture.then_team_was_returned(team)
    end

    test "I can get all teams -- REMOVE THIS TEST", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      {:ok, team1} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      {:ok, team2} =
        %{
          "name" => "Team 2",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_gets_teams()
      |> TeamsFixture.then_teams_were_returned([team1, team2])
    end

    test "I can't get a team that doesn't exist", %{
      conn: conn,
      manager_token: manager_token
    } do
      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_gets_team(999)
      |> TeamsFixture.then_not_found_response()
    end

    test "I can delete a team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      conn
      |> Auth.put_auth_token(manager_token)
      |> TeamsFixture.when_user_delete_team(team.id)
      |> TeamsFixture.then_team_was_deleted()
    end

    test "I can remove a user from team", %{
      conn: conn,
      manager_id: manager_id,
      manager_token: manager_token,
      users: users
    } do
      {:ok, team} =
        %{
          "name" => "Team 1",
          "manager_id" => manager_id
        }
        |> TeamsFixture.given_team_exists()

      user1 = hd(tl(users))
      user2 = hd(users)

      conn =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)

      team = conn.assigns.team

      conn
      |> TeamsFixture.when_manager_removes_user_from_team(team.id, user1.id)
      |> TeamsFixture.then_user_was_removed_from_team(team, user1)
    end
  end
end
