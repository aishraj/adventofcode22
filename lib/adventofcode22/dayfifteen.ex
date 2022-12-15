defmodule Adventofcode22.Dayfifteen do
  def parse_line(line) do
    line
    |> String.split(~r/\D+/, trim: true)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> Enum.chunk_every(2)
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
    distance = Enum.map(input, fn [sensor, beacon] -> manhattan_distance(sensor, beacon) end)

    Stream.zip(input, distance)
    |> Stream.map(fn {point, distance} ->
      points_in_manhattan_distance(point, distance) ++ [elem(point, 1)]
    end)
    |> Stream.flat_map(fn )
  end
end
