defmodule TimeManagerWeb.TimeTracking.Infrastructure.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeTracking.{Application.ClockService, Infrastructure.ClockPresenter}

  def clock(conn, %{"user_id" => user_id}) do
    _user_assigns = conn.assigns[:current_user]

    case ClockService.clock_in_out(user_id) do
      {:error, _} ->
        ClockPresenter.render_error(conn, "500.json", :internal_server_error)

      clock ->
        ClockPresenter.render_result(conn, clock)
    end
  end

  def get_clocks(conn, _assigns) do
    case ClockService.get_clocks() do
      {:error, _} ->
        ClockPresenter.render_error(conn, "500.json", :internal_server_error)

      clocks ->
        ClockPresenter.render_result(conn, clocks)
    end
  end

  def get_clocks_by_user(conn, %{"user_id" => user_id}) do
    _user_assigns = conn.assigns[:current_user]

    case ClockService.get_clocks_by_user(user_id) do
      {:error, _} ->
        ClockPresenter.render_error(conn, "500.json", :internal_server_error)

      clocks ->
        ClockPresenter.render_result(conn, clocks)
    end
  end
end
