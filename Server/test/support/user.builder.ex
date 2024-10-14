defmodule TimeManagerWeb.Test.UserBuilder do
  def user do
    %{
      "username" => "test",
      "email" => "test@gmail.com",
      "password" => "password",
      "role" => "user"
    }
  end

  def with_username(user, username) do
    %{user | "username" => username}
  end

  def with_email(user, email) do
    %{user | "email" => email}
  end

  def with_password(user, password) do
    %{user | "password" => password}
  end

  def invalid_user do
    %{
      "username" => "test"
    }
  end

  def with_role(user, role) do
    %{user | "role" => role}
  end
end
