defmodule Api.Posts.Model.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field(:likes, :integer)
    field(:text, :string)
    belongs_to(:user, Api.Users.Model.User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :text, :likes])
    |> validate_required([:user_id, :text])
    |> unique_constraint(:text)
    |> assoc_constraint(:user)
  end
end
