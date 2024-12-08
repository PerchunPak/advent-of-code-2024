import advent_of_code/year2024/day4
import gleeunit/should
import simplifile

pub fn pt1_example_test() -> Nil {
  day4.parse(
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
  |> day4.pt_1()
  |> should.equal(18)
}

pub fn pt1_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2024/inputs/day4.txt")
    |> should.be_ok()

  day4.parse(content)
  |> day4.pt_1()
  |> should.equal(2633)
}

pub fn pt2_example_test() -> Nil {
  day4.parse(
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
  |> day4.pt_2()
  |> should.equal(9)
}

pub fn pt2_fr_test() -> Nil {
  let content =
    simplifile.read("test/year2024/inputs/day4.txt")
    |> should.be_ok()

  day4.parse(content)
  |> day4.pt_2()
  |> should.equal(1936)
}
