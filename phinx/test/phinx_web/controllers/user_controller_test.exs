defmodule PhinxWeb.UserControllerTest do
  use PhinxWeb.ConnCase

  alias Phinx.Users

  @valid_attrs %{name: "Gonza", email: "gon@za.com", password: "1234"}
  @update_attrs %{name: "Gonzalo", email: "gonza@lo.com"}
  @invalid_attrs %{name: nil, email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Users.create(@valid_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> get(Routes.user_path(conn, :index))
      assert json_response(conn, 200) == %{"data" => []}
    end
  end

  describe "create" do
    test "create user when data is valid", %{conn: conn} do
      create_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> post(Routes.user_path(conn, :create), user: @valid_attrs)

      assert %{"id" => id} = json_response(create_conn, 201)

      show_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> get( Routes.user_path(conn, :show, id))
      assert %{ "id" => id,
                "name" => "Gonza",
                "email" => "gon@za.com"
              } = json_response(show_conn, 200)
    end

    test "fallback when data is invalid", %{conn: conn} do
      conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> post(Routes.user_path(conn, :create), user: @invalid_attrs)
      assert %{"errors" => %{"detail" => "Unprocessable Entity"}} = json_response(conn, 422)
    end
  end

  describe "update" do
    setup [:create_user]

    test "update user when data is valid", %{conn: conn, user: user} do
      update_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> put(Routes.user_path(conn, :update, user), user: @update_attrs)

      show_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> get(Routes.user_path(conn, :show, user.id))
      assert %{"id" => id,
               "name" => "Gonzalo",
               "email" => "gonza@lo.com"
              } = json_response(show_conn, 200)
    end
    test "get error when data is invalid", %{conn: conn, user: user} do
      updaet_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> put(Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert %{"errors" => %{"detail" => "Unprocessable Entity"}} = json_response(updaet_conn, 422)

      show_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> get(Routes.user_path(conn, :show, user.id))
      assert %{ "id" => user.id,
                "name" => user.name,
                "email" => user.email
              } == json_response(show_conn, 200)
    end
  end

  describe "delete" do
    setup [:create_user]

    test "delete user", %{conn: conn, user: user} do
      delete_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> delete(Routes.user_path(conn, :delete, user))
      assert response(delete_conn, 204) == ""

      show_conn = conn
      |> put_req_header("x-phinx-token", System.get_env("PHINX_TOKEN"))
      |> get(Routes.user_path(conn, :show, user.id))
      assert json_response(show_conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
