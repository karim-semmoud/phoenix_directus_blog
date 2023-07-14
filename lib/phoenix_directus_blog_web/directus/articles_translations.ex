defmodule Directus.ArticlesTranslations do
  import Directus

  def all(), do: "/articles_translations" |> get() |> handle()
  def byid(id), do: "/articles_translations/#{id}" |> get() |> handle()

end
