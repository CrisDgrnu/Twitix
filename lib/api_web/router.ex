defmodule ApiWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ApiWeb do
    pipe_through(:api)

    resources("/accounts", AccountController, only: [:index, :show, :create, :update, :delete])
    resources("/users", UserController, only: [:index, :show, :create, :update, :delete])
    resources("/posts", PostController, only: [:index, :show, :create, :update, :delete])
  end
end
