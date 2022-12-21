defmodule Adventofcode22.Daytwentyone do

  defmodule Monkey do
    defstruct [:name, :leftchild, :operator, :rightchild]
  end

#  def part_one(parsed_input)  do

#  end

 def parse_line(line) do
  [monkey, depdencies] = line |> String.split(":", trim: true)
  depdencies = depdencies |> String.split(" ", trim: true) |> get_dependencies()
  {monkey, depdencies}
 end

 def get_dependencies([value]) do
   value
 end

 def get_dependencies([leftchild, operator, rightchild]) do
  {leftchild, String.to_atom(operator), rightchild}
 end

 def parse_input(raw_input) do
  raw_input
  |> String.split("\n", trim: true)
  |> Stream.map(&parse_line/1)
  |> Enum.reduce(%{}, fn {monkey, deps}, acc -> Map.put(acc, monkey, deps) end)
 end
end
