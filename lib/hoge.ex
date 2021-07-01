defmodule Hoge do
  @moduledoc """
  Documentation for `Hoge`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hoge.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule SimpleQueue do
  use GenServer

  ### GenServer API

  @doc """
  GenServer.init/1コールバック
  """
  def init(state), do: {:ok, state}

  @doc """
  GenServer.handle_call/3コールバック
  """
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  ### クライアント側API / ヘルパー関数

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
