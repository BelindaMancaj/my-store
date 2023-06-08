defmodule MyStore.Repo.Migrations.RemoveProductId do
  use Ecto.Migration

  def change do
    alter table(:cart_items) do
      remove :product_id
    end
  end
end
