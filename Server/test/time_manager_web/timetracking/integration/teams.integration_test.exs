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
    @describetag :this
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

      team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.then_user_was_added_to_team(team)
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

      team =
        conn
        |> Auth.put_auth_token(manager_token)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user1.id)
        |> TeamsFixture.when_manager_adds_user_to_team(team.id, user2.id)
        |> TeamsFixture.then_user_was_added_to_team(team)
    end
  end
end
