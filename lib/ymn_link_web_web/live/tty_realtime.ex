defmodule YmnLinkWebWeb.TtyRealtime do
  use YmnLinkWebWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    { :ok, assign(socket, results: [])}
  end

  @impl true
  def handle_event("change", %{"v" => v }, socket ) do
    send(self(), {:submit, v})
    {:noreply, assign(socket, v: v)}
  end

  @impl true
  def handle_info( {:submit, v}, socket ) do
    t = Tty.send("z;")
    results = [%{abc: t}, %{abc: DateTime.utc_now}]
    { :noreply, assign(socket, results: results)}
  end

  @imple true
  def handle_event("hoge", %{"v" => v}, socket ) do
    send(self(), {:submit, v})
    {:noreply, assign(socket, v: v)}
  end
end
