defmodule Api.UsersFixtures do
  alias Api.Users.Services.UserCrud

  def create_test_user(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        full_name: "some full_name",
        gender: :male
      })
      |> UserCrud.create_user()

    user
  end
end
