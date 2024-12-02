import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

pub fn from_table(table: String) -> Result(List(List(Int)), Nil) {
  let split = string.split(string.trim(table), "\n")
  let split2 = list.map(split, fn(line: String) { string.split(line, " ") })

  list.map(split2, fn(x) {
    //
    list.map(x, int.parse)
    |> result.all()
  })
  |> result.all()
}

fn difference(a: Int, b: Int) -> Int {
  int.max(a, b) - int.min(a, b)
}

pub fn solve(table: List(List(Int))) -> List(Result(Bool, String)) {
  list.map(table, fn(x) {
    list.try_fold(x, #(-1, ""), fn(acc, i) {
      let #(prev, order) = acc
      let debug_str =
        "\nprev: "
        |> string.append(int.to_string(prev))
        |> string.append("; order: " <> order <> "; i: ")
        |> string.append(int.to_string(i))

      case prev {
        -1 -> Ok(#(i, order))
        _ ->
          case difference(prev, i) {
            diff if 1 <= diff && diff <= 3 -> {
              case order, prev - i > 0 {
                "", True -> Ok(#(i, "+"))
                "", False -> Ok(#(i, "-"))
                "+", True -> Ok(#(i, "+"))
                "+", False -> Error("unsafe")
                "-", True -> Error("unsafe")
                "-", False -> Ok(#(i, "-"))
                _, _ -> Error("unhandled order: " <> debug_str)
              }
            }
            diff ->
              Error("Too big difference: " <> int.to_string(diff) <> debug_str)
          }
      }
    })
  })
  |> list.map(fn(x) {
    case x {
      Ok(_) -> Ok(True)
      Error(a) -> {
        let invalid_input = string.starts_with(a, "unhandled order")
        case a {
          a if invalid_input -> Error(a)
          _ -> Ok(False)
        }
      }
    }
  })
}

pub type Order {
  Ascending
  Descending
}

pub type ResultPart2 {
  ResultPart2(prev: Int, order: Option(Order), failed_before: Bool)
}

pub fn solve_part_2(table: List(List(Int))) -> List(Bool) {
  list.map(table, fn(x) {
    io.debug("===================")
    io.debug(x)
    io.debug(list.try_fold(x, ResultPart2(-1, None, False), fn(res, i) {
      io.debug(res)
      io.debug(int.to_string(i) <> " " <> int.to_string(difference(res.prev, i)))
      case res.prev {
        -1 -> Ok(ResultPart2(..res, prev: i))
        _ ->
          case difference(res.prev, i) {
            diff if 1 <= diff && diff <= 3 -> {
              case res.order, res.prev - i > 0 {
                None, True ->
                  Ok(ResultPart2(i, Some(Descending), res.failed_before))
                None, False ->
                  Ok(ResultPart2(i, Some(Ascending), res.failed_before))
                Some(Descending), True -> Ok(ResultPart2(..res, prev: i))
                Some(Descending), False -> {
                  case res.failed_before {
                    False -> Ok(ResultPart2(..res, failed_before: True))
                    True -> Error(Nil)
                  }
                }
                Some(Ascending), True -> {
                  case res.failed_before {
                    False -> Ok(ResultPart2(..res, failed_before: True))
                    True -> Error(Nil)
                  }
                }
                Some(Ascending), False ->
                  Ok(ResultPart2(i, Some(Ascending), res.failed_before))
              }
            }
            _ -> {
              case res.failed_before {
                False -> Ok(ResultPart2(..res, failed_before: True))
                True -> Error(Nil)
              }
            }
          }
      }
    }))
  })
  |> list.map(fn(x) {
    case x {
      Ok(_) -> True
      Error(_) -> False
    }
  })
}
