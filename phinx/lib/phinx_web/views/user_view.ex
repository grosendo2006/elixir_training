defmodule PhinxWeb.UserView do
  use PhinxWeb, :view
  alias PhinxWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", _user) do
    []
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, email: user.email}
  end

  # TODO: change this name pls
  def render("invalid.json", %{errors: errors}) do
    %{msg: render_many(errors, UserView, "invalid_schema.json")}
  end

  def render("invalid_schema.json", %{user: {key, {msg, _}}}) do
    %{key: key, msg: msg}
  end

  def render("hack.json", %{user: user}) do
    %{password: user.password}
  end
end
