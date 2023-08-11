defmodule PropertyManagementSystem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PropertyManagementSystem.Repo,
      # Start the Telemetry supervisor
      PropertyManagementSystemWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PropertyManagementSystem.PubSub},
      # Start the Endpoint (http/https)
      PropertyManagementSystemWeb.Endpoint
      # Start a worker by calling: PropertyManagementSystem.Worker.start_link(arg)
      # {PropertyManagementSystem.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PropertyManagementSystem.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PropertyManagementSystemWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
