defmodule PropertyManagementSystem.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :house_number, :string
      add :rent_amount, :float
      add :size, :float
      add :description, :text
      add :status, :string
      add :date_occupied, :date
      add :date_vacated, :date
      add :floor_number, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:houses, [:user_id])
  end
end
