module AST

import ..Tokens
import ..Tokens: Token

export Program, LetStatement, Identifier, token_literal

abstract type Node end
abstract type Expression <: Node end
abstract type Statement <: Node end

struct Program <: Node
    statements::Vector{Statement}
end

struct Identifier <: Expression
    token::Token
    value::String
end

struct LetStatement <: Statement
    token::Token
    name::Identifier
    value::Expression
end

function LetStatement(token::Token)
    stmt = LetStatement(token, Identifier(token, ""), Identifier(token, ""))
    return stmt
end

token_literal(p::Program) = length(p.statements) > 0 ? token_literal(p.statements[1]) : ""

end
