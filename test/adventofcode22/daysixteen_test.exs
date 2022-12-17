defmodule Adventofcode22.DaysixteenTest do
  use ExUnit.Case

  test "parsers line" do
    line = "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB"

    assert Adventofcode22.Daysixteen.parse_line(line) == %Adventofcode22.Daysixteen.Node{
             name: "AA",
             weight: 0,
             children: ["DD", "II", "BB"]
           }
  end

  test "parses line with one value" do
    line = "Valve HH has flow rate=22; tunnel leads to valve GG"

    assert Adventofcode22.Daysixteen.parse_line(line) == %Adventofcode22.Daysixteen.Node{
             name: "HH",
             weight: 22,
             children: ["GG"]
           }
  end

  test "returns all pairs path_correctly" do
    raw_file = File.read!("input/16_easy.txt")
    graph = Adventofcode22.Daysixteen.parse_input(raw_file)
    outcome = Adventofcode22.Daysixteen.all_pairs_bfs(graph)

    assert outcome == %{
             "AA" => %{
               "AA" => 0,
               "BB" => 1,
               "CC" => 2,
               "DD" => 1,
               "EE" => 2,
               "FF" => 3,
               "GG" => 4,
               "HH" => 5,
               "II" => 1,
               "JJ" => 2
             },
             "BB" => %{
               "AA" => 1,
               "BB" => 0,
               "CC" => 1,
               "DD" => 2,
               "EE" => 3,
               "FF" => 4,
               "GG" => 5,
               "HH" => 6,
               "II" => 2,
               "JJ" => 3
             },
             "CC" => %{
               "AA" => 2,
               "BB" => 1,
               "CC" => 0,
               "DD" => 1,
               "EE" => 2,
               "FF" => 3,
               "GG" => 4,
               "HH" => 5,
               "II" => 3,
               "JJ" => 4
             },
             "DD" => %{
               "AA" => 1,
               "BB" => 2,
               "CC" => 1,
               "DD" => 0,
               "EE" => 1,
               "FF" => 2,
               "GG" => 3,
               "HH" => 4,
               "II" => 2,
               "JJ" => 3
             },
             "EE" => %{
               "AA" => 2,
               "BB" => 3,
               "CC" => 2,
               "DD" => 1,
               "EE" => 0,
               "FF" => 1,
               "GG" => 2,
               "HH" => 3,
               "II" => 3,
               "JJ" => 4
             },
             "FF" => %{
               "AA" => 3,
               "BB" => 4,
               "CC" => 3,
               "DD" => 2,
               "EE" => 1,
               "FF" => 0,
               "GG" => 1,
               "HH" => 2,
               "II" => 4,
               "JJ" => 5
             },
             "GG" => %{
               "AA" => 4,
               "BB" => 5,
               "CC" => 4,
               "DD" => 3,
               "EE" => 2,
               "FF" => 1,
               "GG" => 0,
               "HH" => 1,
               "II" => 5,
               "JJ" => 6
             },
             "HH" => %{
               "AA" => 5,
               "BB" => 6,
               "CC" => 5,
               "DD" => 4,
               "EE" => 3,
               "FF" => 2,
               "GG" => 1,
               "HH" => 0,
               "II" => 6,
               "JJ" => 7
             },
             "II" => %{
               "AA" => 1,
               "BB" => 2,
               "CC" => 3,
               "DD" => 2,
               "EE" => 3,
               "FF" => 4,
               "GG" => 5,
               "HH" => 6,
               "II" => 0,
               "JJ" => 1
             },
             "JJ" => %{
               "AA" => 2,
               "BB" => 3,
               "CC" => 4,
               "DD" => 3,
               "EE" => 4,
               "FF" => 5,
               "GG" => 6,
               "HH" => 7,
               "II" => 1,
               "JJ" => 0
             }
           }
  end

  test "performs bfs correctly" do
    raw_file = File.read!("input/16_easy.txt")
    graph = Adventofcode22.Daysixteen.parse_input(raw_file)
    bfs_from_aa = Adventofcode22.Daysixteen.bfs(graph["AA"], graph)

    assert bfs_from_aa == [
             {"AA", 0},
             {"DD", 1},
             {"II", 1},
             {"BB", 1},
             {"CC", 2},
             {"EE", 2},
             {"JJ", 2},
             {"FF", 3},
             {"GG", 4},
             {"HH", 5}
           ]
  end

  test "parses input for easy" do
    raw_file = File.read!("input/16_easy.txt")
    outcome = Adventofcode22.Daysixteen.parse_input(raw_file)

    assert outcome["AA"] == %Adventofcode22.Daysixteen.Node{
             name: "AA",
             weight: 0,
             children: ["DD", "II", "BB"]
           }
  end
end
