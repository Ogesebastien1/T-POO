defmodule TimeManagerWeb.AuthorizationTest do
  use TimeManagerWeb.ConnCase
  alias TimeManager.Fixture.AuthFixture
  import TimeManagerWeb.Test.UserBuilder
  alias TimeManager.Test.SetupFixture.{Registration, Auth, Authorization}
  alias TimeManager.Test.AccountsFixture
  alias TimeManager.Accounts.Application.ManageUserService

  @moduletag :integration
  @moduletag :authorization

  @admin user()
         |> with_email("admin1@gmail.com")
         |> with_username("Monsieur Admin")
         |> with_password("MAIS LOL")
         |> with_role("admin")

  @user user()
        |> with_email("user1@gmail.com")
        |> with_username("User 1")
        |> with_password("MAIS LOL")

  @manager user()
           |> with_password("MAIS LOL")
           |> with_role("moderator")

  describe "As a an Admin, " do
    test "I have an admin role" do
      Registration.given_existing_users([@admin])
      Authorization.assert_user_role(@admin["email"], :admin)
    end
  end

  describe "As a an User, " do
    @describetag :this
    test "I have an user role" do
      Registration.given_existing_users([@user])
      Authorization.assert_user_role(@user["email"], :user)
    end

    test "I can update my profile", %{conn: conn} do
      Registration.given_existing_users([@user])

      user_response = Auth.login_pass(@user["email"], @user["password"])

      token = Auth.extract_auth_token(user_response)

      conn
      |> Auth.put_auth_token(token)
      |> AccountsFixture.update_user(@user |> with_username("User 2"), user_response.user.id)
      |> AccountsFixture.then_user_is_updated(@user |> with_username("User 2"))
    end

    test "I can't update another user's profile", %{conn: conn} do
      user2 = @user |> with_email("user2@gmail.com") |> with_username("User 2")
      registred_users = Registration.given_existing_users([@user, user2])

      user1_response = Auth.login_pass(@user["email"], @user["password"])

      user2_id = Enum.at(registred_users, 0).id

      user1_token = Auth.extract_auth_token(user1_response)

      updated_user_params = @user |> with_username("User 3")

      conn
      |> Auth.put_auth_token(user1_token)
      |> AccountsFixture.update_user(
        updated_user_params,
        user2_id
      )
      |> AccountsFixture.request_is_forbidden()
    end
  end

  describe "As a a Moderator, " do
    test "I have an moderator role" do
      Registration.given_existing_users([@manager])

      Authorization.assert_user_role(@manager["email"], :moderator)
    end
  end
end
