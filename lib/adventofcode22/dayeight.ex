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

  defp scenic_score(grid, row, col, row_boundary, col_boundary) do
    left = find_next_visible(:left, grid, row, col)
    up = find_next_visible(:up, grid, row, col)
    right = find_next_visible(:right, grid, row, col, row_boundary, col_boundary)
    down = find_next_visible(:down, grid, row, col, row_boundary, col_boundary)
    score = left * right * up * down
    score
  end

  defp find_next_visible(:left, grid, row, col) do
    Enum.reduce_while((col - 1)..0//-1, 0, fn colnum, acc ->
      if grid[row][colnum] < grid[row][col] do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

  defp find_next_visible(:up, grid, row, col) do
    Enum.reduce_while((row - 1)..0//-1, 0, fn rownum, acc ->
      if grid[rownum][col] < grid[row][col] do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

  defp find_next_visible(:right, grid, row, col, _row_boundary, col_boundary) do
    Enum.reduce_while((col + 1)..col_boundary, 0, fn colnum, acc ->
      if grid[row][colnum] < grid[row][col] do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

  defp find_next_visible(:down, grid, row, col, row_boundary, _col_boundary) do
    Enum.reduce_while((row + 1)..row_boundary, 0, fn rownum, acc ->
      if grid[rownum][col] < grid[row][col] do
        {:cont, acc + 1}
      else
        {:halt, acc + 1}
      end
    end)
  end

  def part_two(grid) do
    row_boundary = Map.keys(grid) |> Enum.max()
    col_boundary = Map.keys(grid[0]) |> Enum.max()

    Enum.reduce(1..(row_boundary - 1), [], fn rownum, acc ->
      Enum.reduce(1..(col_boundary - 1), acc, fn colnum, acc1 ->
        scenic_score = scenic_score(grid, rownum, colnum, row_boundary, col_boundary)
        acc1 ++ [scenic_score]
      end)
    end)
    |> Enum.max()
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
