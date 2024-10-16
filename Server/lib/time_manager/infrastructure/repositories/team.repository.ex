defmodule TimeManager.TimeTracking.Infrastructure.TeamRepository do
  use TimeManager, :repository

  alias TimeManager.TimeTracking.TeamModel
  alias TimeManager.Accounts.UserModel

  alias TimeManager.TimeTracking.Application.TeamRepository

  alias Ecto.Changeset

  @behaviour TeamRepository

  @impl true
  def get_all() do
    TeamModel
    |> Repo.all()
  end

  @impl true
  def get_by_id(id) do
    TeamModel
    |> Repo.get(id)
  end

  @impl true
  def insert(team) do
    with {:ok, team} <- Repo.insert(team) do
      {:ok, Repo.preload(team, :manager)}
    end
  end

  @impl true
  def get_by_manager(manager_id) do
    TeamModel
    |> Repo.get_by(UserModel, manager_id: manager_id)
  end

  @impl true
  def get_by_user(user_id) do
    TeamModel
    |> Repo.get_by(UserModel, user_id: user_id)
  end

  @impl true
  def update(team, params) do
    team
    |> TeamModel.changeset(params)
    |> Repo.update()
  end

  @impl true
  def delete(team) do
    Repo.delete(team)
  end

  @impl true
  def add_user(team, user_id) do
    IO.inspect("Le repository :")

    team =
      TeamModel
      |> Repo.get(team.id)
      |> Repo.preload(:users)
      |> Repo.preload(:manager)

    user =
      UserModel
      |> Repo.get!(user_id)

    team
    |> Changeset.change()
    |> Changeset.put_assoc(:users, [user | team.users])
    |> Repo.update()
  end
end
