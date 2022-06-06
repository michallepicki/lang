import gleeunit
import gleeunit/should
import gleam/erlang/charlist
import lang/ast

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_test() {
  let int_type = ast.NamedType(name: charlist.from_string("Int"))
  ast.from_file("testfile.lang")
  |> should.equal(ast.Module(functions: [
    ast.Function(
      name: charlist.from_string("some"),
      args: [
        ast.FunctionArg(name: charlist.from_string("x"), arg_type: int_type),
      ],
      return_type: int_type,
      body: ast.IntegerLiteral(value: 10),
    ),
  ]))
}
