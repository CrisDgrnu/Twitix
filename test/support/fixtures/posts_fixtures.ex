defmodule Api.PostsFixtures do
  alias Api.Posts.{Services.PostCrud}
  alias Api.Users.Model.User

  import Api.UsersFixtures

  def create_test_post(attrs \\ %{}) do
    %User{id: user_id} = create_test_user()

    {:ok, post} =
      attrs
      |> Enum.into(%{
        user_id: user_id,
        likes: 42,
        text: "some text"
      })
      |> PostCrud.create_post()

    post
  end
end
