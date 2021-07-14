defmodule YmnLinkWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Tty.open()
    children = [
      # Start the Telemetry supervisor
      YmnLinkWebWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: YmnLinkWeb.PubSub},
      # Start the Endpoint (http/https)
      YmnLinkWebWeb.Endpoint
      # Start a worker by calling: YmnLinkWeb.Worker.start_link(arg)
      # {YmnLinkWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YmnLinkWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    YmnLinkWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
