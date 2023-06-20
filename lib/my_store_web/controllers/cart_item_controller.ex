defmodule MyStoreWeb.CartItemController do
  use MyStoreWeb, :controller

  alias MyStore.CartItems
  alias MyStore.CartItems.CartItem

  def index(conn, _params) do
    cart_items = CartItems.list_cart_items()
    render(conn, :index, cart_items: cart_items)
  end

  def new(conn, _params) do
    changeset = CartItems.change_cart_item(%CartItem{})
    render(conn, :new, changeset: changeset)
  end

  # def create(conn, %{"cart_item" => cart_item_params}) do

  #   case CartItems.create_cart_item(conn, cart_item_params) do
  #     {:ok, cart_item} ->
  #       conn
  #       |> put_flash(:info, "Cart item created successfully.")
  #       |> redirect(to: ~p"/products/cart_items/#{cart_item}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    cart_item = CartItems.get_cart_item!(id)
    render(conn, :show, cart_item: cart_item)
  end

  def edit(conn, %{"id" => id}) do
    cart_item = CartItems.get_cart_item!(id)
    changeset = CartItems.change_cart_item(cart_item)
    render(conn, :edit, cart_item: cart_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cart_item" => cart_item_params}) do
    cart_item = CartItems.get_cart_item!(id)

    case CartItems.update_cart_item(cart_item, cart_item_params) do
      {:ok, cart_item} ->
        conn
        |> put_flash(:info, "Cart item updated successfully.")
        |> redirect(to: ~p"/products/cart_items/#{cart_item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, cart_item: cart_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart_item = CartItems.get_cart_item!(id)
    {:ok, _cart_item} = CartItems.delete_cart_item(cart_item)

    conn
    |> put_flash(:info, "Cart item deleted successfully.")
    |> redirect(to: ~p"/products/cart_items")
  end
end
