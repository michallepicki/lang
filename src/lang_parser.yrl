Nonterminals
    module_parser module_functions_parser top_lvl_function_parser top_lvl_function_args_parser
    top_lvl_function_arg_parser type_parser function_body_parser expr_parser.
Terminals
    'module' '{' '}' 'fn' '(' ')' ',' ':' '->' identifier type_name integer.
Rootsymbol
    module_parser.

expr_parser->
    integer
        : {'integer_literal', element(3, '$1')}.

function_body_parser ->
    expr_parser
        : '$1'.

type_parser ->
    type_name
        : {'named_type', element(3, '$1')}.

top_lvl_function_arg_parser ->
    identifier ':' type_parser
        : {'function_arg', element(3, '$1'), '$3'}.

top_lvl_function_args_parser ->
    top_lvl_function_arg_parser ',' top_lvl_function_args_parser
        : ['$1' | '$3'].
top_lvl_function_args_parser ->
    top_lvl_function_arg_parser
        : ['$1'].

top_lvl_function_parser ->
    'fn' identifier '(' top_lvl_function_args_parser ')' '->' type_parser '{' function_body_parser '}'
        : {'function', element(3, '$2'), '$4', '$7', '$9'}.

module_functions_parser ->
    top_lvl_function_parser module_functions_parser
        : ['$1' | '$2'].
module_functions_parser ->
    top_lvl_function_parser
        : ['$1'].

module_parser ->
    'module' '{' module_functions_parser '}'
        : {'module', '$3'}.

Erlang code.
