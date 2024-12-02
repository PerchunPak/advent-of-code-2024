import gleam/int
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

pub type Order {
  Ascending
  Descending
}

pub type Solution {
  Solution(prev: Int, order: Option(Order))
}

fn solve_item(item: List(Int)) -> Bool {
  list.try_fold(item, Solution(-1, None), fn(res, i) {
    case res.prev {
      -1 -> Ok(Solution(..res, prev: i))
      _ ->
        case difference(res.prev, i) {
          diff if 1 <= diff && diff <= 3 -> {
            case res.order, res.prev - i > 0 {
              None, True -> Ok(Solution(i, Some(Descending)))
              None, False -> Ok(Solution(i, Some(Ascending)))
              Some(Descending), True -> Ok(Solution(i, Some(Descending)))
              Some(Descending), False -> Error(Nil)
              Some(Ascending), True -> Error(Nil)
              Some(Ascending), False -> Ok(Solution(i, Some(Ascending)))
            }
          }
          _ -> Error(Nil)
        }
    }
  })
  |> result.is_ok()
}

pub fn solve(table: List(List(Int))) -> List(Bool) {
  list.map(table, solve_item)
}

pub fn solve_part_2(table: List(List(Int))) -> List(Bool) {
  use item <- list.map(table)
  case solve_item(item) {
    False -> {
      let with_indexes = list.index_map(item, fn(x, i) { #(i, x) })
      list.index_map(item, fn(_, i) {
        list.filter_map(with_indexes, fn(l) {
          let #(i1, y) = l
          case i1 == i {
            True -> Error(Nil)
            False -> Ok(y)
          }
        })
        |> solve_item()
      })
      |> list.find(fn(x) { x })
      |> result.is_ok()
    }
    to_return -> to_return
  }
}
