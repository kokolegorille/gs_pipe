defmodule GsPipeTest do
  use ExUnit.Case
  doctest GsPipe

  test "greets the world" do
    assert GsPipe.hello() == :world
  end
end
