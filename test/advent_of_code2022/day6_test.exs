defmodule AdventOfCode2022.Day6Test do
  use ExUnit.Case
  doctest AdventOfCode2022.Day6

  test "solves the puzzle" do
    example = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

    input = File.read!("lib/advent_of_code2022/day6-input.txt")

    assert AdventOfCode2022.Day6.part_1(example) == 7
    assert AdventOfCode2022.Day6.part_1(input) == 1175
    # assert AdventOfCode2022.Day6.part_2(example) == "MCD"
    # assert AdventOfCode2022.Day6.part_2(input) == "BLSGJSDTS"
  end
end
