defmodule Adventofcode22.DayfifteenTest do
  use ExUnit.Case

  test "parses a line" do
    line = "Sensor at x=2, y=18: closest beacon is at x=-2, y=15"
    assert Adventofcode22.Dayfifteen.parse_line(line) == [{2, 18}, {-2, 15}]
  end

  test "for easy input" do
    raw_data = File.read!("input/15_easy.txt")
    parsed_input = Adventofcode22.Dayfifteen.parse_input(raw_data)
    result = Adventofcode22.Dayfifteen.part_one(parsed_input, 10)
    assert result == 26
  end

  @tag :skip
  test "for real input" do
    raw_data = File.read!("input/15.txt")
    parsed_input = Adventofcode22.Dayfifteen.parse_input(raw_data)
    result = Adventofcode22.Dayfifteen.part_one(parsed_input, 2_000_000)
    assert result == 5_083_287
  end
end
