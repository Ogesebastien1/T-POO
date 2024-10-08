defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.{User, ManageUserService, Infrastructure.UserPresenter}

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = ManageUserService.get_users()
    IO.puts("users: #{inspect(users)}")
    conn
    |> put_view(json: UserPresenter)
    |> render(:present_users, users: users)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- ManageUserService.get_user_by_id(id) do
      conn
      |> put_view(json: UserPresenter)
      |> render(:present_users, user: user)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- ManageUserService.create_user(user_params) do
      conn
      |> put_view(json: UserPresenter)
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:present_user, user: user)
    end
  end
end
