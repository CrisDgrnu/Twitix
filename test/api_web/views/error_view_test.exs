defmodule ApiWeb.ErrorViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json" do
    expected_response = %{errors: %{detail: "Element not found", code: 404}}
    assert render(ApiWeb.ErrorView, "404.json", []) == expected_response
  end

  test "renders 500.json" do
    expected_response = %{errors: %{detail: "Internal Server Error", code: 500}}
    assert render(ApiWeb.ErrorView, "500.json", []) == expected_response
  end
end
