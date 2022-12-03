defmodule Adventofcode22.Daythree do
  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  def part_one(input) do
    r =
      input
      |> Enum.map(fn line -> get_common_char(line) end)
      |> Enum.map(fn item -> convert_to_int(item) end)

    r |> Enum.sum()
  end

  def part_two(input) do
    input
    |> Enum.chunk_every(3)
    |> Enum.map(fn chunk -> get_common_char_cols(chunk) end)
    |> List.flatten()
    |> Enum.map(fn item -> convert_to_int(item) end)
    |> Enum.sum()
  end

  defp get_common_char_cols(lines) do
    sets =
      lines
      |> Enum.map(fn line ->
        line
        |> String.codepoints()
        |> MapSet.new()
      end)

    initial = Enum.at(sets, 0)

    Enum.drop(sets, 1)
    |> Enum.reduce(initial, fn line, acc ->
      MapSet.intersection(acc, line)
    end)
  end

  defp get_common_char(line) do
    codepoints = String.codepoints(line)
    needed_element_count = Enum.count(codepoints) |> round()
    midpoint = needed_element_count |> div(2) |> round()
    left = Enum.slice(codepoints, 0, midpoint) |> MapSet.new()
    right = Enum.slice(codepoints, midpoint, needed_element_count) |> MapSet.new()
    r = MapSet.intersection(left, right)
    r
  end

  defp convert_to_int(item) do
    item =
      MapSet.to_list(item)
      |> Enum.at(0)

    if item >= "A" && item <= "Z" do
      :binary.first(item) - 64 + 26
    else
      :binary.first(item) - 96
    end
  end
end
