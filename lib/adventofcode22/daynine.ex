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

  def get_directions("U", distance), do: {{0, 1}, String.to_integer(distance)}
  def get_directions("D", distance), do: {{0, -1}, String.to_integer(distance)}
  def get_directions("L", distance), do: {{-1, 0}, String.to_integer(distance)}
  def get_directions("R", distance), do: {{1, 0}, String.to_integer(distance)}

  def signum(x) when x < 0, do: -1
  def signum(x) when x > 0, do: 1
  def signum(x) when x == 0, do: 0

  def move_head({x, y}, {dx, dy}), do: {x + dx, y + dy}

  def move_tail({headx, heady}, {tailx, taily}) do
    {x, y} = {headx - tailx, heady - taily}

    if abs(x) == 2 or abs(y) == 2 do
      {tailx + signum(x), taily + signum(y)}
    else
      {tailx, taily}
    end
  end

  def move(movements, current) do
    movements
    |> Enum.reduce({current, []}, fn {direction, distance}, acc0 ->
      Enum.reduce(1..distance, acc0, fn _, {positions, path} ->
        [headpos, tailpos] = positions
        headpos = move_head(headpos, direction)
        tailpos = move_tail(headpos, tailpos)
        path = path ++ [tailpos]
        {[headpos, tailpos], path}
      end)
    end)
  end

  def part_one(movements, ropesize) do
    ## TODO change this from list.duplicate to a tuple of tuples
    {_, path} = move(movements, List.duplicate({0, 0}, ropesize))

    Enum.uniq(path)
    |> Enum.count()
  end
end
