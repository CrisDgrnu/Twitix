defmodule ApiWeb.UserController do
  use ApiWeb, :controller
  alias Api.Users.Services.UserCrud

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    users = UserCrud.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- UserCrud.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    case UserCrud.get_user(id) do
      nil -> {:error, :not_found}
      user -> conn |> put_status(:ok) |> render("show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    case UserCrud.update_user(id, user_params) do
      {:ok, updated_user} -> render(conn, "show.json", user: updated_user)
      {:error, code} -> {:error, code}
    end
  end

  def delete(conn, %{"id" => id}) do
    case UserCrud.delete_user(id) do
      {:ok, _} -> send_resp(conn, :no_content, "")
      {:error, code} -> {:error, code}
    end
  end
end
