defmodule LmEvalTest do
  use ExUnit.Case
  doctest LmEval

  test "greets the world" do
    assert LmEval.hello() == :world
  end
end
