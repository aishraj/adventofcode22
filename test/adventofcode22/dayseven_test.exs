defmodule Adventofcode22.DaysevenTest do
  use ExUnit.Case

  test "part one easy" do
    data = Adventofcode22.Dayseven.read_file("input/7_easy.txt")
    res = Adventofcode22.Dayseven.part_one(data)
    assert res == 95437
  end

  test "part one regular" do
    data = Adventofcode22.Dayseven.read_file("input/7.txt")
    res = Adventofcode22.Dayseven.part_one(data)
    assert res == 1_077_191
  end

  test "part two easy" do
    data = Adventofcode22.Dayseven.read_file("input/7_easy.txt")
    res = Adventofcode22.Dayseven.part_two(data)
    assert res == 24_933_642
  end

  test "part two regular" do
    data = Adventofcode22.Dayseven.read_file("input/7.txt")
    res = Adventofcode22.Dayseven.part_two(data)
    assert res == 5_649_896
  end
end
