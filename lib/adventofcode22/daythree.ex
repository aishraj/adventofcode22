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

    IO.inspect(r)
    r |> Enum.sum()
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

  def part_two(input) do
    input
  end
end
