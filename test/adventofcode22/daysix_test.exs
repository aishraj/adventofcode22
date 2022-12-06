defmodule Adventofcode22.DaysixTest do
  use ExUnit.Case

  test "solves part 1" do
    data =
      File.read!("input/6.txt")
      |> String.trim()

    assert Adventofcode22.Daysix.part_one(data) == 1134
  end

  test "solves part 2" do
    data =
      File.read!("input/6.txt")
      |> String.trim()

    assert Adventofcode22.Daysix.part_two(data) == 2263
  end

  test "solves part 1 easy 1" do
    assert Adventofcode22.Daysix.part_one("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
  end

  test "solves part 1 easy others" do
    assert Adventofcode22.Daysix.part_one("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert Adventofcode22.Daysix.part_one("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert Adventofcode22.Daysix.part_one("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert Adventofcode22.Daysix.part_one("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end
end
