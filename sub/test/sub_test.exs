defmodule SubTest do
  use ExUnit.Case
  doctest Sub

  test "greets the world" do
    assert Sub.hello() == :world
  end
end
