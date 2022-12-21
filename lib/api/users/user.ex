defmodule Api.Users.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:hash_password, :string)
    field(:biography, :string)
    field(:full_name, :string)
    field(:gender, Ecto.Enum, values: [:male, :female])
    has_many(:posts, Api.Posts.Model.Post)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :hash_password, :full_name, :gender, :biography])
  end
end
