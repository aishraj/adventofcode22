defmodule Adventofcode22.Daysixteen do
  defmodule Node do
    defstruct [:name, :children, :weight]
  end

  @spec bfs(Node.t(), Map.t()) :: [{String.t(), integer()}]
  def bfs(source, graph) do
    queue = [{source, 0}]
    visited = MapSet.new()
    distances = []
    bfs_loop(queue, visited, distances, graph)
  end

  def all_pairs_bfs(graph) do
    graph
    |> Map.values()
    |> Enum.map(fn node -> %{node.name => Map.new(bfs(node, graph))} end)
    |> Enum.reduce(%{}, fn nodemap, acc ->
      Map.merge(acc, nodemap)
    end)
  end

  def bfs_loop([], _visited, distances, _graph), do: distances

  def bfs_loop([{current_node, current_distance} | rest_in_queue], visited, distances, graph) do
    if MapSet.member?(visited, current_node.name) do
      bfs_loop(rest_in_queue, visited, distances, graph)
    else
      visited = MapSet.put(visited, current_node.name)
      distances = distances ++ [{current_node.name, current_distance}]

      children =
        current_node.children
        |> Enum.map(fn child -> {Map.fetch!(graph, child), current_distance + 1} end)

      bfs_loop(rest_in_queue ++ children, visited, distances, graph)
    end
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
