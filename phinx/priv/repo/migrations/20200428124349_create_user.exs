defmodule Phinx.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :email, :string
      add :password, :binary

      # inserted_at and updated_at
      timestamps
    end
  end
end
