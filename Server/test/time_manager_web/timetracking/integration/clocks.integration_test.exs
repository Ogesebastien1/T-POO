defmodule TimeManagerWeb.ClockTest do
  @one_hour 3600

  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth}
  import TimeManagerWeb.Test.UserBuilder
  import TimeManager.Test.ClocksFixture

  @moduletag :integration
  @moduletag :clocks

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

    reset_fake_time()
    [manager_id: manager_id, manager_token: manager_token, users: registred_users]
  end

  describe "As a User, " do
    @describetag :this

    test "I can clock in", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)
    end

    test "I can clock out", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)

      after_x_seconds(@one_hour * 8)

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_clock_in(user6.id)
      |> then_clock_is_created(user6)
    end
  end
end
