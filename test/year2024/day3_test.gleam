import advent_of_code/year2024/day3
import gleam/int
import gleeunit/should
import simplifile

pub fn find_correct_instructions_test() -> Nil {
  day3.part1_find_correct_instructions(
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
  )
  |> should.equal([#(2, 4), #(5, 5), #(11, 8), #(8, 5)])
}

pub fn solve_example_test() -> Nil {
  day3.part1_find_correct_instructions(
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
  )
  |> day3.many_multiply()
  |> should.equal([8, 25, 88, 40])
}

pub fn solve_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2024/inputs/day3.txt")
    |> should.be_ok()

  day3.part1_find_correct_instructions(content)
  |> day3.many_multiply()
  |> int.sum
  |> should.equal(160_672_468)
}

pub fn part2_fci_example_test() -> Nil {
  day3.part2_find_correct_instructions(
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
  )
  |> should.equal([
    day3.Mul(8),
    day3.Dont,
    day3.Mul(25),
    day3.Mul(88),
    day3.Do,
    day3.Mul(40),
  ])
}

pub fn part2_solve_example_test() -> Nil {
  day3.part2_find_correct_instructions(
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
  )
  |> day3.part2_solve()
  |> should.equal([8, 40])
}

pub fn part2_solve_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2024/inputs/day3.txt")
    |> should.be_ok()

  day3.part2_find_correct_instructions(content)
  |> day3.part2_solve()
  |> int.sum()
  |> should.equal(84_893_551)
}
