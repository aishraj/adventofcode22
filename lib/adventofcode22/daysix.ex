defmodule Adventofcode22.Daysix do
  def part_one(input) do
    find_window(input, 4)
  end

  defp find_window(input, window_size) do
    {_chunk, index} =
      input
      |> String.trim()
      |> String.codepoints()
      |> Enum.chunk_every(window_size, 1, :discard)
      |> Enum.with_index(window_size)
      |> Enum.find(fn {items, _pos} ->
        items
        |> Enum.uniq()
        |> Enum.count() == window_size
      end)

    # IO.inspect("chunk: #{chunk}, index: #{index}")
    index
  end

  def part_two(input) do
    find_window(input, 14)
  end
end
