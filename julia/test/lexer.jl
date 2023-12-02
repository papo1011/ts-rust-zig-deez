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

@testset "next token multiline" begin
	input = """let five = 5;
	
	let ten = 10;

	let add = fn(x, y) {
		x + y;
	};

	let result = add(five, ten);
   	!-/*5;
    5 < 10 > 5;

   	if (5 < 10) {
   		return true;
   	} else {
   		return false;
   	}
	
   	10 == 10;
    10 != 9;
	"""
	
	tests = [
		(Tokens.LET, "let"),
		(Tokens.IDENT, "five"),
		(Tokens.ASSIGN, "="),
		(Tokens.INT, "5"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.LET, "let"),
		(Tokens.IDENT, "ten"),
		(Tokens.ASSIGN, "="),
		(Tokens.INT, "10"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.LET, "let"),
		(Tokens.IDENT, "add"),
		(Tokens.ASSIGN, "="),
		(Tokens.FUNCTION, "fn"),
		(Tokens.LPAREN, "("),
		(Tokens.IDENT, "x"),
		(Tokens.COMMA, ","),
		(Tokens.IDENT, "y"),
		(Tokens.RPAREN, ")"),
		(Tokens.LBRACE, "{"),
		(Tokens.IDENT, "x"),
		(Tokens.PLUS, "+"),
		(Tokens.IDENT, "y"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.RBRACE, "}"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.LET, "let"),
		(Tokens.IDENT, "result"),
		(Tokens.ASSIGN, "="),
		(Tokens.IDENT, "add"),
		(Tokens.LPAREN, "("),
		(Tokens.IDENT, "five"),
		(Tokens.COMMA, ","),
		(Tokens.IDENT, "ten"),
		(Tokens.RPAREN, ")"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.BANG, "!"),
		(Tokens.MINUS, "-"),
		(Tokens.SLASH, "/"),
		(Tokens.ASTERISK, "*"),
		(Tokens.INT, "5"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.INT, "5"),
		(Tokens.LT, "<"),
		(Tokens.INT, "10"),
		(Tokens.GT, ">"),
		(Tokens.INT, "5"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.IF, "if"),
		(Tokens.LPAREN, "("),
		(Tokens.INT, "5"),
		(Tokens.LT, "<"),
		(Tokens.INT, "10"),
		(Tokens.RPAREN, ")"),
		(Tokens.LBRACE, "{"),
		(Tokens.RETURN, "return"),
		(Tokens.TRUE, "true"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.RBRACE, "}"),
		(Tokens.ELSE, "else"),
		(Tokens.LBRACE, "{"),
		(Tokens.RETURN, "return"),
		(Tokens.FALSE, "false"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.RBRACE, "}"),
		(Tokens.INT, "10"),
		(Tokens.EQ, "=="),
		(Tokens.INT, "10"),
		(Tokens.SEMICOLON, ";"),
		(Tokens.INT, "10"),
		(Tokens.NOT_EQ, "!="),
		(Tokens.INT, "9"),
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
