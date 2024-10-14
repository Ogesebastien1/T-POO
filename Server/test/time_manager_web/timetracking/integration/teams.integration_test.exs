defmodule TimeManagerWeb.TeamsTest do
  use TimeManagerWeb.ConnCase, async: true
  alias TimeManager.Test.SetupFixture.{Registration, Auth, Authorization}
  import TimeManagerWeb.Test.UserBuilder

  @moduletag :integration
  @moduletag :teams

  setup do
    :ok
  end

  describe "As a Manager, " do
    test "I can create a team", %{conn: conn} do
    end
  end
end
