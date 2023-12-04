##
# Static part, don't change these:
##

.PHONY: help ready docker-build docker-ready fmt lint test

help:
	@cat Makefile | grep -E "^\w+$:"

ready: fmt lint test

docker-build:
	docker build --no-cache . -t deez_$(notdir $(shell pwd))

docker-ready: docker-build
	docker run -v $(shell pwd):/deez -t deez_$(notdir $(shell pwd))


# Update those:
##

run:
	@echo "===> Running Monkey REPL"
	julia ./src/Monkey.jl

clean:
	@echo "===> Cleaning"
	@echo "Cleaning not implemented yet"

fmt:
	@echo "===> Formatting"
	@echo "Formatting not implemented yet"

lint:
	@echo "===> Linting"
	@echo "Linting not implemented yet"

test: test-lexer test-ast test-parser
	@echo "===> Testing EVERYTHING"

test-lexer:
	@echo "===> Testing lexer"
	julia ./test/lexer.jl

test-ast:
	@echo "===> Testing AST"
	@echo "AST not implemented yet"

test-parser:
	@echo "===> Testing parser"
	julia ./test/parser.jl

