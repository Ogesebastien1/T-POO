defmodule TimeManagerWeb.WorkingTimeTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth}
  import TimeManagerWeb.Test.UserBuilder
  # alias TimeManager.Test.WorkingTimesFixture

  alias TimeManager.TimeTracking.Application.WorkingTimeService

  @moduletag :integration
  @moduletag :working_time

  setup do
    :ok

    bunch_of_users = Enum.map(1..10, fn i -> user(i) end)

    registred_users =
      Registration.given_existing_users(bunch_of_users)

    [users: registred_users]
  end

  describe "unit WorkingTimeService" do
    test "creating working time", %{
      users: users
    } do
      working_time = %{
        "user_id" => List.first(users).id,
        "manager_id" => List.last(users).id,
        "start_time" => ~U[2021-01-01 08:00:00Z],
        "end_time" => ~U[2021-01-01 16:00:00Z],
        "break_duration" => 30
      }

      {:ok, working_time} = WorkingTimeService.create_wt(working_time)

      IO.inspect(working_time)
    end
  end
end
