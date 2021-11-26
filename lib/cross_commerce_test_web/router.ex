defmodule CrossCommerceTestWeb.Router do
  use CrossCommerceTestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CrossCommerceTestWeb do
    pipe_through :api

    get "/numbers", NumbersController, :show
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: CrossCommerceTestWeb.Telemetry
    end
  end
end
