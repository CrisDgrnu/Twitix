# defmodule Api.PostosFixtures do
#   alias Api.Posts.{Services.PostCrud}

#   def post_fixture(attrs \\ %{}) do
#     {:ok, post} =
#       attrs
#       |> Enum.into(%{
#         likes: 42,
#         text: "some text"
#       })
#       |> PostCrud.create_post()

#     post
#   end
# end
