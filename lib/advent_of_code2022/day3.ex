defmodule AdventOfCode2022.Day3 do
  @moduledoc """
  https://adventofcode.com/2022/day/3
  """

  @doc """
  Calculate the priority of items found in both rucksack compartments
  """
  def part_1(input) do
    # Create a list of rucksacks
    String.split(input, "\n", trim: true)
    # Create two compartments for every rucksack. The first compartment contains the first half of the rucksack items,
    # the second compartment has the rest.
    |> Enum.map(fn items ->
      items_list = String.graphemes(items)

      Enum.split(items_list, div(length(items_list), 2))
    end)
    # Calculate the priority of items found in both rucksack compartments
    |> Enum.reduce(_items_priority = 0, fn {first_compartment, second_compartment},
                                           items_priority ->
      [duplicated_item] =
        List.myers_difference(first_compartment, second_compartment)
        |> Keyword.get_values(:eq)
        |> List.flatten()
        |> Enum.uniq()

      items_priority + item_priority(String.to_charlist(duplicated_item))
    end)
  end

  @doc """
  Calculate the priority of the badges for each three-Elf group. A badge is the only item a group has in common.
  """
  def part_2(input) do
    # Create a list of rucksacks
    String.split(input, "\n", trim: true)
    # Group rucksacks in groups of 3
    |> Enum.chunk_every(3)
    # Calculate the priority of badges found in all rucksacks of a group
    |> Enum.reduce(_items_priority = 0, fn [first_rucksack, second_rucksack, third_rucksack],
                                           items_priority ->
      duplicated_items_in_first_and_second =
        MapSet.intersection(
          MapSet.new(String.graphemes(first_rucksack)),
          MapSet.new(String.graphemes(second_rucksack))
        )
        |> MapSet.to_list()

      duplicated_items_in_second_and_third =
        MapSet.intersection(
          MapSet.new(String.graphemes(second_rucksack)),
          MapSet.new(String.graphemes(third_rucksack))
        )
        |> MapSet.to_list()

      duplicated_items_in_first_and_third =
        MapSet.intersection(
          MapSet.new(String.graphemes(first_rucksack)),
          MapSet.new(String.graphemes(third_rucksack))
        )
        |> MapSet.to_list()

      {badge, _frequency} =
        Enum.frequencies(
          duplicated_items_in_first_and_second ++
            duplicated_items_in_second_and_third ++ duplicated_items_in_first_and_third
        )
        |> Enum.max_by(fn {_char, frequency} -> frequency end)

      items_priority + item_priority(String.to_charlist(badge))
    end)
  end

  # Lowercase items a through z have priorities ranging from 1 through 26.
  # Uppercase items A through Z have priorities ranging from 27 through 52.
  #
  # In Elixir, a character has a code point which we can use to determine an item's priority.
  # We start at the same priority as defined in the priority ranges above. This is why we need to take the first item
  # code point and the range start into account.
  @spec item_priority(charlist()) :: pos_integer()
  defp item_priority([item]) when item in ?a..?z, do: item - ?a + 1
  defp item_priority([item]) when item in ?A..?Z, do: item - ?A + 27
end
