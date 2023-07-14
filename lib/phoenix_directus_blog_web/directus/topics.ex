defmodule Directus.Topics do
  import Directus

  def all(), do: "/topics" |> get() |> handle()
  def byid(topic_id), do: "/topics/#{topic_id}" |> get() |> handle()

end
