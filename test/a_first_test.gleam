import advent_of_code/a_first
import gleam/int
import gleeunit/should
import simplifile

// gleeunit test functions end in `_test`
pub fn from_table_test() {
  a_first.from_table("3   4\n4   3\n2   5\n1   3\n3   9\n3   3")
  |> should.equal(Ok(#([3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3])))
}

pub fn from_table_non_int_test() {
  a_first.from_table("int   4\n4   3\n2   5\n1   3\n3   9\n3   3")
  |> should.equal(Error(Nil))
}

pub fn solve_example_test() {
  let #(a, b) =
    a_first.from_table("3   4\n4   3\n2   5\n1   3\n3   9\n3   3")
    |> should.be_ok()

  a_first.solve(a, b)
  |> should.equal([2, 1, 0, 1, 2, 5])
}

pub fn solve_fr_test() {
  let content =
    simplifile.read("test/inputs/a_first.txt")
    |> should.be_ok()

  let #(a, b) =
    a_first.from_table(content)
    |> should.be_ok()

  a_first.solve(a, b)
  |> int.sum()
  |> should.equal(2_196_996)
}

pub fn part_2_example_test() {
  let #(a, b) =
    a_first.from_table("3   4\n4   3\n2   5\n1   3\n3   9\n3   3")
    |> should.be_ok()

  a_first.part_2(a, b)
  |> should.equal([9, 4, 0, 0, 9, 9])
}

pub fn part_2_fr_test() {
  let content =
    simplifile.read("test/inputs/a_first.txt")
    |> should.be_ok()

  let #(a, b) =
    a_first.from_table(content)
    |> should.be_ok()

  a_first.part_2(a, b)
  |> int.sum()
  |> should.equal(23_655_822)
}
