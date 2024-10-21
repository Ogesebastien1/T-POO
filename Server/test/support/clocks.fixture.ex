defmodule TimeManager.Test.ClocksFixture do
  use TimeManagerWeb.ConnCase

  def when_user_clock_in(conn, user_id) do
    conn
    |> post("/api/clocks", %{"user_id" => user_id})
  end

  def then_clock_is_created(conn, _user) do
    _repsonse_body = Poison.decode!(conn.resp_body)

    assert conn.status == 200
  end

  def reset_fake_time() do
    Application.put_env(:time_manager, :fake_date_provider, 0)
  end

  def after_x_seconds(seconds) do
    time_to_put = Application.get_env(:time_manager, :fake_date_provider) + seconds
    Application.put_env(:time_manager, :fake_date_provider, time_to_put)
  end

  def when_user_get_all_clocks(conn) do
    get(conn, "/api/clocks")
  end

  def then_clocks_are_shown(conn) do
    response_body = Poison.decode!(conn.resp_body)
    # IO.inspect(response_body)

    assert conn.status == 200
  end

  def when_user_get_all_clocks_by_user(conn, user_id) do
    get(conn, "/api/clocks/#{user_id}")
  end

end
