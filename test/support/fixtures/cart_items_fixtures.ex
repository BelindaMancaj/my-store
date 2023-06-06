defmodule MyStore.CartItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyStore.CartItems` context.
  """

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{
        product_id: 42,
        quantity: 42
      })
      |> MyStore.CartItems.create_cart_item()

    cart_item
  end
end
