import gleam/io
import gleam/dynamic.{Dynamic}
import gleam/erlang/charlist.{Charlist}
import gleam/list
import lang/ast

pub fn main() {
  assert module = ast.from_file("testfile.lang")
  assert Ok(function) = list.at(module.functions, 0)
  io.debug(function.name)
  assert Ok(function_arg) = list.at(function.args, 0)
  io.debug(function_arg.name)
  io.debug(function_arg.arg_type)
  io.debug(function.return_type)
  io.debug(function.body)
  module
}

pub fn recompile_lexer() -> Dynamic {
  leex__file(charlist.from_string("src/lang_lexer"))
}

pub fn recompile_parser() -> Dynamic {
  yecc__file(charlist.from_string("src/lang_parser"))
}

external fn leex__file(file: Charlist) -> Dynamic =
  "leex" "file"

external fn yecc__file(file: Charlist) -> Dynamic =
  "yecc" "file"
