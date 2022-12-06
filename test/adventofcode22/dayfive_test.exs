defmodule Adventofcode22.DayfiveTest do
  use ExUnit.Case

  test "parse a single line" do
    line = "    [S] [M] [R] [W] [M] [C]        "
    result = Adventofcode22.Dayfive.parse_line(line)
    assert result == ["", "S", "M", "R", "W", "M", "C", "", ""]
  end

  test "completes part 1 easy" do
    {stack, instructions} = Adventofcode22.Dayfive.read_input("input/5_easy.txt")
    result = Adventofcode22.Dayfive.part_one(stack, instructions)
    assert result == "CMZ"
  end

  test "completes part 1" do
    {stack, instructions} = Adventofcode22.Dayfive.read_input("input/5.txt")
    result = Adventofcode22.Dayfive.part_one(stack, instructions)
    assert result == "JCMHLVGMG"
  end

  test "reads input properly" do
    {grid, instr} = Adventofcode22.Dayfive.read_input("input/5_easy.txt")
    assert grid == %{1 => ["Z", "N"], 2 => ["M", "C", "D"], 3 => ["P"]}
    assert instr == [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
  end

  test "applies instruction correctly" do
    {grid, _instr} = Adventofcode22.Dayfive.read_input("input/5_easy.txt")
    result = Adventofcode22.Dayfive.apply_instruction([1, 2, 1], grid)
    assert result == %{1 => ["Z", "N", "D"], 2 => ["M", "C"], 3 => ["P"]}
  end

  test "parses the stack grid" do
    input = File.read!("input/5_stack_easy.txt")
    result = Adventofcode22.Dayfive.parse_stack(input)
    assert result == %{1 => ["Z", "N"], 2 => ["M", "C", "D"], 3 => ["P"]}
  end

  test "applies the bulk instructions" do
    input = File.read!("input/5_2_stack.txt")
    grid = Adventofcode22.Dayfive.parse_stack(input)
    result = Adventofcode22.Dayfive.apply_bulk_instruction([3, 1, 3], grid)
    assert result == %{1 => [], 2 => ["M", "C"], 3 => ["P", "Z", "N", "D"]}
  end

  test "completes part 2" do
    {stack, instructions} = Adventofcode22.Dayfive.read_input("input/5.txt")
    result = Adventofcode22.Dayfive.part_two(stack, instructions)
    assert result == "LVMRWSSPZ"
  end
end
