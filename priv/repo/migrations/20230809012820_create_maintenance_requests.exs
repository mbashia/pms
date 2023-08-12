defmodule PropertyManagementSystem.Repo.Migrations.CreateMaintenanceRequests do
  use Ecto.Migration

  def change do
    create table(:maintenance_requests) do
      add :request_date, :date
      add :description, :text
      add :status, :string
      add :cost, :float
      add :user_id, references(:users, on_delete: :nothing)


      timestamps()
    end
    create index(:maintenance_requests, [:user_id])

  end
end
