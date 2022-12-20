defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase
  import Api.UsersFixtures
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
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
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
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      expected_response_body = %{
        "id" => id,
        "biography" => "some updated biography",
        "full_name" => "some updated full_name",
        "gender" => "female"
      }

      assert expected_response_body = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert response(conn, 404)
    end
  end

  defp create_user(_) do
    user = create_test_user()
    %{user: user}
  end
end
