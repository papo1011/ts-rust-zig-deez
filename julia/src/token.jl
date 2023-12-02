module Tokens

export Token, lookup_ident

@enum(TokenType,
	ILLEGAL,
	EOF,

	IDENT,
	INT,

	begin_operators,
		ASSIGN, # =
		PLUS, # +
    	MINUS, # -
    	BANG, # !
    	ASTERISK, # *
    	SLASH, # /
    	LT, # <
    	GT, # >
	end_operators,

	begin_delimiters,
		COMMA, # ,
		SEMICOLON, # ;
		LPAREN, # (
		RPAREN, # )
		LBRACE, # {
		RBRACE, # }
	end_delimiters,
	
	begin_keywords,
		FUNCTION, # fn
		LET, # let
		TRUE, # true
		FALSE, # false
		IF, # if
		ELSE, # else
		RETURN, # return
	end_keywords,
)

abstract type AbstractToken end

struct Token <: AbstractToken
	Type::TokenType
	Literal::String
end

keywords = Dict{String, TokenType}(
    "fn" => FUNCTION,
    "let" => LET,
	"true" => TRUE,
	"false" => FALSE,
	"if" => IF,
	"else" => ELSE,
	"return" => RETURN,
)

function lookup_ident(ident::String)
	if haskey(keywords, ident)
		return keywords[ident]
	else
		return IDENT
	end
end

end
