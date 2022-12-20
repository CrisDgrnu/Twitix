defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :hash_password, :string
      add :full_name, :string
      add :gender, :string
      add :biography, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
