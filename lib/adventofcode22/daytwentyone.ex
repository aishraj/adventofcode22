defmodule Adventofcode22.Daytwentyone do
  defmodule Monkey do
    defstruct [:name, :leftchild, :operator, :rightchild]
  end

  def part_one(raw_input) do
    map = parse_input(raw_input)
    dfs("root", map)
  end

  def part_two(raw_input) do
    map = parse_input(raw_input)
    {root_left, _, root_right} = map["root"]

    if contains_humn(root_left, map) do
      target = dfs(root_right, map)
      search_for_humn(root_left, target, map)
    else
      target = dfs(root_left, map)
      search_for_humn(root_right, target, map)
    end
  end

  def search_for_humn("humn", target, _map), do: target

  def search_for_humn(monkey, target, map) do
    case map[monkey] do
      value when is_integer(value) ->
        value

      {leftchild, operator, rightchild} ->
        if contains_humn(leftchild, map) do
          right_value = dfs(rightchild, map)

          new_target =
            case operator do
              :+ -> target - right_value
              :- -> target + right_value
              :* -> Integer.floor_div(target, right_value)
              :/ -> target * right_value
            end

          search_for_humn(leftchild, new_target, map)
        else
          left_value = dfs(leftchild, map)

          new_target =
            case operator do
              :+ -> target - left_value
              :- -> left_value - target
              :* -> Integer.floor_div(target, left_value)
              :/ -> left_value * target
            end

          search_for_humn(rightchild, new_target, map)
        end
    end
  end

  def inverse_op(:+), do: :-
  def inverse_op(:-), do: :+
  def inverse_op(:*), do: :/
  def inverse_op(:/), do: :*

  def contains_humn("humn", _map), do: true

  def contains_humn(root, map) do
    case map[root] do
      value when is_integer(value) ->
        false

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
      value when is_integer(value) ->
        value

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
