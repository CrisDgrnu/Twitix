defmodule ApiWeb.LoginView do
  use ApiWeb, :view
  alias ApiWeb.LoginView

  def render("show.json", %{token: token}) do
    %{data: render_one(token, LoginView, "credentials.json", as: :token)}
  end

  def render("credentials.json", %{token: token}) do
    %{token: token}
  end
end
