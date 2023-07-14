defmodule PhoenixDirectusBlogWeb.TopicsController do
  use PhoenixDirectusBlogWeb, :controller
  require Directus.Topics
  require Logger
  require Cachex

  def list_all_topics(conn, _params) do
    result = Directus.Topics.all()
    topics = Enum.map(result["data"], &(&1["name"]))
    conn
    |> assign(:topics, topics)
  end
end
