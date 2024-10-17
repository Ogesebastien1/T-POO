defmodule TimeManagerWeb.TimeTracking.Infrastructure.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeTracking.{Application.ClockService, Infrastructure.ClockPresenter}

  def clock(conn, %{"user_id" => user_id}) do
    case ClockService.clock_in_out(user_id) do
      {:error, _} ->
        ClockPresenter.render_error(conn, "500.json", :internal_server_error)

      clock ->
        ClockPresenter.render_result(conn, clock)
    end
  end
end
