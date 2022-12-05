defmodule AdventOfCode2022.Day2 do
  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  @doc """
  Calculate the score from a strategy guide
  """
  def part_1(input) do
    strategy_guide(input)
  end

  defp strategy_guide(input) do
    input
    # Use the same values for the player picks to easily calculate the score
    |> String.replace(
      ["A", "B", "C", "X", "Y", "Z"],
      fn
        pick when pick in ["A", "X"] -> "1"
        pick when pick in ["B", "Y"] -> "2"
        pick when pick in ["C", "Z"] -> "3"
        _ -> ""
      end
    )
    # Create a list of rounds
    |> String.split("\n", trim: true)
    # Create a list for the picks of every round
    |> Enum.map(&String.split/1)
  end
end
