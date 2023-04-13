import gleam/erlang/atom
import ets/internal/table_type/set as set_i
import ets/table
import ets/table/set
import ets/internal/table_type/ordered_set as ordered_set_i
import ets/table/ordered_set

external fn new_table(name: atom.Atom, props: List(atom.Atom)) -> Nil =
  "ets" "new"

pub type TableBuilder(k, v) {
  TableBuilder(name: String, privacy: Privacy)
}

pub type Privacy {
  Private
  Protected
  Public
}

fn privacy_prop(prop: Privacy) -> atom.Atom {
  case prop {
    Private -> "private"
    Protected -> "protected"
    Public -> "public"
  }
  |> atom.create_from_string
}

pub fn new(name: String) -> TableBuilder(k, v) {
  TableBuilder(name: name, privacy: Private)
}

pub fn build_set(builder: TableBuilder(k, v)) -> set.Set(k, v) {
  let name = atom.create_from_string(builder.name)
  new_table(
    name,
    [
      atom.create_from_string("set"),
      privacy_prop(builder.privacy),
      atom.create_from_string("named_table"),
    ],
  )
  set_i.Set(table.new(name))
}

pub fn build_ordered_set(
  builder: TableBuilder(k, v),
) -> ordered_set.OrderedSet(k, v) {
  let name = atom.create_from_string(builder.name)
  new_table(
    name,
    [
      atom.create_from_string("ordered_set"),
      privacy_prop(builder.privacy),
      atom.create_from_string("named_table"),
    ],
  )
  ordered_set_i.OrderedSet(table.new(name))
}
