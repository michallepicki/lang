Definitions.

WHITESPACE = [\s\t\n\r]+
INTEGER    = [1-9][0-9]*
IDENTIFIER = [a-z_]+
TYPE_NAME  = [A-Z][A-Za-z_]*

Rules.

module       : {'token', {'module', TokenLine}}.
{            : {'token', {'{', TokenLine}}.
}            : {'token', {'}', TokenLine}}.
fn           : {'token', {'fn', TokenLine}}.
\(           : {'token', {'(', TokenLine}}.
\)           : {'token', {')', TokenLine}}.
,            : {'token', {',', TokenLine}}.
:            : {'token', {':', TokenLine}}.
->           : {'token', {'->', TokenLine}}.
{IDENTIFIER} : {'token', {'identifier', TokenLine, TokenChars}}.
{TYPE_NAME}  : {'token', {'type_name', TokenLine, TokenChars}}.
{INTEGER}    : {'token', {'integer', TokenLine, list_to_integer(TokenChars)}}.
{WHITESPACE} : 'skip_token'.

Erlang code.
