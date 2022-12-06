defmodule AdventOfCode2022.Day2 do
  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  @rock 1
  @paper 2
  @scissors 3

  @win_score 6
  @draw_score 3

  @doc """
  Calculate the score from a strategy guide
  """
  def part_1(input) do
    part_1_strategy_guide(input)
    |> Enum.reduce(_total_score = 0,
      fn
        # Rock wins over scissors, so I win!
        [ _other_pick = @scissors, my_pick = @rock ], total_score ->
          total_score + my_pick + @win_score

        # Paper wins over rock, so I win!
        [ _other_pick = @rock, my_pick = @paper ], total_score ->
          total_score + my_pick + @win_score

        # Scissors wins over paper, so I win!
        [ _other_pick = @paper, my_pick = @scissors ], total_score ->
          total_score + my_pick + @win_score

        # Both picks are the same, this is a draw
        [same_pick, same_pick], total_score ->
          total_score + same_pick + @draw_score

        # Everything else is a loss... no!!!
        [ _, my_pick ], total_score ->
          total_score + my_pick
      end
    )
  end

  defp part_1_strategy_guide(input) do
    input
    # Use the same values for the player picks to easily calculate the score
    |> String.replace(
      ["A", "B", "C", "X", "Y", "Z"],
      fn
        pick when pick in ["A", "X"] -> "#{@rock}"
        pick when pick in ["B", "Y"] -> "#{@paper}"
        pick when pick in ["C", "Z"] -> "#{@scissors}"
        _ -> ""
      end
    )
    # Create a list of rounds
    |> String.split("\n", trim: true)
    # Create a list for the picks of every round
    |> Enum.map(fn picks ->
      picks
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Calculate the score of the picks to choose in order to correctly follow the strategy guide
  """
  def part_2(input) do
    part_2_strategy_guide(input)
    |> Enum.reduce(_total_score = 0,
      fn
        # Rock wins over scissors, so I win!
        [ _other_pick = @scissors, my_pick = @rock ], total_score ->
          total_score + my_pick + @win_score

        # Paper wins over rock, so I win!
        [ _other_pick = @rock, my_pick = @paper ], total_score ->
          total_score + my_pick + @win_score

        # Scissors wins over paper, so I win!
        [ _other_pick = @paper, my_pick = @scissors ], total_score ->
          total_score + my_pick + @win_score

        # Both picks are the same, this is a draw
        [same_pick, same_pick], total_score ->
          total_score + same_pick + @draw_score

        # Everything else is a loss... no!!!
        [ _, my_pick ], total_score ->
          total_score + my_pick
      end
    )
  end

  defp part_2_strategy_guide(input) do
    input
    # Figure out the right pick to follow the strategy guide
    |> String.replace(
      ["A X", "A Y", "A Z", "B X", "B Y", "B Z", "C X", "C Y", "C Z"],
      fn
        "A X" -> "#{@rock} #{@scissors}"
        "A Y" -> "#{@rock} #{@rock}"
        "A Z" -> "#{@rock} #{@paper}"
        "B X" -> "#{@paper} #{@rock}"
        "B Y" -> "#{@paper} #{@paper}"
        "B Z" -> "#{@paper} #{@scissors}"
        "C X" -> "#{@scissors} #{@paper}"
        "C Y" -> "#{@scissors} #{@scissors}"
        "C Z" -> "#{@scissors} #{@rock}"
        _ -> ""
      end
    )
    # Create a list of rounds
    |> String.split("\n", trim: true)
    # Create a list for the picks of every round
    |> Enum.map(fn picks ->
      picks
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
