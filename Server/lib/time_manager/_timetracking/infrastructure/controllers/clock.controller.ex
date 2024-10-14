defmodule TimeManagerWeb.TimeTracking.Infrastructure.ClockController do
  use TimeManagerWeb, :controller
  alias TimeManager.TimeTracking.{Clock, Application.ManageClockService}
  alias TimeManager.TimeTracking.Infrastructure.{ClockPresenter}

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"userID" => userID}) do
    with {:ok, clocks} <-
           ManageClockService.get_clocks(%{"userID" => userID}) do
      conn
      |> render_result(clocks)
    end
  end

  def create(conn, %{"userID" => userID, "clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <-
           ManageClockService.create_clock(%{
             "userID" => userID,
             "clock" => clock_params
           }) do
      conn
      |> put_status(:created)
      |> put_view(ClockPresenter)
      |> render(:present_clock, clock: clock)
    end
  end

  defp render_result(conn, results, status \\ :ok) do
    conn
    |> put_status(status)
    |> put_view(ClockPresenter)
    |> pipe_render(results)
  end

  defp pipe_render(conn, results) do
    case is_list(results) do
      true -> render(conn, :present_clocks, clocks: results)
      false -> render(conn, :present_clock, clock: results)
    end
  end
end
