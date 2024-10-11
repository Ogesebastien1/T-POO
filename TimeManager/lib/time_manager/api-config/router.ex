defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :authenticated do
    plug TimeManagerWeb.Guard.AuthGuard
  end

  scope "/api/users", TimeManagerWeb do
    pipe_through :api

    get "/", Accounts.Infrastructure.UserController, :index
    get "/:id", Accounts.Infrastructure.UserController, :show
    post "/", Accounts.Infrastructure.UserController, :create
    put "/:id", Accounts.Infrastructure.UserController, :update
    delete "/:id", Accounts.Infrastructure.UserController, :delete
  end

  scope "/api/workingtimes", TimeManagerWeb do
    pipe_through :api

    get "/:userID", TimeTracking.Infrastructure.WorkingTimeController, :show
    get "/:userID/:id", TimeTracking.Infrastructure.WorkingTimeController, :show
    post "/:userID", TimeTracking.Infrastructure.WorkingTimeController, :create
    put "/:id", TimeTracking.Infrastructure.WorkingTimeController, :update
    delete "/:id", TimeTracking.Infrastructure.WorkingTimeController, :delete
  end

  scope "/api/clocks", TimeManagerWeb do
    pipe_through :api

    get "/:userID", TimeTracking.Infrastructure.ClockController, :index
    post "/:userID", TimeTracking.Infrastructure.ClockController, :create
  end

  scope "/api/registration", TimeManagerWeb do
    pipe_through :api

    post "/", Accounts.Infrastructure.RegisterController, :register
  end

  scope "/api/auth", TimeManagerWeb do
    pipe_through :api

    post "/", Accounts.Infrastructure.AuthController, :login
  end

  scope "/api/auth", TimeManagerWeb do
    pipe_through [:api, :authenticated]

    get "/me", Accounts.Infrastructure.AuthController, :me
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:time_manager, :dev_routes) do
    scope "/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI,
        otp_app: :time_manager,
        swagger_file: "swagger.json"
    end

    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard "/dashboard", metrics: TimeManagerWeb.Telemetry
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "My App"
      }
    }
  end
end
