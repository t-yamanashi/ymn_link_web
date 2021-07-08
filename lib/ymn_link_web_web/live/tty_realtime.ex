defmodule YmnLinkWebWeb.TtyRealtime do
  use YmnLinkWebWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 50)
    end
    { :ok, assign(socket, results: [])}
  end

  @impl true
  def handle_info(:tick, socket ) do
    Process.send_after(self(), :tick, 50)
    t = Tty.send("z;")
    results = [%{value: t}, %{value: DateTime.utc_now}]
    { :noreply, assign(socket, results: results)}
  end

end
