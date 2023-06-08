defmodule MyStore.Repo.Migrations.CreatingConnection do
  use Ecto.Migration

  def change do
    alter table(:cart_items) do
      add :product_id, references(:products)
    end
   create unique_index(:cart_items, [:product_id])
  end
end
