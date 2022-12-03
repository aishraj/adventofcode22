defmodule Adventofcode22.DaythreeTest do
  use ExUnit.Case
  doctest Adventofcode22

  test "part one easy" do
    input = ["vJrwpWtwJgWrhcsFMMfFFhFp"]
    result = Adventofcode22.Daythree.part_one(input)
    assert result == 16
  end

  test "part one easy with file" do
    data =
      Adventofcode22.Daythree.read_input("input/3_easy.txt")
      |> Enum.to_list()

    result = Adventofcode22.Daythree.part_one(data)
    assert result == 157
  end

  test "part one" do
    data =
      Adventofcode22.Daythree.read_input("input/3.txt")
      |> Enum.to_list()

    result = Adventofcode22.Daythree.part_one(data)
    assert result == 8018
  end

  test "part two easy" do
    data =
      Adventofcode22.Daythree.read_input("input/3_easy.txt")
      |> Enum.to_list()

    result = Adventofcode22.Daythree.part_two(data)
    assert result == 70
  end

  test "part two" do
    data =
      Adventofcode22.Daythree.read_input("input/3.txt")
      |> Enum.to_list()

    result = Adventofcode22.Daythree.part_two(data)
    assert result == 2518
  end
end
