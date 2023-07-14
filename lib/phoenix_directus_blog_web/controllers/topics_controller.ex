defmodule PhoenixDirectusBlogWeb.TopicsController do
  use PhoenixDirectusBlogWeb, :controller
  require Directus.Topics
  require Logger
  require Cachex

  def list_all_topics(conn, _params) do
    result = Directus.Topics.all()
    topics = Enum.map(result["data"], &(&1["name"]))
    Logger.info("Topics: #{inspect(topics)}")
    Cachex.put(:my_cache_directus, "topics", topics)
    topics_cached = Cachex.get!(:my_cache_directus, "topics")
    Logger.info("Topics Cached: #{inspect(topics_cached)}")

    conn
    |> assign(:topics, topics)
  end
end
