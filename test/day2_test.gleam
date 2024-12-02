import advent_of_code/day2
import gleam/list
import gleam/result
import gleeunit/should
import simplifile

pub fn from_table_test() {
  day2.from_table(
    "7 6 4 2 1\n"
    <> "1 2 7 8 9\n"
    <> "9 7 6 2 1\n"
    <> "1 3 2 4 5\n"
    <> "8 6 4 4 1\n"
    <> "1 3 6 7 9\n",
  )
  |> should.be_ok()
  |> should.equal([
    [7, 6, 4, 2, 1],
    [1, 2, 7, 8, 9],
    [9, 7, 6, 2, 1],
    [1, 3, 2, 4, 5],
    [8, 6, 4, 4, 1],
    [1, 3, 6, 7, 9],
  ])
}

pub fn solve_example_test() {
  let table =
    day2.from_table(
      "7 6 4 2 1\n"
      <> "1 2 7 8 9\n"
      <> "9 7 6 2 1\n"
      <> "1 3 2 4 5\n"
      <> "8 6 4 4 1\n"
      <> "1 3 6 7 9\n",
    )
    |> should.be_ok()

  day2.solve(table)
  |> should.equal([
    Ok(True),
    Ok(False),
    Ok(False),
    Ok(False),
    Ok(False),
    Ok(True),
  ])
}

pub fn solve_fr_test() {
  let content =
    simplifile.read("test/inputs/day2.txt")
    |> should.be_ok()

  let table =
    day2.from_table(content)
    |> should.be_ok()

  day2.solve(table)
  |> result.all()
  |> should.be_ok()
  |> list.count(fn(x) { x })
  |> should.equal(606)
}

pub fn solve_part2_example_test() {
  let table =
    day2.from_table(
      "7 6 4 2 1\n"
      <> "1 2 7 8 9\n"
      <> "9 7 6 2 1\n"
      <> "1 3 2 4 5\n"
      <> "8 6 4 4 1\n"
      <> "1 3 6 7 9\n",
    )
    |> should.be_ok()

  day2.solve_part_2(table)
  |> should.equal([
    //
    Ok(True),
    Ok(False),
    Ok(False),
    Ok(True),
    Ok(True),
    Ok(True),
  ])
}

pub fn solve_part2_fr_test() {
  let content =
    simplifile.read("test/inputs/day2.txt")
    |> should.be_ok()

  let table =
    day2.from_table(content)
    |> should.be_ok()

  day2.solve_part_2(table)
  |> result.all()
  |> should.be_ok()
  |> list.count(fn(x) { x })
  |> should.equal(606)
}
