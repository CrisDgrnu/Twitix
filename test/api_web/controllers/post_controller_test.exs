defmodule ApiWeb.PostControllerTest do
  use ApiWeb.ConnCase

  import Test.{PostsFixtures, UsersFixtures, AuthFixtures}

  alias Api.Posts.Model.Post
  alias ApiWeb.Auth.Guardian

  @create_attrs %{
    likes: 42,
    text: "some text"
  }
  @update_attrs %{
    likes: 43,
    text: "some updated text"
  }
  @invalid_attrs %{likes: nil, text: nil}

  setup %{conn: conn} do
    %{id: user_id} = create_test_user()
    {:ok, conn: setup_auth_connection(conn), user_id: user_id}
  end

  describe "index" do
    test "lists all posts", %{conn: conn, user_id: user_id} do
      conn = get(conn, Routes.user_post_path(conn, :index, user_id))
      data = json_response(conn, 200)["data"]
      assert is_list(data)
      assert data == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn, user_id: user_id} do
      post = Map.put(@create_attrs, :user_id, user_id)
      conn = post(conn, Routes.user_post_path(conn, :create, user_id), post: post)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, id))

      expected_response_body = %{
        "id" => id,
        "likes" => 42,
        "text" => "some text"
      }

      assert expected_response_body == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_id: user_id} do
      conn = post(conn, Routes.user_post_path(conn, :create, user_id), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    test "renders post when data is valid", %{conn: conn, user_id: user_id} do
      post = create_test_post(%{user_id: user_id})
      %Post{id: id} = post

      update_post = Map.put(@update_attrs, :user_id, user_id)
      conn = put(conn, Routes.user_post_path(conn, :update, user_id, post), post: update_post)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, id))

      expected_response_body = %{
        "id" => id,
        "likes" => 43,
        "text" => "some updated text"
      }

      assert expected_response_body == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_id: user_id} do
      post = create_test_post(%{user_id: user_id})

      conn = put(conn, Routes.user_post_path(conn, :update, user_id, post), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    test "deletes chosen post", %{conn: conn, user_id: user_id} do
      post = create_test_post(%{user_id: user_id})

      conn = delete(conn, Routes.user_post_path(conn, :delete, user_id, post))
      assert response(conn, 204)

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, post.id))
      assert response(conn, 404)
    end
  end
end
