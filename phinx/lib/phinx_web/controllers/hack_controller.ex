defmodule PhinxWeb.HackController do
  use PhinxWeb, :controller
  alias Phinx.Users

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get(id) do
      conn
      |> render("user.json", user: user)
    end
  end
end
