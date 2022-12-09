defmodule AdventOfCode2022.Day5 do
  @moduledoc """
  https://adventofcode.com/2022/day/5
  """

  @doc """
  Find out which crate ends up on top of each stack
  """
  def part_1(input) do
    input
    |> IO.inspect()

    stacks_of_crates(input)

    move_instructions(input)
    |> IO.inspect()
  end

  # Retrieve stacks of crates from a puzzle input
  defp stacks_of_crates(puzzle_input) do
    # Remove from the puzzle input everything but the stacks of crates string
    {[stack_identifiers], stacks} =
      String.split(puzzle_input, "\n\n")
      |> List.first()
      # Create a list of lines from the stacks of crates string
      |> String.split("\n")
      # Reverse the list of lines to parse the stack of crates from bottom to top
      |> Enum.reverse()
      # Split the list of lines into two lists, one with the stack identifiers and the other with the stacks of crates
      |> Enum.split(1)

    IO.inspect(stacks)
    IO.inspect(stack_identifiers)

    # Create a map containing the stacks, each key-value pair representing a stack of crates.
    # The key is the stack identifier while the value is a list of crates in the stack.
    String.split(stack_identifiers, " ", trim: true)
    |> Map.new(fn stack_identifier -> {stack_identifier, []} end)

    # pseudo code
    #
    # add crates to their respective stack starting with the bottom crates -> Probably with Regex
  end

  # Retrieve move instructions from a puzzle input
  #
  # Example output: [%{"destination" => "1", "move_count" => "1", "origin" => "2"}, %{"destination" => "3", "move_count" => "3", "origin" => "1"}]
  defp move_instructions(puzzle_input) do
    # Remove from the puzzle input everything but the move instructions string
    String.split(puzzle_input, "\n\n")
    |> List.last()
    # Turn the move instructions string into a list of maps describing each move instruction
    |> String.split("\n", trim: true)
    |> Enum.map(fn move_instruction ->
      Regex.named_captures(
        ~r/^move (?<move_count>\d+) from (?<origin>\d+) to (?<destination>\d+)$/,
        move_instruction
      )
    end)
  end
end
