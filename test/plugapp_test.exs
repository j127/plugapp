defmodule PlugappTest do
  use ExUnit.Case
  doctest Plugapp

  test "greets the world" do
    assert Plugapp.hello() == :world
  end
end
