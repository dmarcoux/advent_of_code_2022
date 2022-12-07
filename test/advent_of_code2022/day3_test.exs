defmodule AdventOfCode2022.Day3Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day3

  test "solves the puzzle" do
    example = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

    input = File.read!("lib/advent_of_code2022/day3-input.txt")

    assert AdventOfCode2022.Day3.part_1(example) == 157
    assert AdventOfCode2022.Day3.part_1(input) == 8109
    # assert AdventOfCode2022.Day3.part_2(example) == 12
    # assert AdventOfCode2022.Day3.part_2(input) == 10_238
  end
end
