defmodule MyStoreWeb.Router do
  use MyStoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MyStoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/products", MyStoreWeb do
    pipe_through :browser

    #The show route for products, causes an error when trying to show the cart items
    resources "/", ProductController, except: [:show]

    # resources "/cart_items/:id", CartItemController, only: [:create]

    get "/add_to_cart/:id", ProductController, :add_to_cart
    post "/cart_items", ProductController, :create_cart_items
  end

  scope "/products", MyStoreWeb do
    pipe_through :browser

    resources "/cart_items", CartItemController, except: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyStoreWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:my_store, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MyStoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
