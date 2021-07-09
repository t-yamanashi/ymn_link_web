defmodule YmnLinkWebWeb.TtyRealtime do
  use YmnLinkWebWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
   val = "00000000000000"
   if connected?(socket) do
      Process.send_after(self(), {:tick, val}, 50)
   end
    { :ok, assign(socket, results: [], val: val)}
  end

  @impl true
  def handle_info({:tick, val}, socket ) do
    Process.send_after(self(), {:tick, val}, 50)
    #val = "000000000000000"
    results = Tty.send("z;")
              |> String.split(",")
              |> Enum.map(fn(x) -> create_data(x) end)
    { :noreply, assign(socket, results: results, val: val)}
  end

  @impl true
  def handle_event("setdata", %{"val" => val}, socket ) do
    cmd = if String.length(val) == 14 do
      "x" <> val <> ";"
    else 
      "z;"
    end
    results = Tty.send(cmd)
              |> String.split(",")
              |> Enum.map(fn(x) -> create_data(x) end)
    {:noreply, assign(socket, results: results, val: val)}
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
