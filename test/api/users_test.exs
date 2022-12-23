defmodule Api.UsersTest do
  use Api.DataCase

  alias Api.Users.Services.UserCrud

  describe "users" do
    alias Api.Users.Model.User

    import Test.UsersFixtures

    @invalid_attrs %{biography: nil, full_name: nil, gender: "invalid gender"}

    test "list_users/0 returns all users" do
      user = create_test_user()
      assert UserCrud.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = create_test_user()
      assert UserCrud.get_user(user.id) == user
    end

    test "get_user_by_email/1 returns the user with given email" do
      user = create_test_user()
      assert UserCrud.get_user_by_email(user.email) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        biography: "some biography",
        full_name: "some full_name",
        gender: :male
      }

      assert {:ok, %User{} = user} = UserCrud.create_user(valid_attrs)
      assert user.biography == "some biography"
      assert user.full_name == "some full_name"
      assert user.gender == :male
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserCrud.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = create_test_user()

      update_attrs = %{
        biography: "some updated biography",
        full_name: "some updated full_name",
        gender: :female
      }

      assert {:ok, %User{} = user} = UserCrud.update_user(user.id, update_attrs)
      assert user.biography == "some updated biography"
      assert user.full_name == "some updated full_name"
      assert user.gender == :female
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = create_test_user()
      assert {:error, %Ecto.Changeset{}} = UserCrud.update_user(user.id, @invalid_attrs)
      assert user == UserCrud.get_user(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = create_test_user()
      assert {:ok, %User{}} = UserCrud.delete_user(user.id)
      assert nil == UserCrud.get_user(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = create_test_user()
      assert %Ecto.Changeset{} = UserCrud.change_user(user)
    end
  end
end
