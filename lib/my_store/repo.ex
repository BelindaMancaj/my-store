defmodule MyStore.Repo do
  use Ecto.Repo,
    otp_app: :my_store,
    adapter: Ecto.Adapters.Postgres
end
