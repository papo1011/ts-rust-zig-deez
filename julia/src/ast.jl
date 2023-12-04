module AST

abstract type Node end
abstract type Expression <: Node end
abstract type Statement <: Node end

struct Program <: Node
    statements::Vector{Statement}
end

token_literal(p::Program) = length(p.statements) > 0 ? token_literal(p.statements[1]) : ""

end
