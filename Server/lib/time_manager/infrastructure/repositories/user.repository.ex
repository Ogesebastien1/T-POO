defmodule TimeManager.Accounts.Infrastructure.UserRepository do
  use TimeManager, :repository

  alias TimeManager.Accounts.UserModel

  alias TimeManager.Accounts.Application.UserRepository

  @behaviour UserRepository

  import UUIDValidator

  def get_all() do
    Repo.all(UserModel)
  end

  def get_by_id(id) do
    with {:ok, id} <- valide_uuid(id) do
      Repo.get(UserModel, id)
    else
      _ -> nil
    end
  end

  def insert(user) do
    user
    |> Repo.insert()
  end

  def get_by_email_and_username(email, username) do
    Repo.get_by(UserModel, email: email, username: username)
  end

  def get_by_email(email) do
    Repo.get_by(UserModel, email: email)
  end

  # TODO: changeset from the service..
  def update(user, _params) do
    user
    |> Repo.update()
  end

  def delete(user) do
    Repo.delete(user)
  end
end
