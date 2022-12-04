defmodule AdventOfCode2022.Day1 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  def part_1 do
    elves()
    |> Enum.take(1)
  end

  def part_2 do
    elves()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elves do
    "lib/advent_of_code2022/day1-input.txt"
    |> File.stream!() # Read the input file line by line
    |> Enum.map(&String.trim/1) # Remove all leading and trailing whitespaces
    |> Enum.chunk_while([], &chunk_func/2, &after_func/1) # Create a list of nested lists containing the calories of every elf
    |> Enum.map(&Enum.sum/1) # Calculate the sum of calories for every elf
    |> Enum.sort(:desc) # Sort the elves based on their calories total
  end

  defp chunk_func(_separator = "", accumulator), do: { :cont, accumulator, [] }
  defp chunk_func(calories, accumulator), do: { :cont, [ String.to_integer(calories) | accumulator ] }

  defp after_func([]), do: { :cont, [] }
  defp after_func(accumulator), do: { :cont, accumulator, [] }
end
