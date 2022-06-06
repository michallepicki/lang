import gleeunit
import gleeunit/should
import gleam/erlang/charlist
import lang/ast

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_test() {
  ast.from_string(
    "module {
  fn some(x, y) : (A, B) -> B {
    10
  }
  fn other() : () -> C {
    100
  }
}
",
  )
  |> should.equal(ast.Module(functions: [
    ast.Function(
      name: charlist.from_string("some"),
      arg_names: [charlist.from_string("x"), charlist.from_string("y")],
      function_type: ast.FunctionType(
        arg_types: [
          ast.TypeName(name: charlist.from_string("A")),
          ast.TypeName(name: charlist.from_string("B")),
        ],
        return_type: ast.TypeName(name: charlist.from_string("B")),
      ),
      body: ast.IntegerLiteral(value: 10),
    ),
    ast.Function(
      name: charlist.from_string("other"),
      arg_names: [],
      function_type: ast.FunctionType(
        arg_types: [],
        return_type: ast.TypeName(name: charlist.from_string("C")),
      ),
      body: ast.IntegerLiteral(value: 100),
    ),
  ]))
}
