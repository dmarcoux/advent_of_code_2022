defmodule AdventOfCode2022.Day1Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day1

  test "calculates the score of a strategy guide" do
    example = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    input = File.read!("lib/advent_of_code2022/day1-input.txt")

    assert AdventOfCode2022.Day1.part_1(example) == 24_000
    assert AdventOfCode2022.Day1.part_1(input) == 71_506
    assert AdventOfCode2022.Day1.part_2(example) == 45_000
    assert AdventOfCode2022.Day1.part_2(input) == 209_603
  end
end
