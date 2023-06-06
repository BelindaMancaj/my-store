defmodule MyStore.CartItemsTest do
  use MyStore.DataCase

  alias MyStore.CartItems

  describe "cart_items" do
    alias MyStore.CartItems.CartItem

    import MyStore.CartItemsFixtures

    @invalid_attrs %{product_id: nil, quantity: nil}

    test "list_cart_items/0 returns all cart_items" do
      cart_item = cart_item_fixture()
      assert CartItems.list_cart_items() == [cart_item]
    end

    test "get_cart_item!/1 returns the cart_item with given id" do
      cart_item = cart_item_fixture()
      assert CartItems.get_cart_item!(cart_item.id) == cart_item
    end

    test "create_cart_item/1 with valid data creates a cart_item" do
      valid_attrs = %{product_id: 42, quantity: 42}

      assert {:ok, %CartItem{} = cart_item} = CartItems.create_cart_item(valid_attrs)
      assert cart_item.product_id == 42
      assert cart_item.quantity == 42
    end

    test "create_cart_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CartItems.create_cart_item(@invalid_attrs)
    end

    test "update_cart_item/2 with valid data updates the cart_item" do
      cart_item = cart_item_fixture()
      update_attrs = %{product_id: 43, quantity: 43}

      assert {:ok, %CartItem{} = cart_item} = CartItems.update_cart_item(cart_item, update_attrs)
      assert cart_item.product_id == 43
      assert cart_item.quantity == 43
    end

    test "update_cart_item/2 with invalid data returns error changeset" do
      cart_item = cart_item_fixture()
      assert {:error, %Ecto.Changeset{}} = CartItems.update_cart_item(cart_item, @invalid_attrs)
      assert cart_item == CartItems.get_cart_item!(cart_item.id)
    end

    test "delete_cart_item/1 deletes the cart_item" do
      cart_item = cart_item_fixture()
      assert {:ok, %CartItem{}} = CartItems.delete_cart_item(cart_item)
      assert_raise Ecto.NoResultsError, fn -> CartItems.get_cart_item!(cart_item.id) end
    end

    test "change_cart_item/1 returns a cart_item changeset" do
      cart_item = cart_item_fixture()
      assert %Ecto.Changeset{} = CartItems.change_cart_item(cart_item)
    end
  end
end
