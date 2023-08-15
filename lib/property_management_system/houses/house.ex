defmodule PropertyManagementSystem.Houses.House do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertyManagementSystem.Accounts.User

  schema "houses" do
    field :date_occupied, :date
    field :date_vacated, :date
    field :description, :string
    field :floor_number, :string
    field :house_number, :string
    field :rent_amount, :float
    field :size, :float
    field :status, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(house, attrs) do
    house
    |> cast(attrs, [
      :house_number,
      :rent_amount,
      :size,
      :description,
      :status,
      :date_occupied,
      :date_vacated,
      :floor_number,
      :user_id
    ])
    |> validate_required([
      :house_number,
      :rent_amount,
      :size,
      :description,
      :status,
      :date_occupied,
      :date_vacated,
      :floor_number,
      :user_id
    ])
  end
end
