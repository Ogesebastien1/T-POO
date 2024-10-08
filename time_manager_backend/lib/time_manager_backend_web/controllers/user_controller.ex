defmodule TimeManagerBackendWeb.UserController do
  use TimeManagerBackendWeb, :controller
  use PhoenixSwagger

  import Plug.Conn.Status, only: [code: 1]

  swagger_path :index do
    get("/users")
    description("List of users")
    response(code(:ok), "Success", Schema.ref(:User))
  end

  def swagger_definitions do
    %{
      User: swagger_schema do
        title("User")
        description("A user of the application")

        properties do
          id(:integer, "User ID", required: true)
          name(:string, "User name", required: true)
          email(:string, "User email", required: true)
        end
      end
    }
  end

  alias TimeManagerBackend.Accounts
  alias TimeManagerBackend.Accounts.User

  action_fallback TimeManagerBackendWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
