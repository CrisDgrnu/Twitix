defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("400.json", _assigns) do
    %{errors: %{detail: "Malformed Body", code: 400}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error", code: 500}}
  end
end
