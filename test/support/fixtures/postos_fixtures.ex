defmodule Api.PostosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Postos` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        likes: 42,
        text: "some text"
      })
      |> Api.Postos.create_post()

    post
  end
end
