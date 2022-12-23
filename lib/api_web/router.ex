defmodule ApiWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug ApiWeb.Auth.AccessPipeline
  end

  scope "/api", ApiWeb do
    pipe_through([:api])

    post "/login", LoginController, :login
  end

  scope "/api", ApiWeb do
    pipe_through([:api, :auth])

    resources("/users", UserController, only: [:index, :show, :create, :update, :delete]) do
      resources("/posts", PostController, only: [:index, :show, :create, :update, :delete])
    end
  end
end
