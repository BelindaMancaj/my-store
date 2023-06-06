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

    get "/", ProductController, :index
    get "/new", ProductController, :new
    post "/", ProductController, :create
    # get "/:id", ProductController, :show #This causes an error after I added the cart routes
    get "/:id/edit", ProductController, :edit
    put "/:id", ProductController, :update
    delete "/:id", ProductController, :delete
    get "/add_to_cart/:id", ProductController, :add_to_cart
    #cart item routes
    get "/cart_items/", CartItemController, :index
    get "/cart_items/:id/edit", CartItemController, :edit
    put "/cart_items/:id", CartItemController, :update
    delete "/cart_items/:id", CartItemController, :delete

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
