defmodule ApiWeb.AccountView do
  use ApiWeb, :view
  alias ApiWeb.AccountView
  alias ApiWeb.UserView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      email: account.email,
      user: render_one(account.user, UserView, "user.json")
    }
  end
end
