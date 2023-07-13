defmodule PhoenixDirectusBlog.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_directus_blog,
    adapter: Ecto.Adapters.Postgres
end
