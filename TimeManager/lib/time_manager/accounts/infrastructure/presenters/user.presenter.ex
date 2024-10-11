defmodule TimeManager.Accounts.Infrastructure.UserPresenter do
  alias TimeManager.Accounts.User
  alias TimeManager.Accounts.Application.Token

  def present_user(%{user: %User{} = user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end

  def present_users(%{users: users}) do
    %{data: for(user <- users, do: present_user(%{user: user}))}
  end

  def present_auth_user(%{user: %User{} = user}) do
    user =
      %{
        id: user.id,
        username: user.username,
        email: user.email
      }

    %{
      user: user,
      token: Token.sign(user)
    }
  end
end
