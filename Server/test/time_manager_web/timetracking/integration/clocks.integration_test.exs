defmodule TimeManagerWeb.ClockTest do
  @one_hour 3600

  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth}
  import TimeManagerWeb.Test.UserBuilder
  import TimeManager.Test.ClocksFixture
  alias TimeManager.TimeTracking.Application.ClockService

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

    test "I can all my clocks", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)

      user_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user_token)

      for _ <- 1..5 do
        conn
        |> when_user_clock_in(user6.id)
        |> then_clock_is_created(user6)

        after_x_seconds(@one_hour * 8 + round(@one_hour / 3))
      end

      conn
      |> Auth.put_auth_token(user_token)
      |> when_user_get_all_clocks()
      |> then_clocks_are_shown()
    end

    test "I can see clocks of a user", %{
      conn: conn,
      users: users
    } do
      user6 = hd(users)
      user5 = hd(tl(users))

      user6_token =
        Auth.login_pass(user(6)["email"], user(6)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user6_token)

      for _ <- 1..2 do
        conn
        |> when_user_clock_in(user6.id)
        |> then_clock_is_created(user6)

        after_x_seconds(@one_hour)
      end

      user5_token =
        Auth.login_pass(user(5)["email"], user(5)["password"])
        |> Auth.extract_auth_token()

      conn = conn |> Auth.put_auth_token(user5_token)

      for _ <- 1..10 do
        conn
        |> when_user_clock_in(user5.id)
        |> then_clock_is_created(user5)

        after_x_seconds(@one_hour)
      end

      conn
      |> Auth.put_auth_token(user6_token)
      |> when_user_get_all_clocks_by_user(user6.id)
      |> then_clocks_are_shown()
    end
  end

  test "calculate clock stats", %{
    users: users
  } do
    user6 = hd(users)
    clocks = ClockService.get_clocks_by_user(user6.id)

    for _ <- 1..10 do
      ClockService.clock_in_out(user6.id)
      after_x_seconds(@one_hour * 2)
      ClockService.clock_in_out(user6.id)
      after_x_seconds(@one_hour)
    end

    clocks = ClockService.get_clocks_by_user(user6.id)
    clock_stats = ClockService.calculate_clock_stats(clocks)
    IO.inspect(clock_stats)
  end

  @tag :this
  test "this week", %{
    users: users
  } do
    user6 = hd(users)

    for j <- 0..4 do
      reset_fake_time()
      after_x_seconds(-(@one_hour * 24 * 7))
      after_x_seconds(@one_hour * (24 * j))
      ClockService.clock_in_out(user6.id)
      after_x_seconds(@one_hour * 1)
      ClockService.clock_in_out(user6.id)
    end

    reset_fake_time()

    for i <- 1..5 do
      ClockService.clock_in_out(user6.id)
      after_x_seconds(@one_hour * 2)
      ClockService.clock_in_out(user6.id)
      reset_fake_time()
      after_x_seconds(@one_hour * (24 * i))
    end

    ClockService.get_weekly_hour_stat_by_user(user6.id)
    |> IO.inspect()
  end
end
