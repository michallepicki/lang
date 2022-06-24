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
  
  fn some : (A, B) -> B =
  (x, y) -> {
    10;
    funcall(x, otherfuncall());
    #{100, y}
  }
  
  fn other : () -> C =
  () -> 1000
  
  fn withcase : () -> D =
  () -> case 1 {
    #{} -> 0
    y -> y
    _y -> 1
    _ -> 2
  }
}
",
  )
  |> should.equal(ast.Module(functions: [
    ast.Function(
      name: charlist.from_string("some"),
      argument_names: [charlist.from_string("x"), charlist.from_string("y")],
      function_type: ast.FunctionType(
        argument_types: [
          ast.TypeName(name: charlist.from_string("A")),
          ast.TypeName(name: charlist.from_string("B")),
        ],
        return_type: ast.TypeName(name: charlist.from_string("B")),
      ),
      body: ast.Sequence(expressions: [
        ast.IntegerLiteral(value: 10),
        ast.FunctionCall(
          name: charlist.from_string("funcall"),
          arguments: [
            ast.NamedValue(name: charlist.from_string("x")),
            ast.FunctionCall(
              name: charlist.from_string("otherfuncall"),
              arguments: [],
            ),
          ],
        ),
        ast.TupleLiteral(fields: [
          ast.IntegerLiteral(value: 100),
          ast.NamedValue(name: charlist.from_string("y")),
        ]),
      ]),
    ),
    ast.Function(
      name: charlist.from_string("other"),
      argument_names: [],
      function_type: ast.FunctionType(
        argument_types: [],
        return_type: ast.TypeName(name: charlist.from_string("C")),
      ),
      body: ast.IntegerLiteral(value: 1000),
    ),
    ast.Function(
      name: charlist.from_string("withcase"),
      argument_names: [],
      function_type: ast.FunctionType(
        argument_types: [],
        return_type: ast.TypeName(name: charlist.from_string("D")),
      ),
      body: ast.Case(
        argument: ast.IntegerLiteral(value: 1),
        branches: [
          #(ast.TuplePattern(fields: []), ast.IntegerLiteral(value: 0)),
          #(
            ast.NameBinding(name: charlist.from_string("y")),
            ast.NamedValue(name: charlist.from_string("y")),
          ),
          #(ast.Discard, ast.IntegerLiteral(value: 1)),
          #(ast.Discard, ast.IntegerLiteral(value: 2)),
        ],
      ),
    ),
  ]))
}
