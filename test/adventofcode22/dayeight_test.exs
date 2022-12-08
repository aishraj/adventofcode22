defmodule Adventofcode22.DayeightTest do
  use ExUnit.Case

  test "part one easy" do
    data = Adventofcode22.Dayeight.read_file("input/8_easy.txt")
    res = Adventofcode22.Dayeight.part_one(data)
    assert res == 1
  end
end
