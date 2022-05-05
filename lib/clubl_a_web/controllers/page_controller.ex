defmodule ClubLAWeb.PageController do
  use ClubLAWeb, :controller

  def landing_page(conn, _params) do
    render(conn)
  end
end
