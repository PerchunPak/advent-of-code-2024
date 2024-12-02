import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn sort(a: List(Int)) -> List(Int) {
  list.sort(a, by: int.compare)
}

pub fn solve(a: List(Int), b: List(Int)) -> List(Int) {
  list.map2(sort(a), sort(b), fn(a, b) {
    let min = int.min(a, b)
    let max = int.max(a, b)
    max - min
  })
}

fn to_ints(strings: #(String, String)) -> Result(#(Int, Int), Nil) {
  let #(a, b) = strings
  result.try(result.all([int.parse(a), int.parse(b)]), fn(t) {
    let assert [t1, t2] = t
    Ok(#(t1, t2))
  })
}

pub fn from_table(table: String) -> Result(#(List(Int), List(Int)), Nil) {
  let split = string.split(string.trim(table), "\n")
  use split2 <- result.try(
    list.map(split, fn(line: String) { string.split_once(line, "   ") })
    |> result.all(),
  )

  list.fold(split2, Ok(#([], [])), fn(res, acc) {
    use #(a, b) <- result.try(res)
    use #(a1, b1) <- result.try(to_ints(acc))
    let new_a = list.append(a, [a1])
    let new_b = list.append(b, [b1])
    Ok(#(new_a, new_b))
  })
}

pub fn part_2(inp_a: List(Int), inp_b: List(Int)) -> List(Int) {
  list.map(inp_a, fn(a) { a * list.count(inp_b, fn(x) { x == a }) })
}
