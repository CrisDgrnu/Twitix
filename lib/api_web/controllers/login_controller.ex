defmodule ApiWeb.LoginController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  alias ApiWeb.Auth.Guardian

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case Guardian.authenticate(username, password) do
      {:ok, token} -> build_login_response(conn, token)
      {:error, :unauthorized} -> {:error, :unauthorized}
    end
  end

  defp build_login_response(conn, token) do
    conn
    |> put_status(:ok)
    |> render("show.json", token: token)
  end
end
