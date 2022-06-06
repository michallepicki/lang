import gleam/io
import gleam/list
import lang/ast

pub fn main() {
  let module = ast.from_file("testfile.lang")
  assert Ok(function) = list.at(module.functions, 0)
  io.debug(function.name)
  assert Ok(function_arg) = list.at(function.args, 0)
  io.debug(function_arg.name)
  io.debug(function_arg.arg_type)
  io.debug(function.return_type)
  io.debug(function.body)
  module
}
