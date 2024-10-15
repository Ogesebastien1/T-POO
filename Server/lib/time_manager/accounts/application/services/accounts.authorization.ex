defmodule TimeManager.Accounts.Authorization do
  @behaviour Bodyguard.Policy
  # def authorize(_, %Accounts.UserModel{id: user_id}, _), do: :ok
  def authorize(:update_user, %{id: user_id} = _id_from_token, %{id: user_id} = _id_from_param),
    do: :ok

  def authorize(:update_user, %{role: :admin}, _), do: :ok

  def authorize(:update_user, %{role: :manager}, %{role: :user}), do: :ok

  def authorize(:get_users, %{role: :admin}, _), do: :ok
  def authorize(:get_users, %{role: :manager}, _), do: :ok

  def permission(:get_users, %{role: :admin}), do: :full
  def permission(:get_users, %{role: :manager}), do: :partial
  def permission(:get_users, %{role: :user}), do: :none

  def permission(_, _), do: :none
  def authorize(_, _, _), do: false
end

defmodule TimeManager.Accounts do
  defdelegate authorize(action, user, params), to: TimeManager.Accounts.Authorization
end
