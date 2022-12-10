defmodule Adventofcode22.DayeightTest do
  use ExUnit.Case

  test "parses into a nested map" do
    data = Adventofcode22.Dayeight.read_file("input/8_easy.txt")

    assert data == %{
             0 => %{0 => "3", 1 => "0", 2 => "3", 3 => "7", 4 => "3"},
             1 => %{0 => "2", 1 => "5", 2 => "5", 3 => "1", 4 => "2"},
             2 => %{0 => "6", 1 => "5", 2 => "3", 3 => "3", 4 => "2"},
             3 => %{0 => "3", 1 => "3", 2 => "5", 3 => "4", 4 => "9"},
             4 => %{0 => "3", 1 => "5", 2 => "3", 3 => "9", 4 => "0"}
           }
  end

  test "part one easy" do
    data = Adventofcode22.Dayeight.read_file("input/8_easy.txt")
    res = Adventofcode22.Dayeight.part_one(data)
    assert res == 21
  end

  @tag :skip
  test "part one regular" do
    data = Adventofcode22.Dayeight.read_file("input/8.txt")
    res = Adventofcode22.Dayeight.part_one(data)
    assert res == 1803
  end

  test "part two easy" do
    data = Adventofcode22.Dayeight.read_file("input/8_easy.txt")
    res = Adventofcode22.Dayeight.part_two(data)
    assert res == 8
  end

  @tag :skip
  test "part two regular" do
    data = Adventofcode22.Dayeight.read_file("input/8.txt")
    res = Adventofcode22.Dayeight.part_two(data)
    assert res == 268_912
  end
end
