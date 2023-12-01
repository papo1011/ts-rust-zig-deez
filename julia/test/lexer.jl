using Test

include("../src/token.jl")
include("../src/lexer.jl")

import .Lexers
import .Tokens

@testset "next token" begin
	input = "=+(){},;"
	tests = [
		(Tokens.ASSIGN, "="),
		(Tokens.PLUS, "+"),
		(Tokens.LPAREN, "("),
		(Tokens.RPAREN, ")"),
		(Tokens.LBRACE, "{"),
		(Tokens.RBRACE, "}"),
		(Tokens.COMMA, ","),
		(Tokens.SEMICOLON, ";"),
		(Tokens.EOF, ""),
	]

	lexer = Lexers.Lexer(input)
	for (i, (expected_type, expected_literal)) in enumerate(tests)
		tok = Lexers.next_token(lexer)
		@test tok.Type == expected_type
		@test tok.Literal == expected_literal
	end
end
