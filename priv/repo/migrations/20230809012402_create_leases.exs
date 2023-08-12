defmodule PropertyManagementSystem.Repo.Migrations.CreateLeases do
  use Ecto.Migration

  def change do
    create table(:leases) do
      add :status, :string
      add :rent_amount, :float
      add :start_date, :date
      add :end_date, :date
      add :user_id, references(:users, on_delete: :nothing)


      timestamps()
    end
    create index(:leases, [:user_id])

  end
end
