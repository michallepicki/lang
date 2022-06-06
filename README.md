# lang

A Gleam project

## Quick start

```sh
# Compile lexer and parser:
erl -noshell -eval 'leex:file("src/lang_lexer"),yecc:file("src/lang_parser"),init:stop().'

# Run tests:
gleam test

# Run on testfile.lang:
gleam run
```
