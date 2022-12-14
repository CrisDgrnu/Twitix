defmodule ApiWeb.AccountController do
  use ApiWeb, :controller

  alias Api.Accounts.Services.AccountCrud
  alias Api.Accounts.Model.Account

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    accounts = AccountCrud.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- AccountCrud.create_account(account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = AccountCrud.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = AccountCrud.get_account!(id)

    with {:ok, %Account{} = account} <- AccountCrud.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = AccountCrud.get_account!(id)

    with {:ok, %Account{}} <- AccountCrud.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
