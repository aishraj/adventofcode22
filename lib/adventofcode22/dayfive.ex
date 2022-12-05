defmodule Adventofcode22.Dayfive do
  def read_input(file) do
    parts = File.read!(file) |> String.split("\n\n")
    [raw_stack, instructions] = parts
    parsed_stack = parse_stack(raw_stack)
    instructions = parse_instructions(instructions)
    {parsed_stack, instructions}
  end

  def parse_stack(raw_stack) do
    raw_stack
    |> String.split("\n")
    |> Enum.reverse()
    # drop the header line
    |> Enum.drop(1)
    |> Enum.reverse()
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn row, acc ->
      # Get the position of the item in the list
      # and use that as the key
      Enum.with_index(row, 1)
      |> Enum.reduce(acc, fn {item, index}, acc ->
        if item != "" do
          current_item = Map.get(acc, index, [])
          Map.put(acc, index, [item | current_item])
        else
          acc
        end
      end)
    end)
  end

  def parse_line(line) do
    line
    |> String.codepoints()
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&String.slice(&1, 1..1))
  end

  def part_one(graph, instructions) do
    graph =
      Enum.reduce(instructions, graph, fn instr, grid ->
        apply_instruction(instr, grid)
      end)

    # TODO: This is not working

    1..Enum.count(graph)
    |> Enum.reduce(:gb_trees.empty(), fn x, acc ->
      val = Map.get(graph, x, [])
      :gb_trees.insert(x, val, acc)
    end)
    |> :gb_trees.to_list()
    |> Enum.map(fn {_pos, stack} -> List.last(stack) end)
    |> Enum.join("")
  end

  # TODO: This is not correct yet
  def apply_instruction(instr, grid) do
    [n, source, dest] = instr
    old_source = Map.get(grid, source)
    old_dest = Map.get(grid, dest)
    # copy n items from source to dest
    new_source = old_source |> Enum.reverse() |> Enum.drop(n) |> Enum.reverse()
    items_copied = old_source |> Enum.reverse() |> Enum.take(n)
    new_dest = old_dest ++ items_copied
    grid = Map.put(grid, source, new_source)
    grid = Map.put(grid, dest, new_dest)
    grid
  end

  def parse_instructions(raw_instructions) do
    raw_instructions
    |> String.split("\n")
    |> Enum.map(fn line ->
      tokens = String.split(line, " ")
      [_move, numitems, _from, source, _to, destination] = tokens

      [numitems, source, destination]
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
