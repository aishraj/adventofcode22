defmodule Adventofcode22.DayoneTest do
  use ExUnit.Case
  doctest Adventofcode22

  test "part one easy" do
  end

  test "part two easy" do
  end

  test "part one" do
    ## Test runners should read the input from a file
    data =
      Adventofcode22.read_input("input/1.txt")
      |> Enum.to_list()
      |> List.flatten()

    result = Adventofcode22.DayOne.part_one(data)
    assert result == 8
  end

  test "part two" do
    data =
      Adventofcode22.read_input("input/1.txt")
      |> Enum.to_list()
      |> List.flatten()

    result = Adventofcode22.DayOne.part_two(data)
    assert result == 10
  end
end
