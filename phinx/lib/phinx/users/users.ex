defmodule Phinx.Users do
  @moduledoc """
  Users Context
  """
  alias Phinx.Users.Schema.User
  alias Phinx.Repo
  use Cloak.Ecto.Binary, vault: Phinx.Vault

  @doc """
  List all users.
  """
  def list do
    User
    |> Repo.all()
  end

  @doc """
  Return user with id = id.
  """
  def get(id) do
    case user = Repo.get(User, id) do
      %User{} -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end

  @doc """
  Create new user with attrs.
  """
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

  @doc """
  Update user attr with id=id.
  """
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

  @doc """
  Delete user with id=id.
  """
  def delete(user) do
    user
    |> Repo.delete()
  end

end
