import gleam/int
import gleam/list
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

pub fn solve_part_2(table: List(List(Int))) -> List(Result(Bool, String)) {
  list.map(table, fn(x) {
    list.try_fold(x, #(-1, "", False), fn(acc, i) {
      let #(prev, order, failed_before) = acc
      let debug_str =
        "\nprev: "
        |> string.append(int.to_string(prev))
        |> string.append("; order: " <> order <> "; i: ")
        |> string.append(int.to_string(i))

      case prev {
        -1 -> Ok(#(i, order, failed_before))
        _ ->
          case difference(prev, i) {
            diff if 1 <= diff && diff <= 3 -> {
              case order, prev - i > 0 {
                "", True -> Ok(#(i, "+", failed_before))
                "", False -> Ok(#(i, "-", failed_before))
                "+", True -> Ok(#(i, "+", failed_before))
                "+", False -> {
                  case failed_before {
                    False -> Ok(#(prev, order, True))
                    True -> Error("unsafe")
                  }
                }
                "-", True -> {
                  case failed_before {
                    False -> Ok(#(prev, order, True))
                    True -> Error("unsafe")
                  }
                }
                "-", False -> Ok(#(i, "-", failed_before))
                _, _ -> Error("unhandled order: " <> debug_str)
              }
            }
            diff -> {
              case failed_before {
                False -> Ok(#(prev, order, True))
                True ->
                  Error(
                    "Too big difference: " <> int.to_string(diff) <> debug_str,
                  )
              }
            }
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
