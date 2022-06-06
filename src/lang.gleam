import gleam/io
import gleam/list
import lang/ast

pub fn main() {
  let module = ast.from_file("testfile.lang")
  assert Ok(function) = list.at(module.functions, 0)
  io.debug(function.name)
  assert Ok(arg_name) = list.at(function.arg_names, 0)
  io.debug(arg_name)
  io.debug(function.function_type)
  io.debug(function.body)
  module
}
