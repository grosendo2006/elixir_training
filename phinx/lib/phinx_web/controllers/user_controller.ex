defmodule PhinxWeb.UserController do
  use PhinxWeb, :controller
  alias Phinx.Users

  def index(conn, _params) do
    # HTTP Method: GET
    users = Users.list()

    conn
    |> render("index.json", users: users)
  end

  def create(conn, %{"user" => user}) do
    with {:ok, new_user} <- Users.create(user) do
      conn
      |> put_status(:created)
      |> render("user.json", user: new_user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get(id) do
      conn
      |> render("user.json", user: user)
    end
  end

  # %{"id" => id, "user" -> user}
  def update(conn, %{"id" => id, "user" => attrs}) do
    with {:ok, user} <- Users.get(id),
         {:ok, user} <- Users.update(user, attrs) do
      conn
      |> send_resp(:no_content, "")
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get(id) do
      Users.delete(user)
      send_resp(conn, :no_content, "")
    end
  end

  def hack(conn, %{"user_id" => user_id}) do
    with {:ok, user} <- Users.get(user_id) do
      conn
      |> render("hack.json", user: user)
    end
  end
end
