defmodule AdventOfCode2022.Day6 do
  @moduledoc """
  https://adventofcode.com/2022/day/6
  """

  @doc """
    Return how many characters need to be processed in the datastream before the first start-of-packet marker is detected?
    A start-of-packet marker is indicated by a sequence of four characters that are all different.
  """
  def part_1(datastream) do
    String.graphemes(datastream)
    |> Enum.with_index()
    |> Enum.reduce_while(_previous_characters = [], &process_datastream/2)
  end

  # The first start-of-packet marker was found
  defp process_datastream({_character, index}, previous_characters)
       when is_list(previous_characters) and length(previous_characters) == 4 do
    {:halt, index}
  end

  defp process_datastream({character, index}, previous_characters)
       when is_list(previous_characters) and length(previous_characters) < 4 do
    if character in previous_characters do
      # Start again...
      {:cont, [character]}
    else
      # Keep looking...
      {:cont, [character | previous_characters]}
    end
  end
end
