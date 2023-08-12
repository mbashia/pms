defmodule PropertyManagementSystem.Maintenance_requests.Maintenance_request do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User


  schema "maintenance_requests" do
    field :cost, :float
    field :description, :string
    field :request_date, :date
    field :status, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(maintenance_request, attrs) do
    maintenance_request
    |> cast(attrs, [:request_date, :description, :status, :cost, :user_id])
    |> validate_required([:request_date, :description, :status, :cost, :user_id])
  end
end
