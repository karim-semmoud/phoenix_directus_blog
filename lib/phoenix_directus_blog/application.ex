defmodule PhoenixDirectusBlog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixDirectusBlogWeb.Telemetry,
      # Start the Ecto repository
      PhoenixDirectusBlog.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixDirectusBlog.PubSub},
      # Start Finch
      {Finch, name: PhoenixDirectusBlog.Finch},
      {Cachex, name: :my_cache_directus},
      # Start the Endpoint (http/https)
      PhoenixDirectusBlogWeb.Endpoint
      # Start a worker by calling: PhoenixDirectusBlog.Worker.start_link(arg)
      # {PhoenixDirectusBlog.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixDirectusBlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixDirectusBlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
