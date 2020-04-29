defmodule Phinx.Users.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    field :email, :string
    field :password, Phinx.Encrypted.Binary

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :email])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
