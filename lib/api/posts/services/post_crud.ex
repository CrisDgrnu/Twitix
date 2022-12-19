defmodule Api.Posts.Services.PostCrud do
  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Posts.Model.Post

  def list_posts do
    Repo.all(Post)
  end

  def get_post(id), do: Repo.get(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(id, attrs) do
    case get_post(id) do
      nil -> {:error, :not_found}
      post -> post |> Post.changeset(attrs) |> Repo.update()
    end
  end

  def delete_post(id) do
    case get_post(id) do
      nil -> {:error, :not_found}
      post -> Repo.delete(post)
    end
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
