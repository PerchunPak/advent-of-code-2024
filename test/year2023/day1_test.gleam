import advent_of_code/year2023/day1
import gleam/int
import gleeunit/should
import simplifile

pub fn solve_example_test() -> Nil {
  day1.solve("1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet")
  |> should.equal([12, 38, 15, 77])
}

pub fn solve_example2_test() -> Nil {
  day1.solve("abcde")
  |> should.equal([])
}

pub fn solve_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2023/inputs/day1.txt")
    |> should.be_ok()

  day1.solve(content)
  |> int.sum
  |> should.equal(52_974)
}

pub fn solve_part2_example_test() -> Nil {
  day1.solve_part2(
    "two1nine\n"
    <> "eightwothree\n"
    <> "abcone2threexyz\n"
    <> "xtwone3four\n"
    <> "4nineeightseven2\n"
    <> "zoneight234\n"
    <> "7pqrstsixteen\n",
  )
  |> should.equal([29, 83, 13, 24, 42, 14, 76])
}

pub fn solve_part2_example2_test() -> Nil {
  day1.solve_part2("abcde")
  |> should.equal([])
}

pub fn solve_part2_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2023/inputs/day1.txt")
    |> should.be_ok()

  day1.solve_part2(content)
  |> int.sum
  |> should.equal(0)
}
