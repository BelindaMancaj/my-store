defmodule MyStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :price, :decimal
      add :image, :string

      timestamps()
    end
  end
end
