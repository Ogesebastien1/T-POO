defmodule TimeManagerWeb.TimeTracking.Infrastructure.WorkingTimeController do
  use TimeManagerWeb, :controller
  alias TimeManager.TimeTracking.{WorkingTime , Application.ManageWorkingTimeService}
  alias TimeManager.TimeTracking.Infrastructure.{WorkingTimePresenter}

  action_fallback TimeManagerWeb.FallbackController

  # def index(conn, %{"userID" => userID, "id" => id}) do


  # end

  # def index(conn, %{"userID" => userID, "start" => start, "end" => :end}) do

  # end

  # def index(conn, _params) do
  #   conn
  #   |> put_status(:bad_request)
  #   |> put_view(TimeManagerWeb.ErrorView)
  #   |> render("400.json", message: "Invalid parameters")
  # end

  # def create(conn, %{"userID" => userID, "working_time" => working_time_params}) do
  #   with {:ok, %WorkingTime{} = working_time} <- ManageWorkingTimeService
  # end

  def create(conn , %{"userID" => userID, "working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- ManageWorkingTimeService.create_working_time(%{"userID" => userID, "working_time" => working_time_params}) do
      conn
      |> put_status(:created)
      |> put_view(WorkingTimePresenter)
      |> render(:present_working_time, working_time: working_time)
    end
  end




end
