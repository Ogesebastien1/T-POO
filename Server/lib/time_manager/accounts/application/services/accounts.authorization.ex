defmodule TimeManager.Accounts.Authorization do
  @behaviour Bodyguard.Policy
  # def authorize(_, %Accounts.UserModel{id: user_id}, _), do: :ok
  def authorize(:update_user, %{id: user_id} = _id_from_token, %{id: user_id} = _id_from_param),
    do: :ok

  def authorize(_, _, _), do: false
end

defmodule TimeManager.Accounts do
  defdelegate authorize(action, user, params), to: TimeManager.Accounts.Authorization
end
