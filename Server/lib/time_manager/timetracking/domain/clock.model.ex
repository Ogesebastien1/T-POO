defmodule TimeManager.TimeTracking.Clock do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.UserModel

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :time, :utc_datetime
    field :status, :boolean
    belongs_to :user, UserModel

    timestamps(type: :utc_datetime)
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> assoc_constraint(:user)
  end
end
