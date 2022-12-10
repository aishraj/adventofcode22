defmodule Adventofcode22.Daynine do
  def read_input(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&convert_to_direction/1)
  end

  def convert_to_direction(line) do
    parts = String.split(line, " ", trim: true)
    get_directions(hd(parts), tl(parts) |> hd)
  end

  def add({coord_a_x, coord_a_y}, {coord_b_x, coord_b_y}) do
    {coord_a_x + coord_b_x, coord_a_y + coord_b_y}
  end

  def diff({coord_a_x, coord_a_y}, {coord_b_x, coord_b_y}) do
    {dx, dy} = {coord_a_x - coord_b_x, coord_a_y - coord_b_y}

    case {dx, dy} do
      {x, y} when abs(x) == 2 or abs(y) == 2 -> {signum(x), signum(y)}
      _ -> {0, 0}
    end
  end

  def get_directions("U", distance), do: {{0, 1}, String.to_integer(distance)}
  def get_directions("D", distance), do: {{0, -1}, String.to_integer(distance)}
  def get_directions("L", distance), do: {{-1, 0}, String.to_integer(distance)}
  def get_directions("R", distance), do: {{1, 0}, String.to_integer(distance)}

  def signum(x) when x < 0, do: -1
  def signum(x) when x > 0, do: 1
  def signum(x) when x == 0, do: 0

  def move(motions, rope, visited \\ [])

  def move([], _, visited) do
    visited
  end

  def move([{_, 0} | rest], rope, visited) do
    move(rest, rope, visited)
  end

  def move([{direction, count} | rest], [head | tail], visited) do
    new_head = add(head, direction)

    new_tail =
      Enum.map_reduce(tail, new_head, fn segment, prev_segment ->
        next_segment =
          diff(prev_segment, segment)
          |> add(segment)

        {next_segment, next_segment}
      end)
      |> elem(0)

    visited = [visited | Enum.take(new_tail, -1)] |> List.flatten()

    move(
      [{direction, count - 1} | rest],
      [new_head | new_tail],
      visited
    )
  end

  def part_one(movements, ropesize) do
    move(movements, List.duplicate({0, 0}, ropesize))
    |> Enum.uniq()
    |> Enum.count()
  end

  def part_two(movements, ropesize) do
    move(movements, List.duplicate({0, 0}, ropesize))
    |> Enum.uniq()
    |> Enum.count()
  end
end
