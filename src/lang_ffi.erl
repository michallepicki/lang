-module(lang_ffi).
-export([lex_and_parse_file/1, lex_and_parse_string/1]).

lex_and_parse_file(Filename) when is_binary(Filename) ->
    {ok, SourceBinary} = file:read_file(unicode:characters_to_list(Filename)),
    lex_and_parse_string(SourceBinary).

lex_and_parse_string(Source) when is_binary(Source) ->
    {ok, Tokens, _} = lang_lexer:string(unicode:characters_to_list(Source)),
    {ok, Ast} = lang_parser:parse(Tokens),
    Ast.
