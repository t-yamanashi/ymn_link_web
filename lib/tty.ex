defmodule Tty do
  @moduledoc """
  Documentation for `TTY`.
  """

  @doc """
  Send command.

  ## Examples

  """
  def send(cmd) do
    pid = getpid()
    Circuits.UART.write(pid, cmd)
    :timer.sleep(100)
    {:ok, ret} = Circuits.UART.read(pid, 10)
    ret
  end

  def open do
    {:ok, pid} = Circuits.UART.start_link
    Circuits.UART.open(pid, "/dev/ttyACM0", speed: 115200, active: false)
  end

  def getpid do
    [{pid, _dev}] = Circuits.UART.find_pids
    pid
  end
  
end

