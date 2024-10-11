defmodule TimeManagerWeb.Guard.AuthGuard do
  import Plug.Conn
  alias TimeManager.Accounts.Application.{Token, ManageUserService}

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      {:ok, user} = ManageUserService.get_user_by_id(data.id)

      conn |> assign(:current_user, user)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(MyAppWeb.ErrorView)
        |> Phoenix.Controller.render(:"401")
        |> halt()
    end
  end
end
