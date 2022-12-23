defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase
  import Test.{UsersFixtures, AuthFixtures}
  alias Api.Users.Model.User

  @create_attrs %{
    biography: "some biography",
    full_name: "some full_name",
    gender: :male
  }

  @update_attrs %{
    biography: "some updated biography",
    full_name: "some updated full_name",
    gender: :female
  }

  @invalid_attrs %{biography: nil, full_name: nil, gender: "invalid gender"}

  setup %{conn: conn} do
    %{id: user_id} = create_test_user()
    {:ok, conn: setup_auth_connection(conn), user_id: user_id}
  end

  describe "index" do
    test "lists all users", %{conn: conn, user_id: user_id} do
      conn = get(conn, Routes.user_path(conn, :index))
      data = json_response(conn, 200)["data"]

      assert is_list(data)
      assert List.first(data)["id"] == user_id
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      expected_response_body = %{
        "id" => id,
        "biography" => "some biography",
        "full_name" => "some full_name",
        "gender" => "male"
      }

      assert expected_response_body == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    test "renders user when data is valid", %{conn: conn, user_id: user_id} do
      user = get_user(user_id)

      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^user_id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, user_id))

      expected_response_body = %{
        "id" => user_id,
        "biography" => "some updated biography",
        "full_name" => "some updated full_name",
        "gender" => "female"
      }

      assert expected_response_body == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_id: user_id} do
      user = get_user(user_id)
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    test "deletes chosen user", %{conn: conn, user_id: user_id} do
      user = get_user(user_id)

      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert response(conn, 404)
    end
  end
end
