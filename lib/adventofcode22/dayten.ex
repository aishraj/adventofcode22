defmodule Adventofcode22.Dayten do
  def parse_line(line) do
    [instruction | cycle] = String.split(line, " ")

    if instruction == "noop" do
      {String.to_atom(instruction), 0}
    else
      {String.to_atom(instruction), String.to_integer(hd(cycle))}
    end
  end

  def parse_file(raw_data) do
    raw_data
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  def read_file(filename) do
    filename
    |> File.read!()
    |> parse_file()
  end

  def signal_strengths(instructions, watch_total_cycles) do
    {final_x, final_cycle, strengths} =
      Enum.reduce(instructions, {1, 1, []}, fn instruction, {x, current_cycle, strengths} ->
        total_cycles_for_instruction = cycles(instruction)

        Enum.reduce(
          1..total_cycles_for_instruction,
          {x, current_cycle, strengths},
          fn current_instruction_cycle_count, {x, current_cycle, strengths} ->
            x =
              if current_instruction_cycle_count == total_cycles_for_instruction do
                apply_instruction(instruction, x)
              else
                x
              end

            strengths =
              if Enum.member?(watch_total_cycles, current_cycle) do
                strengths ++ [x * current_cycle]
              else
                strengths
              end

            {x, current_cycle + 1, strengths}
          end
        )
      end)

    {final_x, final_cycle, strengths}
  end

  defp apply_instruction({:noop, _}, x), do: x
  defp apply_instruction({:addx, raise}, x), do: x + raise

  defp cycles({:noop, _}), do: 1
  defp cycles({:addx, _}), do: 2
end
