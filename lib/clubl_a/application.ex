defmodule ClubLA.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ClubLA.Repo,
      # Start the Telemetry supervisor
      ClubLAWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClubLA.PubSub},
      # Start the Endpoint (http/https)
      ClubLAWeb.Endpoint,
      {Task.Supervisor, name: ClubLA.BackgroundTask},
      {Oban, oban_config()}
      # Start a worker by calling: ClubLA.Worker.start_link(arg)
      # {ClubLA.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClubLA.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClubLAWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable queues or plugins here.
  defp oban_config do
    Application.fetch_env!(:clubl_a, Oban)
  end
end
