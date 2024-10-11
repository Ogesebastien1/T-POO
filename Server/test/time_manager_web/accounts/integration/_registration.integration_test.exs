# defmodule TimeManagerWeb.Test.Integration.RegistrationDataBuilder do
#   defstruct username: "test", email: "test@gmail.com", password: "password"
#
#   def with_username(data, username) do
#     %{data | username: username}
#   end
#
#   def with_email(data, email) do
#     %{data | email: email}
#   end
#
#   def with_password(data, password) do
#     %{data | password: password}
#   end
# end
#
# defmodule TimeManagerWeb.Test.Integration.RegistrationTest do
#   use TimeManagerWeb.ConnCase
#   alias TimeManager.Accounts.Application.RegistrationUseCase
#   alias TimeManagerWeb.Test.Integration.{RegistrationFixture, RegistrationDataBuilder}
#
#   test "As an unregistred user, I can register", %{conn: conn} do
#     data = %RegistrationDataBuilder{}
#
#     conn
#     |> RegistrationFixture.when_user_register(data)
#     |> RegistrationFixture.then_user_is_registered()
#   end
# end
#
# defmodule TimeManagerWeb.Test.Integration.RegistrationFixture do
#   use TimeManagerWeb.ConnCase
#   alias TimeManager.Accounts.User
#   alias TimeManagerWeb.Test.Integration.RegistrationDataBuilder
#
#   def when_user_register(conn, params) do
#     conn = post(conn, "/api/register", params)
#     %{conn: conn, body: Jason.decode!(conn.resp_body)}
#   end
#
#   def then_user_is_registered(response) do
#     assert response["body"] != nil
#     assert response["body"]["email"] == %RegistrationDataBuilder{}.email
#     assert response["body"]["username"] == %RegistrationDataBuilder{}.username
#     assert response["body"]["id"] != nil
#     assert response["conn"].status == 201
#   end
#
#   def then_error_is(nil) do
#   end
# end
