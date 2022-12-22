defmodule Adventofcode22.Daytwentyone do

  defmodule Monkey do
    defstruct [:name, :leftchild, :operator, :rightchild]
  end

 def part_one(raw_input)  do
  map = parse_input(raw_input)
  dfs("root", map)
 end

 def part_two(raw_input) do
   map = parse_input(raw_input)
   {root_left, _, root_right} = map["root"]
   # this is a two step process
   # first we try to narrow down which of the left or right nodes
   # contain "humn"
   # and then we compute the value of the other node
   target = if contains_humn(root_left, map) do
    dfs(root_right, map)
   else
    dfs(root_left, map)
   end

 end

 def contains_humn("humn", _map), do: true
 def contains_humn(root, map) do
  case map[root] do
    value when is_integer(value) -> false
    {left, _op, right} ->
      leftres = contains_humn(left, map)
      rightres = contains_humn(right, map)
      leftres or rightres
  end
 end


 def parse_line(line) do
  [monkey, depdencies] = line |> String.split(":", trim: true)
  depdencies = depdencies |> String.split(" ", trim: true) |> get_dependencies()
  {monkey, depdencies}
 end

 def get_dependencies([leftchild, operator, rightchild]) do
  {leftchild, String.to_atom(operator), rightchild}
 end

 def get_dependencies([value]) do
  String.to_integer(value)
 end

 def dfs(monkey, map) do
  case map[monkey] do
   value when is_integer(value) -> value
   {leftchild, operator, rightchild} ->
    leftchild = dfs(leftchild, map)
    rightchild = dfs(rightchild, map)
    apply_op(operator, leftchild, rightchild)
  end
 end

 def apply_op(:+, leftchild, rightchild) do
  leftchild + rightchild
 end

  def apply_op(:-, leftchild, rightchild) do
    leftchild - rightchild
  end

  def apply_op(:*, leftchild, rightchild) do
    leftchild * rightchild
  end

  def apply_op(:/, leftchild, rightchild) do
    Integer.floor_div(leftchild, rightchild)
  end


 def parse_input(raw_input) do
  raw_input
  |> String.split("\n", trim: true)
  |> Stream.map(&parse_line/1)
  |> Enum.reduce(%{}, fn {monkey, deps}, acc -> Map.put(acc, monkey, deps) end)
 end
end
