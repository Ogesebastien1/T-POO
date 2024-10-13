defmodule TimeManager.Accounts.Application.AuthService do
  use TimeManager, :application_service

  alias TimeManager.Accounts.{Infrastructure.UserRepository, Application.PasswordHasher}
  alias PasswordHasher

  def login(%{"email" => email, "password" => password}) do
    case UserRepository.get_by_email(email) do
      nil ->
        {:error, :user_not_found}

      user ->
        authenticate_with_password(user, password)
    end
  end

  defp authenticate_with_password(user, password) do
    with true <- PasswordHasher.verify_password(password, user.password_hash) do
      {:ok, user}
    else
      false -> {:error, :invalid_password}
    end
  end
end
