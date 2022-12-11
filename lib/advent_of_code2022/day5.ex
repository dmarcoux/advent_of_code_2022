defmodule AdventOfCode2022.Day5 do
  @moduledoc """
  https://adventofcode.com/2022/day/5
  """

  @doc """
  Find out which crate ends up on top of each stack.
  In a move instruction, crates are moved one by one.
  """
  def part_1(input) do
    stack_rows(input)
    |> initialize_stacks()
    |> move_crates(move_instructions(input), &Enum.reverse/1)
    |> retrieve_top_crates()
  end

  @doc """
  Find out which crate ends up on top of each stack.
  In a move instruction, crates are moved together as a group and keep their group order.
  """
  def part_2(input) do
    stack_rows(input)
    |> initialize_stacks()
    |> move_crates(move_instructions(input), fn crates -> crates end)
    |> retrieve_top_crates()
  end

  # Retrieve stack rows from a puzzle input
  defp stack_rows(puzzle_input) do
    # Keep only the part of the string which contains the stack identifiers and rows
    String.split(puzzle_input, "\n\n")
    |> List.first()
    # Create a list of lines from the string
    |> String.split("\n")
    # Split the list of lines into two lists, one with the stack identifiers and the other with the rows of crates
    # forming the stacks
    |> Enum.split(-1)
    # Keep only the stack rows, the stack identifiers are dropped
    |> elem(0)
  end

  # Create a map containing the stacks, each key-value pair representing a stack of crates.
  # The key is the stack identifier while the value is a list of the crates in the stack.
  defp initialize_stacks(stack_rows) do
    # Parse every stack row to retrieve its crates
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
    # Group the crates per stack
    |> List.zip()
    |> Enum.with_index()
    |> Map.new(fn {crates, index} ->
      {
        "#{index + 1}",
        # Drop elements which don't refer to an actual crate
        Tuple.to_list(crates)
        |> Enum.reject(fn crate -> crate == " " end)
      }
    end)
  end

  # Retrieve move instructions from a puzzle input
  #
  # Example output: [%{"destination" => "1", "amount" => "1", "origin" => "2"}]
  defp move_instructions(puzzle_input) do
    # Remove from the puzzle input everything but the move instructions string
    String.split(puzzle_input, "\n\n")
    |> List.last()
    # Turn the move instructions string into a list of maps describing each move instruction
    |> String.split("\n", trim: true)
    |> Enum.map(fn move_instruction ->
      Regex.named_captures(
        ~r/^move (?<amount>\d+) from (?<origin>\d+) to (?<destination>\d+)$/,
        move_instruction
      )
    end)
  end

  # Move crates, with the given function, from one stack to another recursively
  defp move_crates(stacks, [], _move_function), do: stacks

  defp move_crates(stacks, [move], move_function) do
    crates_in_destination = stacks[move["destination"]]

    {new_crates_in_destination, remaining_crates_in_origin} =
      Enum.split(stacks[move["origin"]], String.to_integer(move["amount"]))

    %{
      stacks
      | "#{move["origin"]}" => remaining_crates_in_origin,
        "#{move["destination"]}" =>
          move_function.(new_crates_in_destination) ++ crates_in_destination
    }
  end

  defp move_crates(stacks, [move | other_moves], move_function) do
    move_crates(stacks, [move], move_function)
    |> move_crates(other_moves, move_function)
  end

  # Retrieve the top crate of every stack and concat them before they are returned
  defp retrieve_top_crates(crates) do
    Enum.reduce(crates, "", fn {_stack_identifier, crates_stack}, all_top_crates ->
      all_top_crates <> List.first(crates_stack)
    end)
  end
end
