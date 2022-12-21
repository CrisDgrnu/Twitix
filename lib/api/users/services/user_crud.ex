defmodule Api.Users.Services.UserCrud do
  import Ecto.Query, warn: false

  alias Api.Repo
  alias Api.Users.Model.User

  def list_users do
    Repo.all(User)
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(id, attrs) do
    case get_user(id) do
      nil -> {:error, :not_found}
      user -> user |> User.changeset(attrs) |> Repo.update()
    end
  end

  def delete_user(id) do
    case get_user(id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
