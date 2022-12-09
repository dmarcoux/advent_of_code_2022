defmodule AdventOfCode2022.Day5 do
  @moduledoc """
  https://adventofcode.com/2022/day/5
  """

  @doc """
  Find out which crate ends up on top of each stack
  """
  def part_1(input) do
    {stack_identifiers, stack_rows} = stack_identifiers_and_rows(input)

    stacks(stack_identifiers)
    |> IO.inspect()

    crates(stack_rows)
    |> IO.inspect()

    # TODO: Figure out how to put crates into stacks
    # # Add the crates to their respective stack, but this doesn't work since it's not changing `stacks` (obviously, this is funcitonal programming...)
    # crates
    # |> Enum.with_index()
    # |> Enum.each(fn {index, crate} ->
    #   # TODO: skip if crate is an empty string
    #   Map.get_and_update(stacks, :"#{index}", fn stack_crates ->
    #     {stack_crates, [crate | stack_crates]}
    #   end)
    # end)

    move_instructions(input)
    |> IO.inspect()
  end

  # Retrieve stacks of crates from a puzzle input
  defp stack_identifiers_and_rows(puzzle_input) do
    # Remove from the puzzle input everything but the stacks of crates string
    {[stack_identifiers], stack_rows} =
      String.split(puzzle_input, "\n\n")
      |> List.first()
      # Create a list of lines from the stacks of crates string
      |> String.split("\n")
      # Reverse the list of lines to parse the stack of crates from bottom to top
      |> Enum.reverse()
      # Split the list of lines into two lists, one with the stack identifiers and the other with the rows of crates forming the stacks
      |> Enum.split(1)

    # FIXME: There must be a better way to do this, repeating almost the exact same tuple only to get rid of the list for stack_identifiers
    {stack_identifiers, stack_rows}
  end

  # Create a map containing the stacks, each key-value pair representing a stack of crates.
  # The key is the stack identifier while the value is an empty list of crates in the stack.
  defp stacks(stack_identifiers) do
    String.split(stack_identifiers, " ", trim: true)
    |> Map.new(fn stack_identifier -> {stack_identifier, []} end)
  end

  # Create a list containing a nested list of crates
  defp crates(stack_rows) do
    Enum.map(stack_rows, fn stack_row ->
      # Every stack row might have a crate on every fourth character starting from the second character
      #
      # Example of a stack row: "[A] [B] [C]", "    [E] [F]" or "    [B]    "
      #   Shorter or longer strings with different combinations are possible.
      String.graphemes(stack_row)
      # The first character is either a space or `[`, so it can be dropped before the crates are taken
      |> Enum.drop(1)
      |> Enum.take_every(4)
    end)
  end

  # Retrieve move instructions from a puzzle input
  #
  # Example output: [%{"destination" => "1", "move_count" => "1", "origin" => "2"}]
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
