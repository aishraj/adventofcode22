defmodule Adventofcode22.Dayten do
  def part_one(data) do
    {_, _, res, _} = Adventofcode22.Dayten.signal_strengths(data, [20, 60, 100, 140, 180, 220])
    Enum.sum(res)
  end

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

  def part_two(data, suffix \\ "real") do
    ### The following is a dirty hack to get the answer for part 2, I would not recommend this approach
    ## A better approach would be to use Enum.reduce or similar to build the output string but I'm lazy right now :P
    {_, _, _, register_states} = Adventofcode22.Dayten.signal_strengths(data, [])
    File.rm("input/10_2_" <> suffix <> ".txt")
    {:ok, file} = File.open("input/10_2_" <> suffix <> ".txt", [:write])

    for row <- 0..5 do
      for col <- 0..39 do
        center = register_states |> Enum.at(row * 40 + col)

        if col in (center - 1)..(center + 1),
          do: IO.binwrite(file, "#"),
          else: IO.binwrite(file, ".")
      end

      IO.binwrite(file, "\n")
    end

    File.close(file)

    File.read!("input/10_2_" <> suffix <> ".txt")
  end

  def signal_strengths(instructions, watch_total_cycles) do
    {final_x, final_cycle, strengths, register_states} =
      Enum.reduce(instructions, {1, 1, [], [1]}, fn instruction,
                                                    {x, current_cycle, strengths, register_states} ->
        total_cycles_for_instruction = cycles(instruction)

        Enum.reduce(
          1..total_cycles_for_instruction,
          {x, current_cycle, strengths, register_states},
          fn current_instruction_cycle_count, {x, current_cycle, strengths, register_states} ->
            strengths =
              if Enum.member?(watch_total_cycles, current_cycle) do
                strengths ++ [x * current_cycle]
              else
                strengths
              end

            x =
              if current_instruction_cycle_count == total_cycles_for_instruction do
                apply_instruction(instruction, x)
              else
                x
              end

            register_states = register_states ++ [x]

            {x, current_cycle + 1, strengths, register_states}
          end
        )
      end)

    {final_x, final_cycle, strengths, register_states}
  end

  defp apply_instruction({:noop, _}, x), do: x
  defp apply_instruction({:addx, raise}, x), do: x + raise

  defp cycles({:noop, _}), do: 1
  defp cycles({:addx, _}), do: 2
end
