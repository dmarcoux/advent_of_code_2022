defmodule AdventOfCode2022.Day2Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day2

  test "calculates the score of a strategy guide" do
    example = """
    A Y
    B X
    C Z
    """

    input = File.read!("lib/advent_of_code2022/day2-input.txt")

    assert AdventOfCode2022.Day2.part_1(example) == 15
    assert AdventOfCode2022.Day2.part_1(input) == 8890
  end
end
