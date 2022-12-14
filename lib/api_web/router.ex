defmodule ApiWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  use Plug.ErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create, :update, :delete]
    resources "/accounts", AccountController, only: [:index, :show, :create, :update, :delete]
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
