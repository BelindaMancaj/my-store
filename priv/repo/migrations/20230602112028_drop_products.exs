defmodule MyStore.Repo.Migrations.DropProducts do
  use Ecto.Migration

  def change do
    drop table("products")
  end
end
