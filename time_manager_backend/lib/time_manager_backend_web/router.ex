defmodule TimeManagerBackendWeb.Router do
  use TimeManagerBackendWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", TimeManagerBackendWeb do
    pipe_through(:api)

    resources("/users", UserController, except: [:new, :edit])
    resources("/workingtimes", WorkingTimeController, except: [:new, :edit])
    resources("/clocks", ClockController, except: [:new, :edit])
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:time_manager_backend, :dev_routes) do
    scope "/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :time_manager_backend, swagger_file: "swagger.json"
    end

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

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
