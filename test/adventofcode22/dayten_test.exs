defmodule Adventofcode22.DaytenTest do
  use ExUnit.Case

  test "parses line to return instruction and cycle correctly" do
    line = "addx 3"
    result = Adventofcode22.Dayten.parse_line(line)
    assert result == {:addx, 3}
  end

  test "parses dummy file correctly" do
    data = "noop\naddx 3\naddx -5"
    result = Adventofcode22.Dayten.parse_file(data)

    assert result == [
             {:noop, 0},
             {:addx, 3},
             {:addx, -5}
           ]
  end

  test "returns the correct final value of x and cycle" do
    data = "noop\naddx 3\naddx -5"
    result = Adventofcode22.Dayten.parse_file(data) |> Adventofcode22.Dayten.signal_strengths([])

    assert result == {-1, 6, [], [1, 1, 1, 4, 4, -1]}
  end

  test "returns signal strengths for a test file" do
    data = Adventofcode22.Dayten.read_file("input/10_easy.txt")
    {_, _, result, _} = Adventofcode22.Dayten.signal_strengths(data, [20, 60, 100, 140, 180, 220])
    assert result == [420, 1140, 1800, 2940, 2880, 3960]
  end

  test "returns the final answer for easy file" do
    data = Adventofcode22.Dayten.read_file("input/10_easy.txt")
    assert Adventofcode22.Dayten.part_one(data) == 13140
  end

  test "returns the final answer for real file" do
    data = Adventofcode22.Dayten.read_file("input/10.txt")
    assert Adventofcode22.Dayten.part_one(data) == 17180
  end

  test "part 2 easy" do
    data = Adventofcode22.Dayten.read_file("input/10_easy.txt")
    expected = File.read!("input/10_2_expected.txt")
    assert Adventofcode22.Dayten.part_two(data) == expected
  end

  test "part 2" do
    data = Adventofcode22.Dayten.read_file("input/10.txt")
    expected = File.read!("input/10_2_real_expected.txt")
    assert Adventofcode22.Dayten.part_two(data) == expected
  end
end
