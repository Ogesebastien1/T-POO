defmodule TimeManager.TimeTracking.Application.ClockRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback get_last_by_id(user_id :: integer()) :: {:ok, ClockModel.t()} | {:error, any()}
  @callback insert(clock :: ClockModel.t()) :: {:ok, ClockModel.t()} | {:error, any()}
  @callback get_all() :: {:ok, [ClockModel.t()]} | {:error, any()}
  @callback get_all_by_user(user_id :: integer()) :: {:ok, [ClockModel.t()]} | {:error, any()}

  def insert(clock), do: adapter().insert(clock)
  def get_last_by_id(user_id), do: adapter().get_last_by_id(user_id)
  def get_all(), do: adapter().get_all()
  def get_all_by_user(user_id), do: adapter().get_all_by_user(user_id)
end
