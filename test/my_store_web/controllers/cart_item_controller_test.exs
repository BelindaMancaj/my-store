defmodule MyStoreWeb.CartItemControllerTest do
  use MyStoreWeb.ConnCase

  import MyStore.CartItemsFixtures

  @create_attrs %{product_id: 42, quantity: 42}
  @update_attrs %{product_id: 43, quantity: 43}
  @invalid_attrs %{product_id: nil, quantity: nil}

  describe "index" do
    test "lists all cart_items", %{conn: conn} do
      conn = get(conn, ~p"/cart_items")
      assert html_response(conn, 200) =~ "Listing Cart items"
    end
  end

  describe "new cart_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/cart_items/new")
      assert html_response(conn, 200) =~ "New Cart item"
    end
  end

  describe "create cart_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/cart_items", cart_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/cart_items/#{id}"

      conn = get(conn, ~p"/cart_items/#{id}")
      assert html_response(conn, 200) =~ "Cart item #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/cart_items", cart_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Cart item"
    end
  end

  describe "edit cart_item" do
    setup [:create_cart_item]

    test "renders form for editing chosen cart_item", %{conn: conn, cart_item: cart_item} do
      conn = get(conn, ~p"/cart_items/#{cart_item}/edit")
      assert html_response(conn, 200) =~ "Edit Cart item"
    end
  end

  describe "update cart_item" do
    setup [:create_cart_item]

    test "redirects when data is valid", %{conn: conn, cart_item: cart_item} do
      conn = put(conn, ~p"/cart_items/#{cart_item}", cart_item: @update_attrs)
      assert redirected_to(conn) == ~p"/cart_items/#{cart_item}"

      conn = get(conn, ~p"/cart_items/#{cart_item}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, cart_item: cart_item} do
      conn = put(conn, ~p"/cart_items/#{cart_item}", cart_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Cart item"
    end
  end

  describe "delete cart_item" do
    setup [:create_cart_item]

    test "deletes chosen cart_item", %{conn: conn, cart_item: cart_item} do
      conn = delete(conn, ~p"/cart_items/#{cart_item}")
      assert redirected_to(conn) == ~p"/cart_items"

      assert_error_sent 404, fn ->
        get(conn, ~p"/cart_items/#{cart_item}")
      end
    end
  end

  defp create_cart_item(_) do
    cart_item = cart_item_fixture()
    %{cart_item: cart_item}
  end
end
