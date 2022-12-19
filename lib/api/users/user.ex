defmodule Api.Users.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:biography, :string)
    field(:full_name, :string)
    field(:gender, Ecto.Enum, values: [:male, :female])
    has_many(:posts, Api.Posts.Model.Post)
    belongs_to(:account, Api.Accounts.Model.Account)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name, :gender, :biography])
    |> validate_required([:account_id])
    |> unique_constraint(:account_id)
    |> assoc_constraint(:account)
  end
end
