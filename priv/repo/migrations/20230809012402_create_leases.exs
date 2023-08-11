defmodule PropertyManagementSystem.Repo.Migrations.CreateLeases do
  use Ecto.Migration

  def change do
    create table(:leases) do
      add :status, :string
      add :rent_amount, :float
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end
  end
end
