defmodule PropertyManagementSystem.Propertys.Property do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User

  schema "propertys" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :size, :string
    field :status, :string
    field :type, :string
    field :image, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :address, :type, :status, :size, :description, :user_id, :image])
    |> validate_required([:name, :address, :type, :status, :size, :description, :user_id, :image])
  end
end
