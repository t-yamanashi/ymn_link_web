defmodule YmnLinkWebWeb.TtyRealtime do
  use YmnLinkWebWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
   if connected?(socket) do
      Tty.send("z;")
      Process.send_after(self(), :tick, 2000)
   end
    { :ok, assign(socket, results: [])}
  end

  @impl true
  def handle_info(:tick, socket ) do
    Process.send_after(self(), :tick, 50)
    results = send("z;")
    { :noreply, assign(socket, results: results)}
  end

  @impl true
  def handle_event("setdata", %{"val" => val}, socket ) do
    cmd = if String.length(val) == 14 do
      "x" <> val <> ";"
    else 
      "z;"
    end
    results = send(cmd)
    {:noreply, assign(socket, results: results)}
  end

  def send(cmd) do
    Tty.send(cmd)
    |> String.split(",")
    |> Enum.map(fn(x) -> create_data(x) end)
  end

  def create_data(x) do
    {val, _} = Integer.parse(x)
    width = div(val, 3)
    %{value: x, 
      style: "width:" <> Integer.to_string(width) 
      <>  "px;background-color:" <> create_color(val) <> ";font-size:40px;"
    }
  end 

  def create_color(val) do
    cond do
      val < 600 -> "#ccccff"
      val > 600 && val < 800 -> "#ffffcc" 
      true -> "#ffcccc"  
    end
  end
end
