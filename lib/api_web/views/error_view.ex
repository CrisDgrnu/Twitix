defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("400.json", _assigns) do
    %{errors: %{detail: "Malformed Body", code: 400}}
  end

  def render("401.json", _assigns) do
    %{errors: %{detail: "Unauthorized", code: 401}}
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Element not found", code: 404}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error", code: 500}}
  end
end
