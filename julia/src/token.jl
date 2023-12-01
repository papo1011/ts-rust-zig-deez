module Tokens

export Token

@enum(TokenType,
	ILLEGAL,
	EOF, IDENT,
	INT, ASSIGN,
	PLUS,
	COMMA,
	SEMICOLON, LPAREN,
	RPAREN,
	LBRACE,
	RBRACE, FUNCTION,
	LET,
)

abstract type AbstractToken end

struct Token <: AbstractToken
	Type::TokenType
	Literal::String
end

end
