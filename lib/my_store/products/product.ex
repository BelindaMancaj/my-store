defmodule MyStore.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :image, :string
    field :name, :string
    field :price, :decimal
    has_one :cart_items, MyStore.CartItems.CartItem


    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :image])
    |> validate_required([:name, :description, :price, :image])
  end
end
