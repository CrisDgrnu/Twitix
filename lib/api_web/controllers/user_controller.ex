defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Users.Services.UserCrud
  alias Api.Users.Model.User

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    users = UserCrud.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params, "accountId" => account_id}) do
  end

  def show(conn, %{"id" => id}) do
    user = UserCrud.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = UserCrud.get_user!(id)

    with {:ok, %User{} = user} <- UserCrud.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = UserCrud.get_user!(id)

    with {:ok, %User{}} <- UserCrud.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
