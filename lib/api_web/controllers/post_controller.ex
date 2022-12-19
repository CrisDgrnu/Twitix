defmodule ApiWeb.PostController do
  use ApiWeb, :controller

  alias Api.Posts.Services.PostCrud
  alias Api.Posts.Model.Post

  action_fallback(ApiWeb.FallbackController)

  def index(conn, _params) do
    posts = PostCrud.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- PostCrud.create_post(post_params) do
      conn
      |> put_status(:created)
      |> render("show.json", post: %{post | likes: 0})
    end
  end

  def show(conn, %{"id" => id}) do
    case PostCrud.get_post(id) do
      nil -> {:error, :not_found}
      post -> conn |> put_status(:ok) |> render("show.json", post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    case PostCrud.update_post(id, post_params) do
      {:ok, updated_post} -> render(conn, "show.json", post: updated_post)
      {:error, code} -> {:error, code}
    end
  end

  def delete(conn, %{"id" => id}) do
    case PostCrud.delete_post(id) do
      {:ok, _} -> send_resp(conn, :no_content, "")
      {:error, code} -> {:error, code}
    end
  end
end
