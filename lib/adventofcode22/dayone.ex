defmodule Adventofcode22.DayOne do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "\n"))
  end

  def part_one(input) do
    input
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.max()
  end

  def part_two(input) do
    input
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
