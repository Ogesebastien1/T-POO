defmodule TimeManagerWeb.TimeTracking.Infrastructure.TeamsController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  alias TimeManager.TimeTracking.Infrastructure.TeamPresenter
  alias TimeManager.TimeTracking.Application.TeamService

  def get_teams(conn, _params) do
    _user_assigns = conn.assigns[:current_user]

    case TeamService.get_teams() do
      {:ok, teams} ->
        conn
        |> TeamPresenter.render_result(teams, :ok)

      {:error, _reason} ->
        conn
        |> TeamPresenter.render_error("500.json", :internal_server_error)
    end
  end

  def get_team(conn, %{"team_id" => team_id}) do
    _user_assigns = conn.assigns[:current_user]

    case TeamService.get_team_by_id(team_id) do
      {:ok, team} ->
        conn
        |> TeamPresenter.render_result(team, :ok)

      {:error, _reason} ->
        conn
        |> TeamPresenter.render_error("404.json", :not_found)
    end
  end

  def get_team(conn, _params) do
    conn
    |> TeamPresenter.render_error("400.json", :bad_request)
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
        case TeamService.add_user_to_team(team, user_id) do
          {:ok, team} ->
            conn
            |> TeamPresenter.render_result(team, :created)

          {:error, :already_in_team} ->
            conn
            |> TeamPresenter.render_error("409.json", :conflict)

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

  def delete_team(conn, %{"team_id" => team_id}) do
    _user_assigns = conn.assigns[:current_user]

    case TeamService.delete_team(team_id) do
      {:ok, _team} ->
        conn
        |> TeamPresenter.render_result(nil, :no_content)

      {:error, _reason} ->
        conn
        |> TeamPresenter.render_error("500.json", :internal_server_error)
    end
  end

  def delete_user_from_team(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    _user_assigns = conn.assigns[:current_user]

    case TeamService.delete_user_from_team(team_id, user_id) do
      {:ok, team} ->
        conn
        |> TeamPresenter.render_result(team)

      {:error, _reason} ->
        conn
        |> TeamPresenter.render_error("500.json", :internal_server_error)
    end
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
