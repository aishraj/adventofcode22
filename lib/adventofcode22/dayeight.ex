defmodule Adventofcode22.Dayeight do
  def read_file(filename) do
    File.read!(filename)
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, rownum}, acc ->
      rowitem =
        String.codepoints(line)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, colnum}, acc1 ->
          Map.put(acc1, colnum, char)
        end)

      Map.put(acc, rownum, rowitem)
    end)
  end

  def part_one(grid) do
    Enum.reduce(1)
  end
end
