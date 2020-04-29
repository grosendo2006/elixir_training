defmodule Phinx.Users do
  @moduledoc """
  Users Context
  """
  alias Phinx.Users.Schema.User
  alias Phinx.Repo
  use Cloak.Ecto.Binary, vault: Phinx.Vault

  def list do
    User
    |> Repo.all()
  end

  def get(id) do
    case user = Repo.get(User, id) do
      %User{} -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end

  def create(attrs) do
    user =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    case user do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update(%User{} = user, attrs) do
    user =
      user
      |> User.changeset(attrs)
      |> Repo.update()

    case user do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete(user) do
    # DB Connection
    # TODO: FK, relaciones, etc

    user
    |> Repo.delete()
  end

end
