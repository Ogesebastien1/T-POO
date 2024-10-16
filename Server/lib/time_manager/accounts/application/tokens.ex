defmodule TimeManager.Accounts.Application.Token do
  @day_in_seconds 86_400
  @token_age @day_in_seconds
  @namespace "user auth"
  alias Phoenix.Token

  def sign(data) do
    Token.sign(TimeManagerWeb.Endpoint, @namespace, data, [%{:max_age => @token_age}])
  end

  def verify(token) do
    Token.verify(TimeManagerWeb.Endpoint, @namespace, token)
  end
end
