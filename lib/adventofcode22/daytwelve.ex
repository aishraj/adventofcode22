defmodule Adventofcode22.Daytwelve do
  @spec part_one(Map.t()) :: integer()
  def part_one(data) do
    {startx, starty} = locate("S", data)
    {endx, endy} = locate("E", data)
    startrow = data[startx]
    startrow = Map.put(startrow, starty, "a")
    data = Map.put(data, startx, startrow)
    endrow = data[endx]
    endrow = Map.put(endrow, endy, "z")
    data = Map.put(data, endx, endrow)
    bfs([{{startx, starty}, 0}], data, {endx, endy}, MapSet.new())
  end

  def part_two(data) do
    {startx, starty} = locate("S", data)
    {endx, endy} = locate("E", data)
    startrow = data[startx]
    startrow = Map.put(startrow, starty, "a")
    data = Map.put(data, startx, startrow)
    endrow = data[endx]
    endrow = Map.put(endrow, endy, "z")
    data = Map.put(data, endx, endrow)
    a_locations = find_all("a", data)

    Enum.reduce(a_locations, [], fn {x, y}, acc ->
      res = bfs([{{x, y}, 0}], data, {endx, endy}, MapSet.new())

      if res != :invalid_graph do
        [res | acc]
      else
        acc
      end
    end)
    |> Enum.min()
  end

  @spec find_all(String.t(), Map.t()) :: [{integer(), integer()}]
  def find_all(point, data) do
    row_size = Map.keys(data) |> Enum.max()
    col_size = Map.keys(data[0]) |> Enum.max()

    Enum.reduce(0..row_size, [], fn rownum, acc ->
      Enum.reduce(0..col_size, acc, fn colnum, acc1 ->
        if data[rownum][colnum] == point do
          [{rownum, colnum} | acc1]
        else
          acc1
        end
      end)
    end)
  end

  defp bfs([], _grid, _target, _visited), do: :invalid_graph
  defp bfs([{coord, moves} | _tail], _grid, coord, _visited), do: moves

  defp bfs([{coord, moves} | tail], grid, target, visited) do
    neighbors = get_neighbors(grid, coord)

    neighbors =
      neighbors
      |> Enum.filter(&(!MapSet.member?(visited, &1)))
      |> Enum.map(&{&1, moves + 1})

    queue = tail ++ neighbors

    visited_coords = Enum.map(neighbors, fn {coord, _moves} -> coord end)
    visited = MapSet.union(visited, MapSet.new(visited_coords))

    bfs(
      queue,
      grid,
      target,
      visited
    )
  end

  @spec get_neighbors(Map.t(), {integer(), integer()}) :: [{integer(), integer()}]
  def get_neighbors(grid, {x, y}) do
    row_size = Map.keys(grid) |> Enum.max()
    col_size = Map.keys(grid[0]) |> Enum.max()

    neighbors = [
      {x - 1, y},
      {x + 1, y},
      {x, y - 1},
      {x, y + 1}
    ]

    current_charval = charval(grid, x, y)

    Enum.filter(neighbors, fn {nx, ny} ->
      nx >= 0 and nx <= row_size and ny >= 0 and ny <= col_size and
        charval(grid, nx, ny) - current_charval <= 1
    end)
  end

  def charval(grid, x, y) do
    grid[x][y] |> to_charlist() |> hd()
  end

  @spec locate(String.t(), Map.t()) :: {integer(), integer()}
  def locate(point, data) do
    row_size = Map.keys(data) |> Enum.max()
    col_size = Map.keys(data[0]) |> Enum.max()

    Enum.reduce(0..row_size, nil, fn rownum, acc ->
      Enum.reduce(0..col_size, acc, fn colnum, acc1 ->
        if data[rownum][colnum] == point do
          {rownum, colnum}
        else
          acc1
        end
      end)
    end)
  end
end
