module Tokens

export Token, lookup_ident

@enum(TokenType,
	ILLEGAL,
	EOF, 
	IDENT,
	INT, 
	ASSIGN,
	PLUS,
	COMMA,
	SEMICOLON, 
	LPAREN,
	RPAREN,
	LBRACE,
	RBRACE,
	FUNCTION,
	LET,
)

abstract type AbstractToken end

struct Token <: AbstractToken
	Type::TokenType
	Literal::String
end

keywords = Dict{String, TokenType}(
    "fn" => FUNCTION,
    "let" => LET
)

function lookup_ident(ident::String)
	if haskey(keywords, ident)
		return keywords[ident]
	else
		return IDENT
	end
end

end
