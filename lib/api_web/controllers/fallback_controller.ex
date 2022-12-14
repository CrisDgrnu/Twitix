defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
