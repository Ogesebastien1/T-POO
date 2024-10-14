defmodule TimeManager.Accounts.TeamModel do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.UserModel
  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    belongs_to(:manager, UserModel)
    belongs_to(:user, UserModel)

    timestamps(type: :utc_datetime)
  end
end
