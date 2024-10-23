defmodule TimeManager.TimeTracking.Application.WorkingTimeService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{Application.WorkingTimeRepository, WorkingTimeModel}

  def create_wt(params) do
    %WorkingTimeModel{}
    |> WorkingTimeModel.changeset(params)
    |> WorkingTimeRepository.insert()
  end

  def get_wts() do
    case WorkingTimeRepository.get_all() do
      working_times -> {:ok, working_times}
    end
  end

  def get_wts_by_user(user_id) do
    case WorkingTimeRepository.get_by_user(user_id) do
      working_times -> {:ok, working_times}
    end
  end

  def get_wts_by_user(user_id, start, end_time) do
    case WorkingTimeRepository.get_by_user(user_id, start, end_time) do
      working_times -> {:ok, working_times}
    end
  end

  def update_by_user(user_id, working_time) do
    case WorkingTimeRepository.update_by_id(user_id, working_time) do
      {:ok, working_time} -> {:ok, working_time}
      {:error, _} -> {:error, "Error updating working time"}
    end
  end
end
