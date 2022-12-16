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

  # @spec points_in_manhattan_distance({integer, integer}, integer) :: [{integer, integer}]
  # def points_in_manhattan_distance({x, y}, distance) do
  #   for x2 <- (x - distance)..(x + distance),
  #       y2 <- (y - distance)..(y + distance),
  #       manhattan_distance({x, y}, {x2, y2}) == distance,
  #       do: {x2, y2}
  # end

  def part_one(input, yval) do
    distance = Stream.map(input, fn [sensor, beacon] -> manhattan_distance(sensor, beacon) end)

    min_x = find_min_max(input, distance, &(&1 - &2), &Enum.min/1)
    max_x = find_min_max(input, distance, &(&1 + &2), &Enum.max/1)

    occupied =
      for x <- min_x..max_x,
          Stream.zip(input, distance)
          |> Enum.any?(fn {[sensor, _beacon], distance} ->
            manhattan_distance(sensor, {x, yval}) <= distance
          end),
          do: x

    beacons_at_y_10 =
      input
      |> Stream.map(fn [_sensor, beacon] -> beacon end)
      |> Stream.filter(fn {_beaconx, beacony} -> beacony == yval end)
      |> Enum.uniq()

    beacons_at_y_10 = Enum.count(beacons_at_y_10)

    Enum.count(occupied) - beacons_at_y_10
  end

  defp find_min_max(input, distance, joiner, reducer) do
    Stream.zip(input, distance)
    |> Stream.map(fn {[{sensorx, _sensory}, {_beaconx, _beacony}], distance} ->
      joiner.(sensorx, distance)
    end)
    |> reducer.()
  end
end
