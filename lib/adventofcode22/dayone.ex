defmodule Adventofcode22.DayOne do
  def part_one(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce(1, &(&1 * &2))
  end
end
