defmodule TimeManager.Accounts.Application.UserRepository do
  @self __MODULE__

  defp adapter() do
    Application.get_env(:time_manager, @self)
  end

  @callback insert(user :: UserModel.t()) :: :ok | :error

  def insert(user), do: adapter().insert(user)
end
