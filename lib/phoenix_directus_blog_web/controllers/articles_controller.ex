defmodule PhoenixDirectusBlogWeb.ArticlesController do
  use PhoenixDirectusBlogWeb, :controller
  require Directus.Articles
  require Logger
  require Cachex

  def show(conn, %{"id" => article_id}) do
    result = Directus.Articles.byid(article_id)

    article = Map.get(result, "data", %{})

    Logger.info("Article: #{inspect(article)}")

    full_title = Map.get(article, "full_title")
    detailed_description = Map.get(article, "detailed_description")
    article_body = Map.get(article, "article_body")
    topics = Map.get(article, "topics", [])
    image = Map.get(article, "image")

    conn
    |> assign(:full_title, full_title)
    |> assign(:detailed_description, detailed_description)
    |> assign(:article_body, article_body)
    |> assign(:topics, topics)
    |> assign(:image, image)
    |> render(:show)
  end




  def list_all_articles(conn, _params) do
    result = Directus.Articles.all()
    articles = Enum.map(result["data"], fn entry ->
      %{
        id: Map.get(entry, "id"),
        full_title: Map.get(entry, "full_title"),
        detailed_description: Map.get(entry, "detailed_description"),
        image: Map.get(entry, "image", "image")

        # Add more fields here
      }
    end)
    Logger.info("Articles: #{inspect(articles)}")
    Cachex.put(:my_cache_directus, "articles", articles)
    articles_cached = Cachex.get!(:my_cache_directus, "articles")
    Logger.info("Articles Cached: #{inspect(articles_cached)}")

    conn
    |> assign(:articles, articles)
  end


end
