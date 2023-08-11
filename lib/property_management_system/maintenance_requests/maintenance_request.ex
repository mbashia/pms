defmodule PropertyManagementSystem.Maintenance_requests.Maintenance_request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "maintenance_requests" do
    field :cost, :float
    field :description, :string
    field :request_date, :date
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(maintenance_request, attrs) do
    maintenance_request
    |> cast(attrs, [:request_date, :description, :status, :cost])
    |> validate_required([:request_date, :description, :status, :cost])
  end
end
