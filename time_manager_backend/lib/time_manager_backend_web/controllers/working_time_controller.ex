defmodule TimeManagerBackendWeb.WorkingTimeController do
  use TimeManagerBackendWeb, :controller

  alias TimeManagerBackend.Timetracking
  alias TimeManagerBackend.Timetracking.WorkingTime

  action_fallback TimeManagerBackendWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Timetracking.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- Timetracking.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{working_time}")
      |> render(:show, working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = Timetracking.get_working_time!(id)
    render(conn, :show, working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Timetracking.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- Timetracking.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Timetracking.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Timetracking.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
