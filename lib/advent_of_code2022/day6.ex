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
    |> Enum.reduce_while(_previous_characters = [], fn character_with_index,
                                                       previous_characters ->
      find_first_marker(character_with_index, previous_characters, _marker_length = 4)
    end)
  end

  @doc """
    Return how many characters need to be processed in the datastream before the first start-of-message marker is detected?
    A start-of-message marker is indicated by a sequence of fourteen characters that are all different.
  """
  def part_2(datastream) do
    String.graphemes(datastream)
    |> Enum.with_index()
    |> Enum.reduce_while(_previous_characters = [], fn character_with_index,
                                                       previous_characters ->
      find_first_marker(character_with_index, previous_characters, _marker_length = 14)
    end)
  end

  # The first marker was found
  defp find_first_marker({_character, index}, previous_characters, marker_length)
       when is_list(previous_characters) and length(previous_characters) == marker_length do
    {:halt, index}
  end

  defp find_first_marker({character, _index}, previous_characters, marker_length)
       when is_list(previous_characters) and length(previous_characters) < marker_length do
    if character in previous_characters do
      # Start again...
      remaining_characters =
        Enum.take_while(previous_characters, fn previous_character ->
          previous_character != character
        end)

      {:cont, [character | remaining_characters]}
    else
      # Keep looking...
      {:cont, [character | previous_characters]}
    end
  end
end
