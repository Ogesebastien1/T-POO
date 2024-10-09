defmodule TimeManager.TimeTracking.Clock do
  use TimeManager, :domain_model

  alias TimeManager.Accounts.User
  alias TimeManager.TimeTracking.Clock

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :time, :utc_datetime
    field :status, :boolean
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(clock, attrs) do
    IO.inspect(attrs.user.id)

    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> assoc_constraint(:user)
  end
end
