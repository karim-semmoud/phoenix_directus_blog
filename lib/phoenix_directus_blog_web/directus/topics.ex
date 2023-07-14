defmodule Directus.Topics do
  import Directus

  def all(), do: "/topics" |> get() |> handle()
  def byid(id), do: "/topics/#{id}" |> get() |> handle()

end
