defmodule AdventOfCode2022.Day5Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day5

  test "solves the puzzle" do
    example = """
        [D]    
    [N] [C]    
    [Z] [M] [P]
     1   2   3 

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    input = File.read!("lib/advent_of_code2022/day5-input.txt")

    assert AdventOfCode2022.Day5.part_1(example) == "CMZ"
    assert AdventOfCode2022.Day5.part_1(input) == "WCZTHTMPS"
    assert AdventOfCode2022.Day5.part_2(example) == "MCD"
    assert AdventOfCode2022.Day5.part_2(input) == "BLSGJSDTS"
  end
end
