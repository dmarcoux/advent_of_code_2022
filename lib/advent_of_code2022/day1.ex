defmodule AdventOfCode2022.Day1 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  @doc """
  Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
  """
  def part_1(input) do
    input
    |> elves()
    |> Enum.max()
  end

  @doc """
  Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?
  """
  def part_2(input) do
    input
    |> elves()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elves(input) do
    input
    |> String.split("\n")
    # Create a list of the total calories carried by every elf
    |> Enum.chunk_while(0, &chunk_func/2, &after_func/1)
  end

  defp chunk_func("", total_calories), do: {:cont, total_calories, 0}

  defp chunk_func(calories, total_calories) do
    {:cont, String.to_integer(calories) + total_calories}
  end

  defp after_func(total_calories), do: {:cont, total_calories, 0}
end
