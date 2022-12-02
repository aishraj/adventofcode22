defmodule Adventofcode22.DaytwoTest do
  alias Mix.Tasks.Iex
  use ExUnit.Case
  doctest Adventofcode22

  test "part one easy" do
    data = [["A", "Y"], ["B", "X"], ["C", "Z"]]
    result = Adventofcode22.Daytwo.part_one(data)
    assert result == 15
  end

  # test "part two easy" do
  #   data = ["2"]
  #   result = Adventofcode22.DayOne.part_two(data)
  #   assert result == 2
  # end

  test "part one" do
    ## Test runners should read the input from a file
    data =
      Adventofcode22.Daytwo.read_file("input/2.txt")
      |> Enum.to_list()

    result = Adventofcode22.Daytwo.part_one(data)
    assert result == 69626
  end

  # test "part two" do
  #   data =
  #     Adventofcode22.DayOne.read_input("input/1.txt")
  #     |> Enum.to_list()

  #   result = Adventofcode22.DayOne.part_two(data)
  #   assert result == 206_780
  # end
end
