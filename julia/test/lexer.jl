include("../src/lexer.jl")
include("../src/token.jl")
using Test


@testset "next token" begin
    input = "=+(){},;"
    tests = [
        (ASSIGN, "="),
        (PLUS, "+"),
        (LPAREN, "("),
        (RPAREN, ")"),
        (LBRACE, "{"),
        (RBRACE, "}"),
        (COMMA, ","),
        (SEMICOLON, ";"),
        (EOF, "")
    ]
    
    lexer = LexerState(input)
    for (i, (expected_type, expected_literal)) in enumerate(tests)
        tok = next_token(lexer)
        @test tok.Type == expected_type
        @test tok.Literal == expected_literal
    end
end
