-module(lang_ffi).
-export([lex_and_parse/1]).

lex_and_parse(FilenameBinary) ->
    Filename = unicode:characters_to_list(FilenameBinary),
    {ok, SourceBinary} = file:read_file(Filename),
    Source = unicode:characters_to_list(SourceBinary),
    {ok, Tokens, _} = lang_lexer:string(Source),
    {ok, Ast} = lang_parser:parse(Tokens),
    Ast.
