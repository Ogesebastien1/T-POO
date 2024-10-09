defmodule TimeManagerWeb.TimeTracking.Infrastructure.ClockController do
  use TimeManagerWeb, :controller
  alias TimeManager.TimeTracking.{Clock, Application.ManageClockService}
  alias TimeManager.TimeTracking.Infrastructure.{ClockPresenter}

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"userID" => userID}) do
    with {:ok, clocks} <-
           ManageClockService.get_clocks(%{"userID" => userID}) do
      conn
      |> put_status(:ok)
      |> put_view(ClockPresenter)
      |> render(:present_clocks, clocks: clocks)
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
end
