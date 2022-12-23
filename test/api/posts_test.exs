defmodule Api.PostCrudTest do
  use Api.DataCase

  alias Api.Posts.Services.PostCrud

  describe "posts" do
    alias Api.Posts.Model.Post

    import Test.{PostsFixtures, UsersFixtures}

    @invalid_attrs %{user_id: nil, likes: nil, text: nil}

    setup _ do
      %{id: user_id} = create_test_user()
      {:ok, user_id: user_id}
    end

    test "list_posts/0 returns all posts", %{user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      assert PostCrud.list_posts() == [post]
    end

    test "get_post/1 returns the post with given id", %{user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      assert PostCrud.get_post(post.id) == post
    end

    test "create_post/1 with valid data creates a post", %{user_id: user_id} do
      valid_attrs = %{user_id: user_id, likes: 42, text: "some text"}

      assert {:ok, %Post{} = post} = PostCrud.create_post(valid_attrs)
      assert post.likes == 42
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostCrud.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post", %{user_id: user_id} do
      %{id: post_id} = create_test_post(%{user_id: user_id})
      update_attrs = %{likes: 43, text: "some updated text"}

      assert {:ok, %Post{} = post} = PostCrud.update_post(post_id, update_attrs)
      assert post.likes == 43
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset", %{user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      assert {:error, %Ecto.Changeset{}} = PostCrud.update_post(post.id, @invalid_attrs)
      assert post == PostCrud.get_post(post.id)
    end

    test "delete_post/1 deletes the post", %{user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      assert {:ok, %Post{}} = PostCrud.delete_post(post.id)
      assert nil == PostCrud.get_post(post.id)
    end

    test "change_post/1 returns a post changeset", %{user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      assert %Ecto.Changeset{} = PostCrud.change_post(post)
    end
  end
end
