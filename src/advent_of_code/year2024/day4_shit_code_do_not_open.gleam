import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/result
import gleam/string

pub fn string_to_2d_array(inp: String) -> List(List(String)) {
  let lines =
    inp
    |> string.trim()
    |> string.split("\n")

  use line <- list.map(lines)
  string.split(line, "")
}

fn id(inp: List(a), index: Int) -> Result(a, Nil) {
  case index >= list.length(inp) {
    True -> Error(Nil)
    False ->
      inp
      |> list.take(index + 1)
      |> list.last()
  }
}

type SimpleDirectionX {
  Up
  Down
}

type SimpleDirectionY {
  Left
  Right
}

type XmasDirection {
  Horizontal
  Vertical
  Diagnal(x: SimpleDirectionX, y: SimpleDirectionY)
}

fn add_cords(
  lst: List(#(Int, Int)),
  direction: XmasDirection,
  x: Int,
  y: Int,
) -> List(#(Int, Int)) {
  case result.is_ok(list.find(lst, fn(i) { i == #(x, y) })) {
    True -> []
    False -> {
      io.debug(direction)
      case direction {
        Horizontal -> [#(x, y + 3)]
        Vertical -> [#(x + 3, y)]
        Diagnal(dx, dy) ->
          case dx, dy {
            Up, Right -> [#(x - 3, y + 3)]
            Up, Left -> [#(x - 3, y - 3)]
            Down, Right -> [#(x + 3, y + 3)]
            Down, Left -> [#(x + 3, y - 3)]
          }
      }
    }
  }
  |> list.append(lst, _)
}

pub fn find_xmas(inp: List(List(String))) -> List(#(Int, Int)) {
  list.index_fold(inp, [], fn(super_acc, line, x) {
    list.index_fold(line, super_acc, fn(acc, i, y) {
      io.debug("=================")
      io.debug(
        string.inspect(acc) <> string.inspect(#(x, y)) <> string.inspect(i),
      )
      let hnext = #(id(line, y + 1), id(line, y + 2), id(line, y + 3))
      let vnext = #(
        id(inp, x + 1)
          |> result.unwrap([])
          |> id(y),
        id(inp, x + 2)
          |> result.unwrap([])
          |> id(y),
        id(inp, x + 3)
          |> result.unwrap([])
          |> id(y),
      )
      let dnextdr = #(
        id(inp, x + 1)
          |> result.unwrap([])
          |> id(y + 1),
        id(inp, x + 2)
          |> result.unwrap([])
          |> id(y + 2),
        id(inp, x + 3)
          |> result.unwrap([])
          |> id(y + 3),
      )
      let dnextdl = #(
        id(inp, x + 1)
          |> result.unwrap([])
          |> id(y - 1),
        id(inp, x + 2)
          |> result.unwrap([])
          |> id(y - 2),
        id(inp, x + 3)
          |> result.unwrap([])
          |> id(y - 3),
      )
      let dnextur = #(
        id(inp, x - 1)
          |> result.unwrap([])
          |> id(y + 1),
        id(inp, x - 2)
          |> result.unwrap([])
          |> id(y + 2),
        id(inp, x - 3)
          |> result.unwrap([])
          |> id(y + 3),
      )
      let dnextul = #(
        id(inp, x - 1)
          |> result.unwrap([])
          |> id(y - 1),
        id(inp, x - 2)
          |> result.unwrap([])
          |> id(y - 2),
        id(inp, x - 3)
          |> result.unwrap([])
          |> id(y - 3),
      )

      io.debug(hnext)
      io.debug(vnext)
      io.debug(dnextdr)
      io.debug(dnextdl)
      io.debug(dnextur)
      io.debug(dnextul)

      case i {
        // horizontal XMAS
        "X" if hnext.0 == Ok("M") && hnext.1 == Ok("A") && hnext.2 == Ok("S") -> {
          add_cords(acc, Horizontal, x, y)
        }
        // horizontal SAMX
        "S" if hnext.0 == Ok("A") && hnext.1 == Ok("M") && hnext.2 == Ok("X") -> {
          add_cords(acc, Horizontal, x, y)
        }
        // vertical XMAS
        "X" if vnext.0 == Ok("M") && vnext.1 == Ok("A") && vnext.2 == Ok("S") -> {
          add_cords(acc, Vertical, x, y)
        }
        // vertical SAMX
        "S" if vnext.0 == Ok("A") && vnext.1 == Ok("M") && vnext.2 == Ok("X") -> {
          add_cords(acc, Vertical, x, y)
        }
        // diagnal down right XMAS
        "X"
          if dnextdr.0 == Ok("M")
          && dnextdr.1 == Ok("A")
          && dnextdr.2 == Ok("S")
        -> {
          add_cords(acc, Diagnal(Down, Right), x, y)
        }
        // diagnal down right SAMX
        "S"
          if dnextdr.0 == Ok("A")
          && dnextdr.1 == Ok("M")
          && dnextdr.2 == Ok("X")
        -> {
          add_cords(acc, Diagnal(Down, Right), x, y)
        }
        // diagnal down left XMAS
        "X"
          if dnextdl.0 == Ok("M")
          && dnextdl.1 == Ok("A")
          && dnextdl.2 == Ok("S")
        -> {
          add_cords(acc, Diagnal(Down, Left), x, y)
        }
        // diagnal down left SAMX
        "S"
          if dnextdl.0 == Ok("A")
          && dnextdl.1 == Ok("M")
          && dnextdl.2 == Ok("X")
        -> {
          add_cords(acc, Diagnal(Down, Left), x, y)
        }
        // diagnal up right XMAS
        "X"
          if dnextur.0 == Ok("M")
          && dnextur.1 == Ok("A")
          && dnextur.2 == Ok("S")
        -> {
          add_cords(acc, Diagnal(Up, Right), x, y)
        }
        // diagnal up right SAMX
        "S"
          if dnextur.0 == Ok("A")
          && dnextur.1 == Ok("M")
          && dnextur.2 == Ok("X")
        -> {
          add_cords(acc, Diagnal(Up, Right), x, y)
        }
        // diagnal up left XMAS
        "X"
          if dnextul.0 == Ok("M")
          && dnextul.1 == Ok("A")
          && dnextul.2 == Ok("S")
        -> {
          add_cords(acc, Diagnal(Up, Left), x, y)
        }
        // diagnal up left SAMX
        "S"
          if dnextul.0 == Ok("A")
          && dnextul.1 == Ok("M")
          && dnextul.2 == Ok("X")
        -> {
          add_cords(acc, Diagnal(Up, Left), x, y)
        }
        _ -> acc
      }
    })
  })
}
