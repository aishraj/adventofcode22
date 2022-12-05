defmodule Adventofcode22.DayfiveTest do
  use ExUnit.Case

  test "parse a single line" do
    line = "    [S] [M] [R] [W] [M] [C]        "
    result = Adventofcode22.Dayfive.parse_line(line)
    assert result == ["", "S", "M", "R", "W", "M", "C", "", ""]
  end

  test "parses the stack grid" do
    input = File.read!("input/5_stack_easy.txt")
    result = Adventofcode22.Dayfive.parse_stack(input)
    assert result == %{1 => ["Z", "N"], 2 => ["M", "C", "D"], 3 => ["P"]}
  end
end
