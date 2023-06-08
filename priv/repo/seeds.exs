# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#

alias MyStore.Repo
alias MyStore.CartItems.CartItem

  Repo.insert!(%CartItem{
    product_id: 2,
    quantity: 4
  })
