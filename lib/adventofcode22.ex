defmodule Adventofcode22 do
  def read_input(infile) do
    infile
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "\n"))
  end
end
