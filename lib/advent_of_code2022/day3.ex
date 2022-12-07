defmodule AdventOfCode2022.Day3 do
  @moduledoc """
  https://adventofcode.com/2022/day/3
  """

  @doc """
  Calculate the priority of items found in both rucksack compartments
  """
  def part_1(input) do
    parse_input(input)
    |> Enum.reduce(_items_priority = 0, fn {first_compartment, second_compartment},
                                           items_priority ->
      [duplicated_item] =
        List.myers_difference(first_compartment, second_compartment)
        |> List.keyfind(:eq, 0)
        |> elem(1)
        |> Enum.uniq()

      items_priority + item_priority(String.to_charlist(duplicated_item))
    end)
  end

  defp parse_input(input) do
    # Create a list of rucksacks
    String.split(input, "\n", trim: true)
    # Create two compartments for every rucksack. The first compartment contains the first half of the rucksack items,
    # the second compartment has the rest.
    |> Enum.map(fn items ->
      items_list = String.graphemes(items)

      Enum.split(items_list, div(length(items_list), 2))
    end)
  end

  # Lowercase items a through z have priorities ranging from 1 through 26.
  # Uppercase items A through Z have priorities ranging from 27 through 52.
  #
  # In Elixir, a character has a code point which we can use this to determine an item's priority.
  # We start at the same priority as defined in the priority ranges above. This is why we need to take the first item
  # code point and the range start into account. using returning the item's code point would not work.
  @spec item_priority(charlist()) :: pos_integer()
  defp item_priority([item]) when item in ?a..?z, do: item - ?a + 1
  defp item_priority([item]) when item in ?A..?Z, do: item - ?A + 27
end
