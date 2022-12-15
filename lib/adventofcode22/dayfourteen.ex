defmodule Adventofcode22.Dayfourteen do
  def part_one(input) do
    pit = Enum.max_by(input, &elem(&1, 1)) |> elem(1)

    Stream.unfold(input, fn points ->
      simulate(points, pit, {500, 0})
    end)
    |> Enum.count()
  end

  def part_two(input) do
    pit =
      Enum.max_by(input, &elem(&1, 1))
      |> elem(1)
      |> Kernel.+(2)

    input = (-pit - 1)..(pit + 1) |> Stream.map(&{500 + &1, pit}) |> Enum.into(input)

    Stream.unfold(input, fn points ->
      simulate(points, pit, {500, 0})
    end)
    |> Enum.count()
  end

  def simulate(points, pit, {x, y} = sand) do
    case MapSet.member?(points, {500, 0}) do
      true ->
        nil

      false ->
        next_cell = next_neighbor(points, {x, y})

        case next_cell do
          nil -> {points, MapSet.put(points, sand)}
          {_, y} when y > pit -> nil
          _ -> simulate(points, pit, next_cell)
        end
    end
  end

  def next_neighbor(points, {x, y}) do
    first = {x, y + 1}
    second = {x - 1, y + 1}
    third = {x + 1, y + 1}

    Enum.find([first, second, third], &(!MapSet.member?(points, &1)))
  end

  def parse_input(path) do
    path
    |> File.stream!()
    |> Stream.flat_map(&parse_line/1)
    |> MapSet.new()
  end

  defp parse_line(line) do
    line
    |> String.split(~r/\D+/, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.flat_map(fn [[a, b], [c, d]] ->
      for x <- a..c, y <- b..d, do: {x, y}
    end)
  end
end
