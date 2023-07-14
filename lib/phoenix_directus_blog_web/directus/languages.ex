defmodule Directus.Languages do
  import Directus

  def all(), do: "/languages" |> get() |> handle()
  def byid(id), do: "/languages/#{id}" |> get() |> handle()
  def default_lang(),  do: "/languages/?filter[default][_eq]=true" |> get() |> handle()
  def other_lang(),  do: "/languages/?filter[default][_eq]=false" |> get() |> handle()

end
