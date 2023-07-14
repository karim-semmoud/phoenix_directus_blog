defmodule Directus do
  use HTTPoison.Base
  require Logger

  def process_request_url(url) do
    "http://0.0.0.0:8055/items" <> url
  end

  def process_response_body(body) do
    try do
      Jason.decode!(body)
    rescue
      _ -> body
    end
  end

  def handle({:ok, %{status_code: code, body: body}}) when code in 200..201, do: body
  def handle({:ok, %{status_code: 400, body: body}}), do: log(body)
  def handle({:ok, %{status_code: code, body: %{"Message" => message}}}) when code > 400, do: log(message)
  def handle({:ok, %{status_code: code, body: body}}) when code > 400, do: log(body)
  def handle({:error, %{reason: reason}}) when is_tuple(reason), do: log(elem(reason, 1))
  def handle({:error, %{reason: reason}}), do: log(reason)

  defp log(message) do
    Logger.info(fn -> "Directus: #{message}" end)
    %{}
  end

end
