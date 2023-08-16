defmodule PropertyManagementSystem.Propertys.Property do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User
  alias PropertyManagementSystem.Maintenance_requests.Maintenance_request


  schema "propertys" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :size, :string
    field :status, :string
    field :type, :string
    field :image, :string
    belongs_to :user, User
    has_many :maintenace_requests, Maintenance_request


    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :address, :type, :status, :size, :description, :user_id, :image])
    |> validate_required([:name, :address, :type, :status, :size, :description, :user_id, :image])
  end
end
