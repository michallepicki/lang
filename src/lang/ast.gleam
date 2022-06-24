import gleam/erlang/charlist.{Charlist}

pub type Module {
  Module(functions: List(Function))
}

pub type Function {
  Function(
    name: Charlist,
    function_type: Type,
    argument_names: List(Charlist),
    body: Expression,
  )
}

pub type Type {
  FunctionType(argument_types: List(Type), return_type: Type)
  TypeName(name: Charlist)
}

pub type Expression {
  Sequence(expressions: List(Expression))
  IntegerLiteral(value: Int)
  TupleLiteral(fields: List(Expression))
  FunctionCall(name: Charlist, arguments: List(Expression))
  NamedValue(name: Charlist)
  Case(argument: Expression, branches: List(#(Pattern, Expression)))
}

pub type Pattern {
  NameBinding(name: Charlist)
  Discard
  TuplePattern(fields: List(Pattern))
}

pub external fn from_file(file_name: String) -> Module =
  "lang_ffi" "lex_and_parse_file"

pub external fn from_string(source_code: String) -> Module =
  "lang_ffi" "lex_and_parse_string"
