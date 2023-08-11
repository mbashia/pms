defmodule PropertyManagementSystem.Repo.Migrations.CreatePropertys do
  use Ecto.Migration

  def change do
    create table(:propertys) do
      add :name, :string
      add :address, :string
      add :type, :string
      add :status, :string
      add :size, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:propertys, [:user_id])

  end
end
