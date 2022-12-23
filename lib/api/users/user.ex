defmodule Api.Users.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string, source: :hash_password
    field :biography, :string
    field :full_name, :string
    field :gender, Ecto.Enum, values: [:male, :female]
    has_many :posts, Api.Posts.Model.Post

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :full_name, :gender, :biography])
    |> hash_password()
  end

  defp hash_password(
         %Ecto.Changeset{valid?: true, changes: %{password: raw_password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(raw_password))
  end

  defp hash_password(changeset), do: changeset
end
