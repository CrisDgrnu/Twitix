defmodule Test.AuthFixtures do
  use ApiWeb.ConnCase
  alias ApiWeb.Auth.Guardian
  import Test.UsersFixtures

  def setup_auth_connection(conn) do
    {email, password} = get_user_credentials()
    {:ok, token} = Guardian.authenticate(email, password)

    conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Bearer #{token}")
  end
end
