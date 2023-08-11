defmodule PropertyManagementSystemWeb.PageController do
  use PropertyManagementSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
