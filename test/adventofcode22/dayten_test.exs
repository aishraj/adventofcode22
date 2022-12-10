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

    assert result == {-1, 6, []}
  end

  test "returns signal strengths for a test file" do
    data = Adventofcode22.Dayten.read_file("input/10_easy.txt")
    {_, _, result} = Adventofcode22.Dayten.signal_strengths(data, [20, 60, 100, 140, 180, 220])
    assert result == [420, 1140, 1800, 2940, 2880, 3960]
  end
end
