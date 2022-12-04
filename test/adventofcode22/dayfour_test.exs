defmodule Adventofcode22.DayfourTest do
  use ExUnit.Case

  test "part one easy" do
    data = Adventofcode22.Dayfour.read_input("input/4_easy.txt")

    result = Adventofcode22.Dayfour.part_one(data)
    assert result == 2
  end

  test "part two easy" do
    data = Adventofcode22.Dayfour.read_input("input/4_easy.txt")

    result = Adventofcode22.Dayfour.part_two(data)
    assert result == 4
  end

  test "part one" do
    data = Adventofcode22.Dayfour.read_input("input/4.txt")

    result = Adventofcode22.Dayfour.part_one(data)
    assert result == 413
  end

  test "part two" do
    data = Adventofcode22.Dayfour.read_input("input/4.txt")

    result = Adventofcode22.Dayfour.part_two(data)
    assert result == 806
  end

  test "finds overlap" do
    input = ["2-8", "3-7"]
    result = Adventofcode22.Dayfour.find_overlap(input)
    assert result == true
  end

  test "finds any overlap" do
    input = ["5-7", "5-9"]
    result = Adventofcode22.Dayfour.find_any_overlap(input)
    assert result == true
  end
end
