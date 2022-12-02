defmodule Adventofcode22.Daytwo do
  def read_file(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " "))
  end

  def part_one(input) do
    input
    |> Enum.map(fn [x, y] -> calculate_score(x, y) end)
    |> Enum.sum()
  end

  defp calculate_score(x, y) do
    a = item(x)
    b = item(y)
    result = compete(a, b)

    base = score(a)

    points = find_winner(result, a)

    base + points
  end

  defp find_winner(result, p) when result == p, do: 6
  defp find_winner(:draw, _), do: 3
  defp find_winner(result, p) when result != p, do: 0

  defp compete(:rock, :paper), do: :paper
  defp compete(:paper, :rock), do: :paper
  defp compete(:rock, :scissors), do: :rock
  defp compete(:scissors, :rock), do: :rock
  defp compete(:scissors, :paper), do: :scissors
  defp compete(:paper, :scissors), do: :scissors
  defp compete(x, x), do: :draw

  defp item("A"), do: :rock
  defp item("B"), do: :paper
  defp item("C"), do: :scissors
  defp item("X"), do: :rock
  defp item("Y"), do: :paper
  defp item("Z"), do: :scissors

  defp score(:rock), do: 1
  defp score(:paper), do: 2
  defp score(:scissors), do: 3

  def part_two(input) do
    input
  end
end
