defmodule Adventofcode22.Dayeleven do
  def part_one(data) do
    data
    |> Enum.map(fn chunk ->
      chunk
      |> String.split("\n")
      |> process_chunk()
    end)
    |> Enum.map(&convert_to_monkey/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {monkey, index}, acc ->
      Map.put(acc, index, monkey)
    end)
    |> simulate(20, fn x -> div(x, 3) end)
    |> Enum.map(fn {_, monkey} -> monkey.turn_count end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.product()
  end

  def part_two(data) do
    monkeys =
      data
      |> Enum.map(fn chunk ->
        chunk
        |> String.split("\n")
        |> process_chunk()
      end)
      |> Enum.map(&convert_to_monkey/1)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {monkey, index}, acc ->
        Map.put(acc, index, monkey)
      end)

    lcm = monkeys |> Enum.map(fn {_, monkey} -> monkey.test end) |> Enum.product()

    monkeys
    |> simulate(10000, &rem(&1, lcm))
    |> Enum.map(fn {_, monkey} -> monkey.turn_count end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.product()
  end

  def process_chunk(chunk) do
    chunk
    |> Enum.drop(1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line ->
      process_line(line)
    end)
  end

  def convert_to_monkey([holding, operation, test, true_nxt, false_nxt]) do
    %{
      holding: holding,
      operation: operation,
      test: test,
      true_nxt: true_nxt,
      false_nxt: false_nxt,
      turn_count: 0
    }
  end

  def simulate(monkeys, rounds, adjust_fn) do
    monkey_count = Enum.count(monkeys)

    Enum.reduce(1..rounds, monkeys, fn _round, monkeys ->
      res = simulate_round(monkeys, monkey_count, adjust_fn)
      # holdings = Enum.map(monkeys, fn {_, monkey} -> monkey.holding end)
      # IO.puts("Round: " <> inspect(round))
      # IO.inspect(holdings, label: "Holdings: ", charlists: :as_lists)
      res
    end)
  end

  def simulate_round(monkeys, total_monkeys, adjust_fn) do
    Enum.reduce(0..(total_monkeys - 1), monkeys, fn monkey_pos, acc ->
      simulate_monkey(monkey_pos, acc, adjust_fn)
    end)
  end

  def simulate_monkey(monkey_pos, monkeys, adjust_fn) do
    current_monkey = Map.get(monkeys, monkey_pos)

    res =
      Enum.reduce(current_monkey.holding, monkeys, fn item, acc ->
        current_monkey = Map.get(acc, monkey_pos)

        worry = current_monkey.operation.(item) |> adjust_fn.()

        next_monkey_pos =
          if rem(worry, current_monkey.test) == 0 do
            current_monkey.true_nxt
          else
            current_monkey.false_nxt
          end

        next_monkey = Map.get(acc, next_monkey_pos)

        prev_monkey_holding = next_monkey.holding ++ [worry]
        next_monkey = %{next_monkey | holding: prev_monkey_holding}
        new_holding_for_current_monkey = Enum.drop(current_monkey.holding, 1)
        current_monkey = %{current_monkey | holding: new_holding_for_current_monkey}
        current_monkey = %{current_monkey | turn_count: current_monkey.turn_count + 1}

        acc = Map.update!(acc, next_monkey_pos, fn _ -> next_monkey end)
        acc = Map.update!(acc, monkey_pos, fn _ -> current_monkey end)
        acc
      end)

    res
  end

  def process_line("Starting items: " <> items_raw) do
    state =
      items_raw
      |> String.split(", ")
      |> Enum.map(fn item ->
        item
        |> String.trim()
        |> Integer.parse()
      end)

    res = state |> Enum.map(fn {value, _} -> value end)

    res
  end

  def process_line("Operation: new = old * " <> factor) when factor != "old" do
    factor = String.to_integer(factor)
    fn old -> old * factor end
  end

  def process_line("Operation: new = old + " <> factor) do
    factor = String.to_integer(factor)
    fn old -> old + factor end
  end

  def process_line("Operation: new = old * old") do
    fn old -> old * old end
  end

  def process_line("Test: divisible by " <> divisor) do
    String.to_integer(divisor)
  end

  def process_line("If true: throw to monkey " <> monkey) do
    String.to_integer(monkey)
  end

  def process_line("If false: throw to monkey " <> monkey) do
    String.to_integer(monkey)
  end
end
