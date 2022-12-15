defmodule Adventofcode22.DayfourteenTest do
 use ExUnit.Case

#  test "reads the input correctly" do
#    raw_data = File.read!("input/14_easy.txt")
#    |> String.trim()
#    |> String.split("\n")
#    result = Adventofcode22.Dayfourteen.parse_input(raw_data)
#    assert result == MapSet.new([{494, 9}, {495, 9}, {496, 6}, {496, 9}, {497, 6}, {497, 9}, {498, 4}, {498, 5}, {498, 6}, {498, 9}, {499, 9}, {500, 9}, {501, 9}, {502, 4}, {502, 5}, {502, 6}, {502, 7}, {502, 8}, {502, 9}, {503, 4}])
#  end

 test "part 1 easy" do
    result = Adventofcode22.Dayfourteen.parse_input("input/14_easy.txt")
    assert Adventofcode22.Dayfourteen.part_one(result) == 24
 end

 test "part 1" do
  result = Adventofcode22.Dayfourteen.parse_input("input/14.txt")
  assert Adventofcode22.Dayfourteen.part_one(result) == 1001
end


test "part 2" do
  result = Adventofcode22.Dayfourteen.parse_input("input/14.txt")
  assert Adventofcode22.Dayfourteen.part_two(result) == 27976
end

test "part 2 easy" do
  result = Adventofcode22.Dayfourteen.parse_input("input/14_easy.txt")
  assert Adventofcode22.Dayfourteen.part_two(result) == 93
end

end
