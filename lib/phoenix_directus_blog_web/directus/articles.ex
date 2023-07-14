defmodule Directus.Articles do
  import Directus

  def all(), do: "/articles" |> get() |> handle()
  def byid(article_id), do: "/articles/#{article_id}" |> get() |> handle()

end
