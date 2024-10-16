defmodule TimeManager.TimeTracking.TeamModel do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.UserModel

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :name, :string
    belongs_to(:manager, UserModel)
    many_to_many :users, UserModel, join_through: "teams_users"

    timestamps(type: :utc_datetime)
  end

  def changeset(team, params) do
    team
    |> cast(params, [:name, :manager_id, :user_id])
    |> validate_required([:name, :manager_id])
    |> assoc_constraint(:manager)
  end

  def changeset_update(team, params) do
    team
    |> cast_assoc(:users, with: &UserModel.changeset/2)
  end
end

# defmodule TimeManager.TimeTracking.TeamUserModel do
#   use Ecto.Schema
#   import Ecto.Changeset
#
#   @primary_key false
#   schema "teams_users" do
#     belongs_to :team, TimeManager.TimeTracking.TeamModel
#     belongs_to :user, TimeManager.Accounts.UserModel
#
#     timestamps(type: :utc_datetime)
#   end
#
#   def changeset(team_user, params) do
#     team_user
#     |> cast_assoc
#   end
# end
