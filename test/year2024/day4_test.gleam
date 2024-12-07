import aoc_2024/day_4
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleeunit/should
import simplifile

// pub fn string_to_2d_array_test() -> Nil {
//   day_4.parse(
//     "MMMSXXMASM\n"
//     <> "MSAMXMSMSA\n"
//     <> "AMXSXMAAMM\n"
//     <> "MSAMASMSMX\n"
//     <> "XMASAMXAMM\n"
//     <> "XXAMMXXAMA\n"
//     <> "SMSMSASXSS\n"
//     <> "SAXAMASAAA\n"
//     <> "MAMMMXMMMM\n"
//     <> "MXMXAXMASX\n",
//   )
//   |> should.equal([
//     ["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],
//     ["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],
//     ["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],
//     ["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],
//     ["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],
//     ["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],
//     ["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],
//     ["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],
//     ["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],
//     ["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"],
//   ])
// }

pub fn pt1_example_test() -> Nil {
  day_4.parse(
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
  |> day_4.pt_1()
  |> should.equal(18)
}

pub fn pt1_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2024/inputs/day4.txt")
    |> should.be_ok()

  day_4.parse(content)
  |> day_4.pt_1()
  |> should.equal(2633)
}

pub fn pt2_example_test() -> Nil {
  day_4.parse(
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
  |> day_4.pt_2()
  |> should.equal(9)
}
//pub fn pt2_fr_test() -> Nil {
//  let content =
//    simplifile.read("test/year2024/inputs/day4.txt")
//    |> should.be_ok()
//
//  day_4.parse(content)
//  |> day_4.pt_2()
//  |> should.equal(0)
//}
