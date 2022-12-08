defmodule Adventofcode22.Dayeight do
  def read_file(filename) do
    File.read!(filename)
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, rownum}, acc ->
      rowitem =
        String.codepoints(line)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, colnum}, acc1 ->
          Map.put(acc1, colnum, char)
        end)

      Map.put(acc, rownum, rowitem)
    end)
  end

  # TODO: DRY the following into a function that accepts a function in addition to the direction

  defp is_visible(:left, grid, row, col) do
    Enum.reduce(0..(col - 1), true, fn colnum, acc ->
      if grid[row][colnum] >= grid[row][col] do
        false
      else
        acc
      end
    end)
  end

  defp is_visible(_dir, _grid, 0, _col), do: true
  defp is_visible(_dir, _grid, _row, 0), do: true

  defp is_visible(:right, grid, row, col) do
    boundary = Map.keys(grid[0]) |> Enum.max()

    Enum.reduce((col + 1)..boundary, true, fn colnum, acc ->
      if grid[row][colnum] >= grid[row][col] do
        false
      else
        acc
      end
    end)
  end

  defp is_visible(:up, grid, row, col) do
    Enum.reduce(0..(row - 1), true, fn rownum, acc ->
      if grid[rownum][col] >= grid[row][col] do
        false
      else
        acc
      end
    end)
  end

  defp is_visible(:down, grid, row, col) do
    boundary = Map.keys(grid) |> Enum.max()

    Enum.reduce((row + 1)..boundary, true, fn rownum, acc ->
      if grid[rownum][col] >= grid[row][col] do
        false
      else
        acc
      end
    end)
  end

  def part_one(grid) do
    row_boundary = Map.keys(grid) |> Enum.max()
    col_boundary = Map.keys(grid[0]) |> Enum.max()

    Enum.reduce(0..row_boundary, MapSet.new(), fn rownum, acc ->
      Enum.reduce(0..col_boundary, acc, fn colnum, acc1 ->
        left = is_visible(:left, grid, rownum, colnum)
        right = is_visible(:right, grid, rownum, colnum)
        up = is_visible(:up, grid, rownum, colnum)
        down = is_visible(:down, grid, rownum, colnum)

        IO.inspect(
          "row: #{rownum}, col: #{colnum}, left: #{left}, right: #{right}, up: #{up}, down: #{down}"
        )

        if left or right or up or down or row_boundary == rownum or col_boundary == colnum do
          MapSet.put(acc1, {rownum, colnum})
        else
          acc1
        end
      end)
    end)
    |> MapSet.size()
  end
end
