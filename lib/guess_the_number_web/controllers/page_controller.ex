defmodule GuessTheNumberWeb.PageController do
  use GuessTheNumberWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
