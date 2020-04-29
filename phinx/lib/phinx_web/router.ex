defmodule PhinxWeb.Router do
  use PhinxWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhinxWeb do
    pipe_through :api
    resources "/users", UserController do
      get "/hack", UserController, :hack
    end
  end
end
