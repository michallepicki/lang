import gleam/erlang/charlist.{Charlist}

pub type Module {
  Module(functions: List(Function))
}

pub type Function {
  Function(
    name: Charlist,
    function_type: Type,
    arg_names: List(Charlist),
    body: Expr,
  )
}

pub type Type {
  FunctionType(arg_types: List(Type), return_type: Type)
  TypeName(name: Charlist)
}

pub type Expr {
  ExprSeq(expressions: List(Expr))
  IntegerLiteral(value: Int)
}

pub external fn from_file(file_name: String) -> Module =
  "lang_ffi" "lex_and_parse_file"

pub external fn from_string(source_code: String) -> Module =
  "lang_ffi" "lex_and_parse_string"
