defmodule PhoenixDirectusBlogWeb.ArticlesController do
  use PhoenixDirectusBlogWeb, :controller
  require Directus.Articles
  require Directus.ArticlesTranslations
  require Logger
  require Cachex

  def show(conn, %{"id" => article_id}) do
    result = Directus.Articles.byid(article_id)

    article = Map.get(result, "data", %{})

    full_title = Map.get(article, "full_title")
    detailed_description = Map.get(article, "detailed_description")
    article_body = Map.get(article, "article_body")
    topics = Map.get(article, "topics", [])
    image = Map.get(article, "image")
    translations_id = Map.get(article, "translations")
    Logger.info("translation id: #{inspect(translations_id)}")
    translations = PhoenixDirectusBlogWeb.ArticlesController.list_translations(translations_id)

    conn

    |> assign(:full_title, full_title)
    |> assign(:detailed_description, detailed_description)
    |> assign(:article_body, article_body)
    |> assign(:topics, topics)
    |> assign(:image, image)
    |> assign(:translations_id, translations_id)
    |> assign(:translations, translations)

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

    conn
    |> assign(:articles, articles)
  end

  def list_translations(translations_id) do
    result = Directus.ArticlesTranslations.all()
    Logger.info("translation: #{inspect(result)}")
    translations = Enum.map(result["data"], fn entry ->
      %{
        id: Map.get(entry, "id"),
        full_title: Map.get(entry, "full_title"),
        detailed_description: Map.get(entry, "detailed_description")
        # Add more fields here
      }
    end)

  end


end
