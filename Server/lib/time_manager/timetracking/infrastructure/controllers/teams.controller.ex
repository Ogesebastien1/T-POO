defmodule TimeManagerWeb.TimeTracking.Infrastructure.TeamsController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  alias TimeManager.TimeTracking.Infrastructure.TeamPresenter
  alias TimeManager.TimeTracking.Application.TeamService

  def get_teams() do
  end

  def get_team() do
  end

  def create_team(conn, team_params) do
    user_assigns = conn.assigns[:current_user]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :create_team, user_assigns, team_params["team"])

    with :ok <- basic_authorization do
      case TeamService.create_team(team_params["team"]) do
        {:ok, team} ->
          conn
          |> TeamPresenter.render_result(team, :created)

        {:error, _reason} ->
          conn
          |> TeamPresenter.render_error("500.json", :internal_server_error)
      end
    else
      _ ->
        conn
        |> TeamPresenter.render_error("403.json", :forbidden)
    end
  end

  def add_user_to_team(conn, user_params) do
    user_assigns = conn.assigns[:current_user]
    team_id = conn.params["team_id"]
    user_id = user_params["user_id"]

    basic_authorization =
      Bodyguard.permit(TimeManager.Teams, :add_user_to_team, user_assigns, user_params["user"])

    with :ok <- basic_authorization do
      with {:ok, team} <- TeamService.get_team_by_id(team_id) do
        case TeamService.update_team(team, %{"user_id" => user_id}) do
          {:ok, team} ->
            IO.inspect(team)

            conn
            |> TeamPresenter.render_result(team, :created)

          {:error, _reason} ->
            conn
            |> TeamPresenter.render_error("500.json", :internal_server_error)
        end
      else
        _ ->
          conn
          |> TeamPresenter.render_error("404.json", :not_found)
      end
    end
  end

  def remove_user_from_team() do
  end

  def update_team() do
  end

  def delete_team() do
  end

  def get_team_users() do
  end

  def get_user_teams() do
  end

  # defp render_result(conn, result) do
  #   conn
  #   |> put_status(:ok)
  #   |> put_view
  #   |> render()
  # end
end
