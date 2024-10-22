defmodule TimeManagerWeb.TimeTracking.Infrastructure.WorkingTimeController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  alias TimeManager.TimeTracking.{
    Infrastructure.WorkingTimePresenter,
    Application.WorkingTimeService
  }

  def create_working_time(conn, %{"working_time" => working_time_params}) do
    current_user = conn.assigns[:current_user]

    working_time_params = Map.put(working_time_params, "manager_id", current_user.id)

    case WorkingTimeService.create_wt(working_time_params) do
      {:ok, working_time} ->
        WorkingTimePresenter.render_result(conn, working_time, :created)

      {:error, _} ->
        WorkingTimePresenter.render_error(conn, "500.json", :internal_server_error)
    end
  end
end
