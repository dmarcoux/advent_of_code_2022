defmodule AdventOfCode2022.Day4Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day4

  test "solves the puzzle" do
    example = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """

    input = File.read!("lib/advent_of_code2022/day4-input.txt")

    assert AdventOfCode2022.Day4.part_1(example) == 2
    assert AdventOfCode2022.Day4.part_1(input) == 305
    assert AdventOfCode2022.Day4.part_2(example) == 4
    assert AdventOfCode2022.Day4.part_2(input) == 811
  end
end
