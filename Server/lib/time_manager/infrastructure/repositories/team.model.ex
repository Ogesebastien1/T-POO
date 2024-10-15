defmodule TimeManager.TimeTracking.TeamModel do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.UserModel

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    belongs_to(:manager, UserModel)
    belongs_to(:user, UserModel)

    timestamps(type: :utc_datetime)
  end

  def changeset(team, params) do
    team
    |> cast(params, [:name, :manager_id, :user_id])
    |> validate_required([:name, :manager_id])
    |> assoc_constraint(:manager)
  end
end
