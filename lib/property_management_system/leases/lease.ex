defmodule PropertyManagementSystem.Leases.Lease do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User


  schema "leases" do
    field :end_date, :date
    field :rent_amount, :float
    field :start_date, :date
    field :status, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(lease, attrs) do
    lease
    |> cast(attrs, [:status, :rent_amount, :start_date, :end_date, :user_id])
    |> validate_required([:status, :rent_amount, :start_date, :end_date, :user_id])
  end
end
