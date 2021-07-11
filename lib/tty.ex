defmodule Tty do
  @moduledoc """
  Documentation for `TTY`.
  """

  @doc """
  Send command.

  ## Examples

  """
  def send(cmd) do
    {:ok, pid} = Circuits.UART.start_link
    Circuits.UART.open(pid, "/dev/ttyUSB0", speed: 115200, active: false)
    Circuits.UART.write(pid, cmd)
    :timer.sleep(100)
    {:ok, ret} = Circuits.UART.read(pid, 10)
    Circuits.UART.close(pid)
    Circuits.UART.stop(pid)
    ret
  end
end

