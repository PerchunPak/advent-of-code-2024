import advent_of_code/year2024/day4
import gleam/dict
import gleam/int
import gleam/list
import gleeunit/should

pub fn string_to_2d_array_test() -> Nil {
  day4.string_to_2d_array(
    "MMMSXXMASM\n"
    <> "MSAMXMSMSA\n"
    <> "AMXSXMAAMM\n"
    <> "MSAMASMSMX\n"
    <> "XMASAMXAMM\n"
    <> "XXAMMXXAMA\n"
    <> "SMSMSASXSS\n"
    <> "SAXAMASAAA\n"
    <> "MAMMMXMMMM\n"
    <> "MXMXAXMASX\n",
  )
  |> should.equal([
    ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
    ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
    ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
    ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
    ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
    ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
    ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
    ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
    ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"],
  ])
}

pub fn count_xmas_example_test() -> Nil {
  [
    ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
    ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
    ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
    ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
    ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
    ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
    ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
    ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
    ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
    ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"],
  ]
  |> day4.find_xmas()
  |> list.length()
  |> should.equal(18)
}
