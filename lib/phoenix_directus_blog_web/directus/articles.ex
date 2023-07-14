defmodule Directus.Articles do
  import Directus

  def all(), do: "/articles" |> get() |> handle()
  def byid(id), do: "/articles/#{id}" |> get() |> handle()

end
