defmodule YmnLinkWebTest do
  use ExUnit.Case
  doctest YmnLinkWeb

  test "greets the world" do
    assert YmnLinkWeb.hello() == :world
  end
end
