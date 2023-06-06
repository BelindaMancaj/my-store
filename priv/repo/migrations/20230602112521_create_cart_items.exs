defmodule MyStore.Repo.Migrations.CreateCartItems do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      add :product_id, :integer
      add :quantity, :integer

      timestamps()
    end
  end
end
