defmodule Adventofcode22.DayelevenTest do
  use ExUnit.Case

  test "works on part one easy" do
    data = File.read!("input/11_easy.txt") |> String.split("\n\n", trim: true)
    assert Adventofcode22.Dayeleven.part_one(data) == 10605
  end

  test "works on part two easy" do
    data = File.read!("input/11_easy.txt") |> String.split("\n\n", trim: true)
    assert Adventofcode22.Dayeleven.part_two(data) == 2_713_310_158
  end

  test "works on part two regular" do
    data = File.read!("input/11.txt") |> String.split("\n\n", trim: true)
    assert Adventofcode22.Dayeleven.part_two(data) == 20_567_144_694
  end

  test "works on part one real" do
    data = File.read!("input/11.txt") |> String.split("\n\n", trim: true)
    assert Adventofcode22.Dayeleven.part_one(data) == 61005
  end
end
