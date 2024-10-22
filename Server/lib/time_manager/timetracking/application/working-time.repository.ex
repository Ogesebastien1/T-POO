defmodule TimeManager.TimeTracking.Application.WorkingTimeRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback insert(working_time :: WorkingTimeModel.t()) ::
              {:ok, WorkingTimeModel.t()} | {:error, any()}

  def insert(working_time), do: adapter().insert(working_time)
end
