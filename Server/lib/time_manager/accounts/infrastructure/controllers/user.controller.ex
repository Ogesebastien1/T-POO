defmodule TimeManagerWeb.Accounts.Infrastructure.UserController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts.Authorization

  alias TimeManager.Accounts.{
    UserModel,
    Application.ManageUserService,
    Infrastructure.UserPresenter
  }

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username}) do
    with {:ok, user} <- ManageUserService.get_user_by_email_and_username(email, username) do
      conn
      |> render_result(user)
    else
      _ ->
        conn
        |> render_error("404.json", :not_found)
    end
  end

  def index(conn, _params) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization = Bodyguard.permit(TimeManager.Accounts, :get_users, user_assigns)
    permission = Authorization.permission(:get_users, user_assigns)

    case {basic_authorization, permission} do
      {:ok, :full} ->
        users = ManageUserService.get_users()

        conn
        |> render_result(users)

      {:ok, :partial} ->
        users = ManageUserService.get_users()

        conn
        |> render_result(users)

      _ ->
        conn
        |> render_error("403.json", :forbidden)
    end
  end

  def show(conn, %{"id" => id}) do
    case ManageUserService.get_user_by_id(id) do
      {:ok, user} ->
        conn
        |> render_result(user)

      {:error, _reason} ->
        conn
        |> render_error("404.json", :not_found)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %UserModel{} = user} <- ManageUserService.create_user(user_params) do
      conn
      |> render_result(user, :created)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Accounts, :update_user, user_assigns, %{id: id})

    permissions = Authorization.permission(:update_user, user_assigns, user_params)

    IO.inspect({basic_authorization, permissions})

    with {:ok, :ok} <- {basic_authorization, permissions} do
      case ManageUserService.get_user_by_id(id) do
        {:ok, user} ->
          result = ManageUserService.update_user(user, user_params)

          with {:ok, updated_user} <- result do
            conn
            |> render_result(updated_user)
          else
            _ ->
              conn
              |> render_error("500.json", :internal_server_error)
          end

        {:error, _reason} ->
          conn
          |> render_error("404.json", :not_found)
      end
    else
      _ ->
        conn
        |> render_error("403.json", :forbidden)
    end
  end

  def update(conn, _params) do
    conn
    |> render_error("400.json", :bad_request)
  end

  def delete(conn, %{"id" => id}) do
    case ManageUserService.get_user_by_id(id) do
      {:ok, user} ->
        ManageUserService.delete_user(user)

        conn
        |> render_result(user, :no_content)

      {:error, _reason} ->
        conn
        |> render_error("404.json", :not_found)
    end
  end

  defp render_result(conn, result, status \\ :ok) do
    conn
    |> put_status(status)
    |> put_view(UserPresenter)
    |> pipe_render(result)
  end

  defp pipe_render(conn, result) do
    case is_list(result) do
      true -> render(conn, :present_users, users: result)
      false -> render(conn, :present_user, user: result)
    end
  end

  defp render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
