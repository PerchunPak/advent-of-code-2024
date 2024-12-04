import gleam/int
import gleam/list
import gleam/option
import gleam/pair
import gleam/regexp

pub fn part1_find_correct_instructions(inp: String) -> List(#(Int, Int)) {
  let assert Ok(regex) =
    regexp.from_string("mul\\((\\d\\d?\\d?),(\\d\\d?\\d?)\\)")

  regexp.scan(regex, inp)
  |> list.map(fn(el) {
    let assert [v1, v2] = option.values(el.submatches)
    let assert Ok(i1) = int.parse(v1)
    let assert Ok(i2) = int.parse(v2)
    #(i1, i2)
  })
}

pub fn many_multiply(inp: List(#(Int, Int))) -> List(Int) {
  list.map(inp, fn(v) {
    let #(x, y) = v
    x * y
  })
}

pub type MatchResult {
  Do
  Dont
  Mul(res: Int)
}

pub fn part2_find_correct_instructions(inp: String) -> List(MatchResult) {
  let assert Ok(regex) =
    regexp.from_string(
      "(?:mul\\((\\d\\d?\\d?),(\\d\\d?\\d?)\\))|(?:do\\(\\))|(?:don't\\(\\))",
    )

  regexp.scan(regex, inp)
  |> list.map(fn(el) -> MatchResult {
    case el.content {
      c if c == "do()" -> Do
      c if c == "don't()" -> Dont
      _ -> {
        let assert [v1, v2] = option.values(el.submatches)
        let assert Ok(i1) = int.parse(v1)
        let assert Ok(i2) = int.parse(v2)
        Mul(i1 * i2)
      }
    }
  })
}

pub fn part2_solve(inp: List(MatchResult)) -> List(Int) {
  list.fold(inp, #(True, []), fn(acc, el) -> #(Bool, List(Int)) {
    let #(do, ints) = acc
    case el {
      Do -> #(True, ints)
      Dont -> #(False, ints)
      Mul(_) if !do -> #(False, ints)
      Mul(res) if do -> #(True, list.append(ints, [res]))
      Mul(_) -> panic
    }
  })
  |> pair.second()
}
