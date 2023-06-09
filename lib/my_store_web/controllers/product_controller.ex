defmodule MyStoreWeb.ProductController do
  use MyStoreWeb, :controller

  alias MyStore.Products
  alias MyStore.Products.Product
  alias MyStore.CartItems
  alias MyStore.CartItems.CartItem

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def new(conn, _params) do
    changeset = Products.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Products.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  # def add_to_cart(conn, %{"id" => id}) do
  #   product = Products.get_product!(id)
  #   changeset = Products.change_product(product)
  #   render(conn, :cart_item_form, product: product, changeset: changeset)
  # end

  # def create_cart_items(conn, %{"cart_item" => cart_item_params}) do
  #   case CartItems.create_cart_item(cart_item_params) do
  #     {:ok, cart_item} ->
  #       conn
  #       |> put_flash(:info, "Product added to cart successfully.")
  #       |> redirect(to: ~p"/products/cart_items")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :cart_item, changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end
end
