defmodule ApiWeb.PostControllerTest do
  use ApiWeb.ConnCase

  import Api.{PostsFixtures, UsersFixtures}

  alias Api.Posts.Model.Post

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
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      user = create_test_user()
      conn = get(conn, Routes.user_post_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      %{id: user_id} = create_test_user()
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

    test "renders errors when data is invalid", %{conn: conn} do
      %{id: user_id} = create_test_user()
      conn = post(conn, Routes.user_post_path(conn, :create, user_id), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      %{user_id: user_id} = post
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

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      %{user_id: user_id} = post
      conn = put(conn, Routes.user_post_path(conn, :update, user_id, post), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: %Post{id: post_id} = post} do
      %{user_id: user_id} = post
      conn = delete(conn, Routes.user_post_path(conn, :delete, user_id, post))
      assert response(conn, 204)

      conn = get(conn, Routes.user_post_path(conn, :show, user_id, post_id))
      assert response(conn, 404)
    end
  end

  defp create_post(_) do
    post = create_test_post()
    %{post: post}
  end
end
