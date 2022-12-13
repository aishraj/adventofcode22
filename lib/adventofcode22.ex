defmodule Adventofcode22 do
  def read_input(infile) do
    infile
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "\n"))
  end

  def read_file_to_grid(filename) do
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
end
