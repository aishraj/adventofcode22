defmodule Adventofcode22.DaythirteenTest do
  use ExUnit.Case

  # test "part 1 easy" do
  #   input = File.read!("input/13_easy.txt") |> String.split("\n\n", trim: true)
  #   assert Adventofcode22.Daythirteen.part_one(input) == 13
  # end

  test "runs comparision correctly" do
    one = [[1], [2, 3, 4]]
    other = [[1], 4]
    assert Adventofcode22.Daythirteen.compare_lists(one, other) == :lt
  end
end
