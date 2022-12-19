defmodule Api.Accounts.Services.AccountCrud do
  import Ecto.Query, warn: false

  alias Api.Repo
  alias Api.Accounts.Model.Account

  def list_accounts do
    Repo.all(Account)
  end

  def get_account(id), do: Repo.get(Account, id)

  def get_account_by_email(email) do
    Account
    |> where(email: ^email)
    |> Repo.one()
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def update_account(id, attrs) do
    case get_account(id) do
      nil -> {:error, :not_found}
      account -> account |> Account.changeset(attrs) |> Repo.update()
    end
  end

  def delete_account(id) do
    case get_account(id) do
      nil -> {:error, :not_found}
      account -> Repo.delete(account)
    end
  end

  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
