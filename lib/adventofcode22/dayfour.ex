defmodule Adventofcode22.Dayfour do
  def read_input(file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, ",") end)
  end

  def part_one(pairs) do
    pairs
    |> Enum.map(&find_overlap(&1))
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def find_overlap([first, second]) do
    {first_start, first_end} = get_chunks(first)
    {second_start, second_end} = get_chunks(second)
    fully_contained(first_start, first_end, second_start, second_end)
  end

  defp fully_contained(first_start, first_end, second_start, second_end) do
    if first_start <= second_start and first_end >= second_end do
      true
    else
      if second_start <= first_start and second_end >= first_end do
        true
      else
        false
      end
    end
  end

  def get_chunks(chunk) do
    chunk = String.split(chunk, "-") |> Enum.map(&String.to_integer/1)
    [chunk_start | _rem] = chunk
    chunk_end = Enum.at(chunk, 1)
    {chunk_start, chunk_end}
  end
end
