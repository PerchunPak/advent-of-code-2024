import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn solve(str: String) -> List(Int) {
  let _ =
    {
      use line <- list.map(string.split(str, "\n"))
      use acc, character <- list.fold(string.split(line, ""), [])

      let as_int = int.parse(character)
      case result.is_ok(as_int) {
        True -> list.append(acc, [character])
        False -> acc
      }
    }
    |> list.map(fn(lst) {
      let x = list.first(lst)
      let y = list.last(lst)

      case result.is_ok(result.all([x, y])) {
        True -> result.unwrap(x, "") <> result.unwrap(y, "")
        False -> ""
      }
    })
    |> list.filter_map(fn(x) {
      case x == "" {
        True -> Error(Nil)
        False -> int.parse(x)
      }
    })
}

type MyWeirdInteger {
  MyWeirdInteger(as_str: String, as_int: Int, length: Int)
}

const my_weird_integers = [
  MyWeirdInteger("one", 1, 3),
  MyWeirdInteger("two", 2, 3),
  MyWeirdInteger("three", 3, 5),
  MyWeirdInteger("four", 4, 4),
  MyWeirdInteger("five", 5, 4),
  MyWeirdInteger("six", 6, 3),
  MyWeirdInteger("seven", 7, 5),
  MyWeirdInteger("eight", 8, 5),
  MyWeirdInteger("nine", 9, 4),
]

fn replace_text_numbers(inp: String) -> String {
  let replaces_by_length = list.group(my_weird_integers, fn(x) { x.length })

  list.fold(string.split(inp, ""), "", fn(acc, a) {
    let str = acc <> a
    let words_to_replace =
      dict.filter(replaces_by_length, fn(k, _) { k <= string.length(str) })
      |> dict.values()
      |> list.flatten()
      |> list.try_map(fn(word) {
        case string.ends_with(str, word.as_str) {
          True -> {
            Error(string.replace(str, word.as_str, int.to_string(word.as_int)))
          }
          False -> Ok(Nil)
        }
      })

    case words_to_replace {
      Ok(_) -> str
      Error(res) -> res
    }
  })
}

const str_to_int = [
  #("one", 1), #("two", 2), #("three", 3), #("four", 4), #("five", 5),
  #("six", 6), #("seven", 7), #("eight", 8), #("nine", 9),
]

pub fn solve_part2(str: String) -> List(Int) {
  let _ =
    {
      use line <- list.map(string.split(str, "\n"))
      use #(ints, str), character <- list.fold(string.split(line, ""), #([], ""))
      let new_str = str <> character

      let new_ints = case int.parse(character) {
        Ok(i) -> list.append(ints, [i])
        Error(_) ->
          list.try_map(str_to_int, fn(k, v) {
            case string.ends_with(nstr, k) {
              True -> Error(list.append(ints, v))
              False -> Ok(Nil)
            }
          })
      }
      #(new_ints, new_str)
    }
    |> list.map(fn(lst) {
      let x = list.first(lst)
      let y = list.last(lst)

      case result.is_ok(result.all([x, y])) {
        True -> result.unwrap(x, "") <> result.unwrap(y, "")
        False -> ""
      }
    })
    |> list.filter_map(fn(x) {
      case x == "" {
        True -> Error(Nil)
        False -> int.parse(x)
      }
    })
}
