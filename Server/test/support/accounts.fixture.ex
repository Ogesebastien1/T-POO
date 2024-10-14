defmodule TimeManager.Test.AccountsFixture do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Accounts.Application.ManageUserService
  alias TimeManager.Accounts.Application.AuthService
  alias TimeManager.Accounts.Infrastructure.UserPresenter

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
end
