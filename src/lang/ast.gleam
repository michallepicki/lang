import gleam/erlang/charlist.{Charlist}

pub type Module {
  Module(functions: List(Function))
}

pub type Function {
  Function(
    name: Charlist,
    args: List(FunctionArg),
    return_type: Type,
    body: Expr,
  )
}

pub type FunctionArg {
  FunctionArg(name: Charlist, arg_type: Type)
}

pub type Type {
  NamedType(name: Charlist)
}

pub type Expr {
  IntegerLiteral(value: Int)
}

pub external fn from_file(file_name: String) -> Module =
  "lang_ffi" "lex_and_parse"
