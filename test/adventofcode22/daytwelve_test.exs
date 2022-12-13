defmodule Adventofcode22.DaytwelveTest do
  use ExUnit.Case

  test "works on part one easy" do
    data = Adventofcode22.read_file_to_grid("input/12_easy.txt")
    assert Adventofcode22.Daytwelve.part_one(data) == 31
  end

  @tag :skip
  test "works on part two easy" do
    data = Adventofcode22.read_file_to_grid("input/12_easy.txt")
    assert Adventofcode22.Daytwelve.part_two(data) == 29
  end

  @tag :skip
  test "works on part two" do
    data = Adventofcode22.read_file_to_grid("input/12.txt")
    assert Adventofcode22.Daytwelve.part_two(data) == 459
  end

  test "works on part one" do
    data = Adventofcode22.read_file_to_grid("input/12.txt")
    assert Adventofcode22.Daytwelve.part_one(data) == 468
  end
end
