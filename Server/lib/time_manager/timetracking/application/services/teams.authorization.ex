defmodule TimeManager.TimeTracking.Teams.Authorization do
  @behaviour Bodyguard.Policy
  # def authorize(_, %Accounts.UserModel{id: user_id}, _), do: :ok

  def authorize(
        :create_team,
        %{role: :manager, id: manager_id} = _user,
        %{"manager_id" => manager_id} = _team
      ),
      do: :ok

  def authorize(:add_user_to_team, _, _), do: :ok

  def authorize(_, _, _), do: false
end

defmodule TimeManager.Teams do
  defdelegate authorize(action, user, params), to: TimeManager.TimeTracking.Teams.Authorization
end
