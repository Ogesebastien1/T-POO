defmodule TimeManager.Accounts.Application.ManageUserService do
  use TimeManager, :application_service

  alias TimeManager.Accounts.{UserModel, Infrastructure.UserRepository}

  def get_users() do
    UserRepository.get_all()
  end

  def get_user_by_id(id) do
    case UserRepository.get_by_id(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_user_by_email_and_username(email, username) do
    case UserRepository.get_by_email_and_username(email, username) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_user_by_email(email) do
    case UserRepository.get_by_email(email) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def create_user(params) do
    %UserModel{}
    |> UserModel.changeset(params)
    |> UserRepository.insert()
  end

  def update_user(user, update_user) do
    user
    |> UserModel.changeset(update_user)
    |> UserRepository.update(update_user)
    |> IO.inspect()
  end

  def delete_user(user) do
    user
    |> UserRepository.delete()
  end
end
