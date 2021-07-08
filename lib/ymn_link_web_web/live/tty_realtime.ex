defmodule YmnLinkWebWeb.TtyRealtime do
  use Phoenix.LiveView

  def render(assigns) do
      ~L"""
        <script>
          function st(){
            var hoge = document.getElementById("hoge");
            hoge.click();
            setTimeout("st()", 100);
          }
        </script>

         <form>
         <input type="button" phx-hook="Hoge" id="hoge" style="display:none" >
         <input type="button"  value="Start" onclick="st()">
        </form>
        <%= for result <- @results do %>
          <%= result[:abc] %><br>
        <% end %>
    """
  end

  def mount(_params, _session, socket) do
    { :ok, assign(socket, results: [])}
  end
  def handle_event("change", %{"v" => v }, socket ) do
    send(self(), {:submit, v})
    {:noreply, assign(socket, v: v)}
  end
  def handle_info( {:submit, v}, socket ) do
    t = Tty.send("a0;")
    results = [%{abc: t}, %{abc: DateTime.utc_now}]
    { :noreply, assign(socket, results: results)}
  end

  def handle_event("hoge", %{"v" => v}, socket ) do
    send(self(), {:submit, v})
    {:noreply, assign(socket, v: v)}
  end
end
