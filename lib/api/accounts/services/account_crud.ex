defmodule Api.Accounts.Services.AccountCrud do
  import Ecto.Query, warn: false

  alias Api.Repo
  alias Api.Accounts.Model.Account

  def list_accounts do
    Account
    |> Repo.all()
    |> IO.inspect()
  end

  def get_account!(id), do: Account |> Repo.get!(id)

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

  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  def delete_account(%Account{} = account) do
    account |> Repo.delete()
  end

  def change_account(%Account{} = account, attrs \\ %{}) do
    account |> Account.changeset(attrs)
  end
end
