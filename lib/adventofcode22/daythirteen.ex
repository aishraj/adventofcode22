defmodule Adventofcode22.Daythirteen do
  require IEx

  def convert_line_to_list(line) do
    line = line |> String.trim()
    {oplist, _} = Code.eval_string(line)
    oplist
  end

  def part_one(input) do
    input
    |> Enum.map(fn lines -> String.split(lines, "\n", trim: true) end)
    |> Enum.map(fn lines -> Enum.map(lines, &convert_line_to_list/1) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {lines, index} ->
      [one, rest] = lines

      res = compare_lists(one, rest)
      {index, res}
    end)
    |> Enum.filter(fn {_index, res} -> res == :lt end)
    |> Enum.map(fn {index, _res} -> index end)
    |> Enum.sum()
  end

  def part_two(input) do
    res =
      input
      |> Enum.map(fn lines -> String.split(lines, "\n", trim: true) end)
      |> Enum.map(fn lines -> Enum.map(lines, &convert_line_to_list/1) end)
      |> Enum.reduce([[[2]], [[6]]], fn [first, second], acc ->
        acc ++ [first, second]
      end)
      |> Enum.sort(fn x, y -> Enum.member?([:lt, :eq], compare_lists(x, y)) end)

    index_of_2 = Enum.find_index(res, fn x -> x == [[2]] end)
    index_of_6 = Enum.find_index(res, fn x -> x == [[6]] end)
    (index_of_2 + 1) * (index_of_6 + 1)
  end

  def compare_lists({x, y}) do
    compare_lists(x, y)
  end

  def compare_lists([one_head | one_tail], [other_head | other_tail]) do
    case compare_lists(one_head, other_head) do
      :eq -> compare_lists(one_tail, other_tail)
      rest -> rest
    end
  end

  def compare_lists(x, y) when not is_list(x) and is_list(y), do: compare_lists([x], y)
  def compare_lists(x, y) when not is_list(y) and is_list(x), do: compare_lists(x, [y])

  def compare_lists(x, y) when is_integer(x) and is_integer(y) do
    cond do
      x < y -> :lt
      x > y -> :gt
      true -> :eq
    end
  end

  def compare_lists([], []), do: :eq

  def compare_lists([], [_ | _]), do: :lt

  def compare_lists([_ | _], []), do: :gt
end
