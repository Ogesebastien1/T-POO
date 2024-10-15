defmodule TimeManager.Test.AccountsFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Accounts.Application.ManageUserService
  alias TimeManager.Accounts.Application.AuthService
  alias TimeManager.Accounts.Infrastructure.UserPresenter

  def get_users(conn) do
    get(conn, "/api/users")
  end

  def update_user(conn, user, user_id) do
    put(conn, ~p"/api/users/#{user_id}", %{user: user})
  end

  def then_user_is_updated(conn, user) do
    response_user = Poison.decode!(conn.resp_body)

    assert conn.status == 200
    assert response_user["email"] == user["email"]
    assert response_user["username"] == user["username"]
  end

  def request_is_forbidden(conn) do
    assert conn.status == 403
  end

  def then_registered_users_are(conn, users) do
    response_users = Poison.decode!(conn.resp_body)
    response_users = Map.get(response_users, "data")

    assert conn.status == 200

    assert Enum.count(response_users) == Enum.count(users)

    assert Enum.all?(users, fn user ->
             Enum.any?(response_users, fn response_user ->
               response_user["email"] == user.email &&
                 response_user["username"] == user.username &&
                 response_user["id"] == user.id
             end)
           end)
  end
end
