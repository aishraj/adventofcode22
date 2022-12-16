defmodule Adventofcode22.Daysixteen do
  defmodule Node do
    defstruct [:name, :children, :weight]
  end

  @spec parse_input(String.t()) :: Map.t()
  def parse_input(raw_string) do
    raw_string
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Map.new(&{&1.name, &1})
  end

  @spec parse_line(String.t()) :: Node.t()
  def parse_line(line) do
    # example line:
    # Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
    [head, tail] = String.split(line, ";")
    [_, name, weight] = Regex.run(~r/Valve ([A-Z]{2}) has flow rate=(\d+)/, head)

    children =
      if String.contains?(tail, " valve ") do
        item = String.split(tail, "valve ") |> List.last() |> String.trim()
        [item]
      else
        String.split(tail, "valves")
        |> List.last()
        |> String.split(", ", trim: true)
        |> Enum.map(&String.trim/1)
      end

    %Node{name: name, weight: String.to_integer(weight), children: children}
  end
end
