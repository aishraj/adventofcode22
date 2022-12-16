defmodule Adventofcode22.DayfifteenTest do
  use ExUnit.Case

  test "parses a line" do
    line = "Sensor at x=2, y=18: closest beacon is at x=-2, y=15"
    assert Adventofcode22.Dayfifteen.parse_line(line) == [{2, 18}, {-2, 15}]
  end

  test "returns all points in manhattan distance" do
    assert Adventofcode22.Dayfifteen.points_in_manhattan_distance({0, 0}, 1) == [
             {-1, 0},
             {0, -1},
             {0, 1},
             {1, 0}
           ]

    assert Adventofcode22.Dayfifteen.points_in_manhattan_distance({0, 0}, 2) == [
             {-2, 0},
             {-1, -1},
             {-1, 1},
             {0, -2},
             {0, 2},
             {1, -1},
             {1, 1},
             {2, 0}
           ]
  end

  test "for easy input" do
    raw_data = File.read!("input/15_easy.txt")
    parsed_input = Adventofcode22.Dayfifteen.parse_input(raw_data)
    result = Adventofcode22.Dayfifteen.part_one(parsed_input)
    assert result == 26
  end
end
