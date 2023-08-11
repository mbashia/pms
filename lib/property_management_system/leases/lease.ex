defmodule PropertyManagementSystem.Leases.Lease do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leases" do
    field :end_date, :date
    field :rent_amount, :float
    field :start_date, :date
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(lease, attrs) do
    lease
    |> cast(attrs, [:status, :rent_amount, :start_date, :end_date])
    |> validate_required([:status, :rent_amount, :start_date, :end_date])
  end
end
