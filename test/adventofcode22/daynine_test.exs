defmodule Adventofcode22.DaynineTest do
  use ExUnit.Case

  test "parsers correctly" do
    result = Adventofcode22.Daynine.read_input("input/9_easy.txt")

    assert result == [
             {{1, 0}, 4},
             {{0, 1}, 4},
             {{-1, 0}, 3},
             {{0, -1}, 1},
             {{1, 0}, 4},
             {{0, -1}, 1},
             {{-1, 0}, 5},
             {{1, 0}, 2}
           ]
  end

  test "runs part 2 correctly" do
    input = Adventofcode22.Daynine.read_input("input/9.txt")
    result = Adventofcode22.Daynine.part_two(input, 10)

    assert result == 2541
  end

  test "runs part 1 easy correctly" do
    input = Adventofcode22.Daynine.read_input("input/9_easy.txt")
    result = Adventofcode22.Daynine.part_one(input, 2)

    assert result == 13
  end

  test "runs part 1 correctly" do
    input = Adventofcode22.Daynine.read_input("input/9.txt")
    result = Adventofcode22.Daynine.part_one(input, 2)

    assert result == 6339
  end
end
