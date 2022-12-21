defmodule Adventofcode22.DaytwentyoneTest do
  use ExUnit.Case

  test "parses a line with deps correctly" do
    line = "cczh: sllz + lgvd"
    expected = {"cczh", {"sllz", :+, "lgvd"}}
    actual = Adventofcode22.Daytwentyone.parse_line(line)
    assert expected == actual
  end

  test "parses a line without deps correctly" do
    line = "dbpl: 5"
    expected = {"dbpl", 5}
    actual = Adventofcode22.Daytwentyone.parse_line(line)
    assert expected == actual
  end

  test "parses the entire input correctly" do
    data = File.read!("input/21_easy.txt")
    actual = Adventofcode22.Daytwentyone.parse_input(data)
    expected = %{
      "cczh" => {"sllz", :+, "lgvd"},
      "dbpl" => 5,
      "drzm" => {"hmdt", :-, "zczc"},
      "dvpt" => 3,
      "hmdt" => 32,
      "humn" => 5,
      "lfqf" => 4,
      "lgvd" => {"ljgn", :*, "ptdq"},
      "ljgn" => 2,
      "pppw" => {"cczh", :/, "lfqf"},
      "ptdq" => {"humn", :-, "dvpt"},
      "root" => {"pppw", :+, "sjmn"},
      "sjmn" => {"drzm", :*, "dbpl"},
      "sllz" => 4,
      "zczc" => 2
    }
    assert expected == actual
  end

  test "works for the example" do
    data = File.read!("input/21_easy.txt")
    actual = Adventofcode22.Daytwentyone.part_one(data)
    expected = 152
    assert expected == actual
  end

  test "works for the real" do
    data = File.read!("input/21.txt")
    actual = Adventofcode22.Daytwentyone.part_one(data)
    expected = 152
    assert expected == actual
  end
end
