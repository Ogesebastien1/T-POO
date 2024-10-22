defmodule TimeManager.TimeTracking.Application.WorkingTimeService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{Application.WorkingTimeRepository, WorkingTimeModel}

  def create_wt(params) do
    %WorkingTimeModel{}
    |> WorkingTimeModel.changeset(params)
    |> WorkingTimeRepository.insert()
  end
end
