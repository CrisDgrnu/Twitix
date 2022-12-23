defmodule Test.UsersFixtures do
  alias Api.Users.Services.UserCrud

  @email "cris@dev.com"
  @password "1234"

  def create_test_user(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: @email,
        password: @password,
        biography: "some biography",
        full_name: "some full_name",
        gender: :male
      })
      |> UserCrud.create_user()

    user
  end

  def get_user(user_id) do
    UserCrud.get_user(user_id)
  end

  def get_user_credentials() do
    {@email, @password}
  end
end
