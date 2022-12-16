defmodule Adventofcode22.Dayfifteen do
  def parse_line(line) do
    Regex.scan(~r/-?\d+/, line)
    |> List.flatten()
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> Enum.chunk_every(2)
    |> List.first()
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  @spec manhattan_distance({integer, integer}, {integer, integer}) :: integer
  def manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  @spec points_in_manhattan_distance({integer, integer}, integer) :: [{integer, integer}]
  def points_in_manhattan_distance({x, y}, distance) do
    for x2 <- (x - distance)..(x + distance),
        y2 <- (y - distance)..(y + distance),
        manhattan_distance({x, y}, {x2, y2}) == distance,
        do: {x2, y2}
  end

  def part_one(input) do
    min_x =
      input
      |> Enum.map(fn [{x1, _}, {x2, _}] -> min(x1, x2) end)
      |> Enum.min()

    max_x =
      input
      |> Enum.map(fn [{x1, _}, {x2, _}] -> max(x1, x2) end)
      |> Enum.max()

    r =
      input
      |> Enum.map(fn [sensor, beacon] ->
        distance = manhattan_distance(sensor, beacon)
        points_in_manhattan_distance(sensor, distance) ++ [sensor]
      end)
      |> List.flatten()
      |> MapSet.new()

    tenth_row = MapSet.filter(r, fn {_, y} -> y == 10 end)

    IO.inspect(tenth_row, label: "tenth_row")

    Enum.reduce(min_x..max_x, [], fn x, acc ->
      case MapSet.member?(r, {x, 10}) do
        true -> acc
        false -> [x | acc]
      end
    end)
    |> Enum.count()
  end
end
