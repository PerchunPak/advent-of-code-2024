import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/set
import gleam/string

pub type Point {
  Point(x: Int, y: Int)
}

pub type Grid(a) =
  Dict(Point, a)

pub fn parse(input: String) -> Grid(String) {
  use grid, line, y <- list.index_fold(string.split(input, "\n"), dict.new())
  use grid, char, x <- list.index_fold(string.to_graphemes(line), grid)
  dict.insert(grid, Point(x, y), char)
}

fn check_for_xmas(
  grid: Grid(String),
  points: List(Point),
  pattern: String,
) -> Result(List(Point), Nil) {
  let graphemes =
    string.to_graphemes(pattern)
    |> list.index_fold(dict.new(), fn(acc, grapheme, i) {
      dict.insert(acc, i, grapheme)
    })

  use <- bool.lazy_guard(
    list.length(points) != list.length(string.to_graphemes(pattern)),
    fn() { panic },
  )
  let length = list.length(points)

  let res =
    list.try_fold(points, #(0, False), fn(acc, point) {
      let #(i, reversed) = acc
      case i {
        0 -> {
          let symbol = result.unwrap(dict.get(graphemes, i), "")
          let rsymbol = result.unwrap(dict.get(graphemes, length - 1), "")
          case dict.get(grid, point) {
            Ok(x) if x == symbol -> Ok(#(i + 1, False))
            Ok(x) if x == rsymbol -> Ok(#(i + 1, True))
            _ -> Error(Nil)
          }
        }
        _ -> {
          let symbol = case reversed {
            True -> result.unwrap(dict.get(graphemes, length - 1 - i), "")
            False -> result.unwrap(dict.get(graphemes, i), "")
          }

          case dict.get(grid, point) {
            Ok(x) if x == symbol -> Ok(#(i + 1, reversed))
            _ -> Error(Nil)
          }
        }
      }
    })

  case result.is_ok(res) {
    True -> Ok(points)
    False -> Error(Nil)
  }
}

fn reverse_4_items_tuple(tuple: #(a, b, c, d)) -> #(d, c, b, a) {
  let #(a, b, c, d) = tuple
  #(d, c, b, a)
}

fn remove_duplicate_points(
  inp: set.Set(#(Point, Point, Point, Point)),
) -> set.Set(#(Point, Point, Point, Point)) {
  use acc, points <- set.fold(inp, set.new())
  case set.contains(acc, reverse_4_items_tuple(points)) {
    False -> set.insert(acc, points)
    True -> acc
  }
}

fn reverse_3_items_tuple(tuple: #(a, b, c)) -> #(c, b, a) {
  let #(a, b, c) = tuple
  #(c, b, a)
}

fn remove_duplicate_points_pt2(
  inp: set.Set(#(Point, Point, Point)),
) -> set.Set(#(Point, Point, Point)) {
  use acc, points <- set.fold(inp, set.new())
  case set.contains(acc, reverse_3_items_tuple(points)) {
    False -> set.insert(acc, points)
    True -> acc
  }
}

fn gen_coords(
  point: Point,
  op: fn(Point, Int) -> Point,
  length: Int,
) -> List(Point) {
  use index <- list.map(list.range(0, length - 1))
  op(point, index)
}

fn scan_point(
  grid: Grid(String),
  point: Point,
) -> set.Set(#(Point, Point, Point, Point)) {
  let coords = [
    gen_coords(point, fn(_, i) { Point(point.x + i, point.y) }, 4),
    gen_coords(point, fn(_, i) { Point(point.x, point.y + i) }, 4),
    gen_coords(point, fn(_, i) { Point(point.x + i, point.y - i) }, 4),
    gen_coords(point, fn(_, i) { Point(point.x - i, point.y - i) }, 4),
    gen_coords(point, fn(_, i) { Point(point.x + i, point.y + i) }, 4),
    gen_coords(point, fn(_, i) { Point(point.x - i, point.y + i) }, 4),
  ]

  use acc, res <- list.fold(
    list.map(coords, fn(p) { check_for_xmas(grid, p, "XMAS") }),
    set.new(),
  )

  case res {
    Ok(points) -> {
      let assert [p1, p2, p3, p4] = points
      set.insert(acc, #(p1, p2, p3, p4))
    }
    Error(_) -> acc
  }
}

pub fn pt_1(grid: Grid(String)) -> Int {
  dict.fold(grid, set.new(), fn(acc, point, _char) {
    scan_point(grid, point)
    |> set.union(acc)
  })
  |> remove_duplicate_points()
  |> set.to_list()
  |> list.length()
}

fn scan_point_pt2(
  grid: Grid(String),
  point: Point,
) -> set.Set(#(Point, Point, Point)) {
  let coords = [
    gen_coords(point, fn(_, i) { Point(point.x + i, point.y - i) }, 3),
    gen_coords(point, fn(_, i) { Point(point.x - i, point.y - i) }, 3),
    gen_coords(point, fn(_, i) { Point(point.x + i, point.y + i) }, 3),
    gen_coords(point, fn(_, i) { Point(point.x - i, point.y + i) }, 3),
  ]

  use acc, res <- list.fold(
    list.map(coords, fn(p) { check_for_xmas(grid, p, "MAS") }),
    set.new(),
  )

  case res {
    Ok(points) -> {
      let assert [p1, p2, p3] = points
      set.insert(acc, #(p1, p2, p3))
    }
    Error(_) -> acc
  }
}

fn find_x(
  points: set.Set(#(Point, Point, Point)),
) -> set.Set(#(Point, Point, Point)) {
  use acc, point <- set.fold(points, set.new())

  let filtered = set.filter(points, fn(x) { x.1 == point.1 })
  case list.length(set.to_list(filtered)) {
    2 -> set.insert(acc, point)
    _ -> acc
  }
}

pub fn pt_2(grid: Grid(String)) -> Int {
  dict.fold(grid, set.new(), fn(acc, point, _char) {
    scan_point_pt2(grid, point)
    |> set.union(acc)
  })
  |> remove_duplicate_points_pt2()
  |> find_x()
  |> set.to_list()
  |> list.length()
  |> int.divide(2)
  |> fn(x) {
    let assert Ok(y) = x
    y
  }
}
