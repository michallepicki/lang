Nonterminals
    module_parser module_functions_parser top_lvl_function_parser args_parser
    arg_names_parser type_parser function_arg_types_parser types_list_parser
    function_body_parser expr_parser.
Terminals
    'module' '{' '}' 'fn' '(' ')' ',' ':' '->' '=' identifier type_name integer.
Rootsymbol
    module_parser.

expr_parser->
    integer
        : {'integer_literal', element(3, '$1')}.

function_body_parser ->
    expr_parser
        : '$1'.

types_list_parser ->
    type_parser ',' types_list_parser
        : ['$1' | '$3'].
types_list_parser ->
    type_parser
        : ['$1'].

function_arg_types_parser ->
    '(' ')'
        : [].
function_arg_types_parser ->
    '(' types_list_parser ')'
        : '$2'.

type_parser ->
    function_arg_types_parser '->' type_parser
        : {'function_type', '$1', '$3'}.
type_parser ->
    type_name
        : {'type_name', element(3, '$1')}.

arg_names_parser ->
    identifier ',' arg_names_parser
        : [element(3, '$1') | '$3'].
arg_names_parser ->
    identifier
        : [element(3, '$1')].

args_parser ->
    '(' ')'
        : [].
args_parser ->
    '(' arg_names_parser ')'
        : '$2'.

top_lvl_function_parser ->
    'fn' identifier ':' type_parser '=' args_parser '->' '{' function_body_parser '}'
        : {'function', element(3, '$2'), '$4', '$6', '$9'}.

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
