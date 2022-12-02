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

  def part_two(input) do
    input
    |> Enum.map(fn [x, y] -> calculate_score2(x, y) end)
    |> Enum.sum()
  end

  defp calculate_score2(x, y) do
    a = item(x)
    result = outcome(y)
    b = compete2(a, result)
    base = score(b)

    points = find_winner(result, a, b)
    base + points
  end

  defp calculate_score(x, y) do
    a = item(x)
    b = item(y)
    result = compete(a, b)

    base = score(b)

    points = find_winner(result, a, b)

    base + points
  end

  defp compete2(:rock, :win), do: :paper
  defp compete2(:scissors, :lose), do: :paper
  defp compete2(:scissors, :win), do: :rock
  defp compete2(:paper, :lose), do: :rock
  defp compete2(:rock, :lose), do: :scissors
  defp compete2(:paper, :win), do: :scissors
  defp compete2(x, :draw), do: x

  defp outcome("X"), do: :lose
  defp outcome("Y"), do: :draw
  defp outcome("Z"), do: :win

  defp find_winner(result, _p, q) when result == q, do: 6
  defp find_winner(:draw, _p, _q), do: 3
  defp find_winner(:win, _, _), do: 6
  defp find_winner(result, _p, q) when result != q, do: 0

  defp compete(:rock, :paper), do: :paper
  defp compete(:paper, :rock), do: :paper
  defp compete(:rock, :scissors), do: :rock
  defp compete(:scissors, :rock), do: :rock
  defp compete(:scissors, :paper), do: :scissors
  defp compete(:paper, :scissors), do: :scissors
  defp compete(x, y) when x == y, do: :draw

  defp item("A"), do: :rock
  defp item("B"), do: :paper
  defp item("C"), do: :scissors
  defp item("X"), do: :rock
  defp item("Y"), do: :paper
  defp item("Z"), do: :scissors

  defp score(:rock), do: 1
  defp score(:paper), do: 2
  defp score(:scissors), do: 3
end
