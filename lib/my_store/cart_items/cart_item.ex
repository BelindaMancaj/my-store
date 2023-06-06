defmodule MyStore.CartItems.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field :product_id, :integer
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, [:product_id, :quantity])
    |> validate_required([:product_id, :quantity])
  end
end
