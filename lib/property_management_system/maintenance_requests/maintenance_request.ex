defmodule PropertyManagementSystem.Maintenance_requests.Maintenance_request do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User
  alias PropertyManagementSystem.Propertys.Property


  schema "maintenance_requests" do
    field :cost, :float
    field :description, :string
    field :request_date, :date
    field :status, :string
    belongs_to :user, User
    belongs_to :property, Property, foreign_key: :property_id


    timestamps()
  end

  @doc false
  def changeset(maintenance_request, attrs) do
    maintenance_request
    |> cast(attrs, [:request_date, :description, :status, :cost, :user_id, :property_id])
    |> validate_required([:request_date, :description, :status, :cost, :user_id, :property_id])
  end
end
