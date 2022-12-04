defmodule AdventOfCode2022.Day1 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  @doc """
  Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
  """
  def part_1 do
    elves()
    |> Enum.take(1)
  end

  @doc """
  Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?
  """
  def part_2 do
    elves()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elves do
    "lib/advent_of_code2022/day1-input.txt"
    # Read the input file line by line
    |> File.stream!()
    # Remove all leading and trailing whitespaces
    |> Stream.map(&String.trim/1)
    # Create a list of the total calories carried by every elf
    |> Stream.chunk_while(0, &chunk_func/2, &after_func/1)
    # Sort the total calories in descending order
    |> Enum.sort(:desc)
  end

  defp chunk_func("", accumulator), do: {:cont, accumulator, 0}
  defp chunk_func(calories, accumulator), do: {:cont, String.to_integer(calories) + accumulator}

  defp after_func(accumulator), do: {:cont, accumulator, 0}
end
