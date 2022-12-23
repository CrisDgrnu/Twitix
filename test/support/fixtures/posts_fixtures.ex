defmodule Test.PostsFixtures do
  alias Api.Posts.{Services.PostCrud}

  def create_test_post(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        likes: 42,
        text: "some text"
      })
      |> PostCrud.create_post()

    post
  end
end
