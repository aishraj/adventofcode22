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

  # test "parses input for easy" do
  #   raw_file = File.read!("input/16_easy.txt")
  #   outcome = Adventofcode22.Daysixteen.parse_input(raw_file)
  #   require IEx
  #   IEx.pry()

  #   assert outcome["AA"] == %Adventofcode22.Daysixteen.Node{
  #            name: "AA",
  #            weight: 0,
  #            children: ["DD", "II", "BB"]
  #          }
  # end
end
