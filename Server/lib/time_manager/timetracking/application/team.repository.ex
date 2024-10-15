defmodule TimeManager.TimeTracking.Application.TeamRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback get_all() :: [TeamModel.t()] | {:error, any()}
  @callback get_by_id(id :: String.t()) :: TeamModel.t() | nil
  @callback insert(team :: TeamModel.t()) :: {:ok, TeamModel.t()} | {:error, any()}
  @callback get_by_manager(manager :: String.t()) :: TeamModel.t() | nil
  @callback get_by_user(user :: String.t()) :: TeamModel.t() | nil
  @callback update(team :: TeamModel.t(), params :: map()) ::
              {:ok, TeamModel.t()} | {:error, any()}
  @callback delete(team :: TeamModel.t()) :: {:ok, TeamModel.t()} | {:error, any()}

  def insert(team), do: adapter().insert(team)
  def get_all(), do: adapter().get_all()
  def get_by_id(id), do: adapter().get_by_id(id)
  def get_by_manager(manager), do: adapter().get_by_manager(manager)
  def get_by_user(user), do: adapter().get_by_user(user)
  def update(team, params), do: adapter().update(team, params)
  def delete(team), do: adapter().delete(team)
end
