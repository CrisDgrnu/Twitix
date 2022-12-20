defmodule ApiWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ApiWeb do
    pipe_through(:api)

    resources("/users", UserController, only: [:index, :show, :create, :update, :delete]) do
      resources("/posts", PostController, only: [:index, :show, :create, :update, :delete])
    end
  end
end
