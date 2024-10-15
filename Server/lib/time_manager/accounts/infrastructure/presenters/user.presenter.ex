defmodule TimeManager.Accounts.Infrastructure.UserPresenter do
  alias TimeManager.Accounts.UserModel
  alias TimeManager.Accounts.Application.Token

  def present_user(%{user: %UserModel{} = user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      manager: present_manager(user.manager)
    }
  end

  def present_users(%{users: users}) do
    %{data: for(user <- users, do: present_user(%{user: user}))}
  end

  def present_auth_user(%{user: %UserModel{} = user}) do
    user = present_user(%{user: user})

    %{
      user: user,
      token: Token.sign(user)
    }
  end

  defp present_manager(manager) do
    case manager do
      %UserModel{} ->
        %{
          id: manager.id,
          username: manager.username,
          email: manager.email
        }

      _ ->
        nil
    end
  end
end
