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
    expected = {"dbpl", "5"}
    actual = Adventofcode22.Daytwentyone.parse_line(line)
    assert expected == actual
  end
end
