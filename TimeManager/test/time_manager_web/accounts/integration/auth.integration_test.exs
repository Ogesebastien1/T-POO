defmodule TimeManagerWeb.AuthControllerTest do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Accounts.{Infrastructure.UserRepository, Application.ManageUserService}
  alias TimeManagerWeb.Test.UserBuilder

  describe "As a registered user, being unauthentificated " do
    test "I can login with my email and password", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      given_existing_users([user])

      conn = login_pass(conn, %{email: user["email"], password: user["password"]})

      assert_is_the_same_user(conn, user)
    end

    test "I receive a token when i log in", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      given_existing_users([user])

      conn = login_pass(conn, %{email: user["email"], password: user["password"]})
      conn |> assert_i_receive_a_token()
    end

    test "I can't login with an invalid email", %{conn: conn} do
      user = UserBuilder.user() |> UserBuilder.with_password("MAIS LOL")
      given_existing_users([user])

      conn
      |> login_pass(%{email: "aa", password: user["password"]})
      |> assert_error(%{"status" => 404, "detail" => "Resource not found"})
    end

    test "I can't login with an wrong password", %{conn: conn} do
      user = UserBuilder.user()
      given_existing_users([user])

      conn
      |> login_pass(%{email: user["email"], password: "wrong_password"})
      |> assert_error(%{"status" => 401, "detail" => "Unauthorized"})
    end
  end

  describe "As an authenticated user" do
    test "I can login with my token", %{conn: conn} do
      response_token = given_authenticated_user(conn, UserBuilder.user())

      conn
      |> login_token(response_token)
      |> assert_is_the_same_user(UserBuilder.user())
    end
  end

  defp login_pass(conn, %{email: email, password: password}) do
    post(conn, ~p"/api/auth/", %{email: email, password: password})
  end

  defp login_token(conn, token) do
    conn
    |> put_req_header("authorization", "Bearer " <> token)
    |> get(~p"/api/auth/me")
  end

  defp given_existing_users(data) do
    for user <- data do
      ManageUserService.create_user(user)
    end
  end

  defp given_authenticated_user(conn, user) do
    given_existing_users([user])

    conn = login_pass(conn, %{email: user["email"], password: user["password"]})
    response_token = json_response(conn, 200)["token"]
  end

  defp assert_is_the_same_user(conn, user) do
    assert conn.status == 200
    response_user = json_response(conn, 200)["user"]
    response_token = json_response(conn, 200)["token"]

    assert response_user["email"] == user["email"]
    assert response_user["username"] == user["username"]
  end

  defp assert_i_receive_a_token(conn) do
    assert conn.status == 200
    response_token = json_response(conn, 200)["token"]
    assert response_token != nil
  end

  defp assert_error(conn, error) do
    assert conn.status == error["status"]
    response_body_error = Jason.decode!(conn.resp_body)["errors"]
    assert response_body_error["detail"] == error["detail"]
  end
end
