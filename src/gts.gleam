import gleam/io
import ets/builder
import ets/table/set

pub fn main() {
  let set: set.Set(String, String) =
    builder.new("example_table")
    |> builder.build_set()

  set |> set.insert("hello", "world")
  set |> set.insert("hello2", "world2")

  set |> set.delete("hello")
  
  set
    |> set.lookup("hello2")
    |> io.debug()

  io.debug(set)
}
