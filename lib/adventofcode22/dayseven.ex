defmodule Adventofcode22.Dayseven do
  def read_file(filename) do
    File.read!(filename)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
  end

  def part_two(input) do
    [head | tail] = find_sizes(input, [], [])
    delta = head - 40_000_000

    tail
    |> Enum.filter(fn item -> item >= delta end)
    |> Enum.min()
  end

  # Base cases of collecting the totals
  defp find_sizes([], [], acc), do: acc
  defp find_sizes([], [root], acc), do: [root | acc]

  defp find_sizes([], [current_sum, pathstack_head | pathstack_tail], acc),
    do: find_sizes([], [current_sum + pathstack_head | pathstack_tail], [current_sum | acc])

  # Recursive cases of parsing
  defp find_sizes(["$ cd .." | tail], [current_sum, pathstack_head | pathstack_tail], acc),
    do: find_sizes(tail, [current_sum + pathstack_head | pathstack_tail], [current_sum | acc])

  defp find_sizes(["$ cd " <> _ | tail], pathstack_tail, acc),
    do: find_sizes(tail, [0 | pathstack_tail], acc)

  defp find_sizes(["$ ls" | tail], pathstack_tail, acc),
    do: find_sizes(tail, pathstack_tail, acc)

  defp find_sizes(["dir " <> _ | tail], pathstack_tail, acc),
    do: find_sizes(tail, pathstack_tail, acc)

  defp find_sizes([file | tail], [current_sum | pathstack_tail], acc) do
    [fsize, _filename] = String.split(file)
    find_sizes(tail, [current_sum + String.to_integer(fsize) | pathstack_tail], acc)
  end

  def part_one(lines) do
    res =
      lines
      |> find_sizes([], [])
      |> Stream.filter(fn item -> item <= 100_000 end)
      |> Enum.sum()

    res
  end
end
