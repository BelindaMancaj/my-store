defmodule MyStoreWeb.CartItemHTML do
  use MyStoreWeb, :html

  embed_templates "cart_item_html/*"

  @doc """
  Renders a cart_item form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def cart_item_form(assigns)
end
