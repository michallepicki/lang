Nonterminals
    module_parser module_functions_parser top_lvl_function_parser args_parser
    arg_names_parser type_parser function_arg_types_parser types_comma_list_parser
    expression_parser sequence_parser expressions_comma_list_parser
    branches_parser branch_parser pattern_parser patterns_comma_list_parser.
Terminals
    'module' '#{' '{' '}' 'fn' '(' ')' ',' ':' '->' '=' ';' 'case' identifier
    type_name integer.
Rootsymbol
    module_parser.


patterns_comma_list_parser ->
    pattern_parser ',' patterns_comma_list_parser
        : ['$1' | '$3'].
patterns_comma_list_parser ->
    pattern_parser
        : ['$1'].

pattern_parser ->
    '#{' patterns_comma_list_parser '}'
        : {'tuple_pattern', '$2'}.
pattern_parser ->
    '#{' '}'
        : {'tuple_pattern', []}.
pattern_parser ->
    identifier
        : name_binding_or_discard(element(3, '$1')).

branch_parser ->
    pattern_parser '->' expression_parser
        : {'$1', '$3'}.

branches_parser ->
    branch_parser branches_parser
        : ['$1' | '$2'].
branches_parser ->
    branch_parser
        : ['$1'].

expressions_comma_list_parser ->
    expression_parser ',' expressions_comma_list_parser
        : ['$1' | '$3'].
expressions_comma_list_parser ->
    expression_parser
        : ['$1'].

sequence_parser ->
    expression_parser ';' sequence_parser
        : ['$1' | '$3'].
sequence_parser ->
    expression_parser
        : ['$1'].

expression_parser ->
    integer
        : {'integer_literal', element(3, '$1')}.
expression_parser ->
    '{' sequence_parser '}'
        : {'sequence', '$2'}.
expression_parser ->
    '#{' expressions_comma_list_parser '}'
        : {'tuple_literal', '$2'}.
expression_parser ->
    '#{' '}'
        : {'tuple_literal', []}.
expression_parser ->
    identifier '(' expressions_comma_list_parser ')'
        : {'function_call', element(3, '$1'), '$3'}.
expression_parser ->
    identifier '(' ')'
        : {'function_call', element(3, '$1'), []}.
expression_parser ->
    'case' expression_parser '{' branches_parser '}'
        : {'case', '$2', '$4'}.
expression_parser ->
    identifier
        : {'named_value', element(3, '$1')}.

types_comma_list_parser ->
    type_parser ',' types_comma_list_parser
        : ['$1' | '$3'].
types_comma_list_parser ->
    type_parser
        : ['$1'].

function_arg_types_parser ->
    '(' ')'
        : [].
function_arg_types_parser ->
    '(' types_comma_list_parser ')'
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
    'fn' identifier ':' type_parser '=' args_parser '->' expression_parser
        : {'function', element(3, '$2'), '$4', '$6', '$8'}.

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

name_binding_or_discard([$_ | _]) -> 'discard';
name_binding_or_discard(Name) -> {'name_binding', Name}.
