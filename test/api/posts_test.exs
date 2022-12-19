defmodule Api.PostosTest do
  use Api.DataCase

  alias Api.Postos

  describe "posts" do
    alias Api.Postos.Post

    import Api.PostosFixtures

    @invalid_attrs %{likes: nil, text: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Postos.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Postos.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{likes: 42, text: "some text"}

      assert {:ok, %Post{} = post} = Postos.create_post(valid_attrs)
      assert post.likes == 42
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Postos.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{likes: 43, text: "some updated text"}

      assert {:ok, %Post{} = post} = Postos.update_post(post, update_attrs)
      assert post.likes == 43
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Postos.update_post(post, @invalid_attrs)
      assert post == Postos.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Postos.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Postos.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Postos.change_post(post)
    end
  end
end
