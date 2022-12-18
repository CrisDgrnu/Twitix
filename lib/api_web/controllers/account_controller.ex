defmodule ApiWeb.AccountController do
  use ApiWeb, :controller

  alias Api.Accounts.Services.AccountCrud

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    accounts = AccountCrud.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, account} <- AccountCrud.create_account(account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    case AccountCrud.get_account(id) do
      nil -> {:error, :not_found}
      account -> conn |> put_status(:ok) |> render("show.json", account: account)
    end
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    case AccountCrud.update_account(id, account_params) do
      {:ok, updated_account} -> render(conn, "show.json", account: updated_account)
      {:error, code} -> {:error, code}
    end
  end

  def delete(conn, %{"id" => id}) do
    case AccountCrud.delete_account(id) do
      {:ok, _} -> send_resp(conn, :no_content, "")
      {:error, code} -> {:error, code}
    end
  end
end
