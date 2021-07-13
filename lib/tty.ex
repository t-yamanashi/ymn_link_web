defmodule Tty do
  @moduledoc """
  Documentation for `TTY`.
  """

  @doc """
  Send command.

  ## Examples

  """
  def send(cmd) do
    pid = open()
    Circuits.UART.write(pid, cmd)
    :timer.sleep(100)
    {:ok, ret} = Circuits.UART.read(pid, 10)
    #Circuits.UART.close(pid)
    #Circuits.UART.stop(pid)
    ret
  end

  def open do
    pids = Circuits.UART.find_pids
    if pids == [] do
      Process.flag(:trap_exit, true)
      {:ok, pid} = Circuits.UART.start_link
      Circuits.UART.open(pid, "/dev/ttyACM0", speed: 115200, active: false)
      pid
    else
      [{pid, _dev}] = pids
      pid
    end
  end
  
end

