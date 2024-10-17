defmodule TimeManager.Test.ClocksFixture do
  use TimeManagerWeb.ConnCase

  def when_user_clock_in(conn, user_id) do
    conn
    |> post("/api/clocks", %{"user_id" => user_id})
  end

  def then_clock_is_created(conn, user) do
    repsonse_body = Poison.decode!(conn.resp_body)

    assert conn.status == 200

    IO.inspect(repsonse_body)
  end

  def reset_fake_time() do
    Application.put_env(:time_manager, :fake_date_provider, 0)
  end

  def after_x_seconds(seconds) do
    Application.put_env(:time_manager, :fake_date_provider, seconds)
  end
end
