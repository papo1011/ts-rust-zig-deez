module Parsers

import ..Lexers
import ..Lexers: Lexer, next_token!
import ..Tokens
import ..Tokens: Token
import ..AST
import ..AST: LetStatement, Statement, Program, Identifier

mutable struct Parser
    lexer::Lexer
    cur_token::Token
    peek_token::Token
end

function Parser(lexer::Lexer)
    p = Parser(lexer, next_token!(lexer), next_token!(lexer))
    return p
end

function next_token!(p::Parser)
    p.cur_token = p.peek_token
    p.peek_token = next_token!(p.lexer)
end

function parse_let_statement(p::Parser)
    token = p.cur_token

    if !expect_peek(p, Tokens.IDENT)
        return nothing
    end

    name = Identifier(p.cur_token, p.cur_token.Literal)

    if !expect_peek(p, Tokens.ASSIGN)
        return nothing
    end

    while !cur_token_is(p, Tokens.SEMICOLON)
        next_token!(p)
    end

    return LetStatement(token, name, Identifier(token, ""))
end

function parse_statement(p::Parser)
    if p.cur_token.Type == Tokens.LET
        return parse_let_statement(p)
    else
        return nothing
    end
end

function parse_program(p::Parser)
    program = Program(Vector{Statement}())

    while p.cur_token.Type != Tokens.EOF
        stmt = parse_statement(p)
        if !isnothing(stmt)
            push!(program.statements, stmt)
        end
        next_token!(p)
    end

    return program
end

function cur_token_is(p::Parser, t::Tokens.TokenType)
    return p.cur_token.Type == t
end

function peek_token_is(p::Parser, t::Tokens.TokenType)
    return p.peek_token.Type == t
end

function expect_peek(p::Parser, t::Tokens.TokenType)
    if peek_token_is(p, t)
        next_token!(p)
        return true
    else
        return false
    end
end

end