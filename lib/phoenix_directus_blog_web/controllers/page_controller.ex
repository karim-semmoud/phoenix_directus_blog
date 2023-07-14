defmodule PhoenixDirectusBlogWeb.PageController do
  use PhoenixDirectusBlogWeb, :controller

  def home(conn, _params) do

    conn
    |> PhoenixDirectusBlogWeb.TopicsController.list_all_topics(conn)
    |> PhoenixDirectusBlogWeb.ArticlesController.list_all_articles(conn)
    |> render(:home)
  end

end
