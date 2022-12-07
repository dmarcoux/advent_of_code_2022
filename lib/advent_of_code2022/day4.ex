defmodule AdventOfCode2022.Day4 do
  @moduledoc """
  https://adventofcode.com/2022/day/4
  """

  @doc """
  Find out how many assignment pairs are redundant, thus containing one pair assignment fully overlapped by the other assignment
  """
  def part_1(input) do
    # Create a list from the pairs of Elves, each pair having their assignments in a nested list
    Regex.scan(~r/^([[:digit:]]+)-([[:digit:]]+),([[:digit:]]+)-([[:digit:]]+)$/m, input,
      capture: :all_but_first
    )
    |> Enum.map(fn assignments -> Enum.map(assignments, &String.to_integer/1) end)
    |> Enum.reduce(
      _redundant_pairs = 0,
      fn
        [first_start, first_end, second_start, second_end], redundant_pairs
        when first_start in second_start..second_end and first_end in second_start..second_end ->
          redundant_pairs + 1

        [first_start, first_end, second_start, second_end], redundant_pairs
        when second_start in first_start..first_end and second_end in first_start..first_end ->
          redundant_pairs + 1

        _, redundant_pairs ->
          redundant_pairs
      end
    )
  end

  @doc """
  Find out how many assignment pairs are partially redundant, thus containing one pair assignment partially overlapped by the other assignment
  """
  def part_2(input) do
    # Create a list from the pairs of Elves, each pair having their assignments in a nested list
    Regex.scan(~r/^([[:digit:]]+)-([[:digit:]]+),([[:digit:]]+)-([[:digit:]]+)$/m, input,
      capture: :all_but_first
    )
    |> Enum.map(fn assignments -> Enum.map(assignments, &String.to_integer/1) end)
    |> Enum.reduce(
      _redundant_pairs = 0,
      fn
        [first_start, first_end, second_start, second_end], redundant_pairs
        when first_start in second_start..second_end or first_end in second_start..second_end ->
          redundant_pairs + 1

        [first_start, first_end, second_start, second_end], redundant_pairs
        when second_start in first_start..first_end or second_end in first_start..first_end ->
          redundant_pairs + 1

        _, redundant_pairs ->
          redundant_pairs
      end
    )
  end
end
