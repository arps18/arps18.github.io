---
title: "Andromex and Beyond"
date: 2025-09-28T00:00:00+00:00
draft: false
tags: ["golang", "programming-languages", "compilers", "systems"]
categories: ["engineering"]
summary: "This weekend, I did something slightly reckless: I decided to write my own programming language."
ShowToc: true
TocOpen: false
---

This weekend, I did something slightly reckless: I decided to write my own programming language. Not the next Rust or C#, but a tiny language with a **Read–Eval–Print Loop (REPL)** that I could hack on over weekends. I called it **Andromex**, because naming things is half the fun. I named it after my favorite galaxy, **Andromeda**, something vast, mysterious, and inspiring, just like the world of compilers.

I've always been curious about what happens under the hood when code runs. Compilers sit right at that intersection of theory and systems engineering, i.e, lexers, parsers, **Abstract Syntax Tree (ASTs)**, **symbol tables**, and optimizations. It's like peeling back the curtain on how programming itself works. I once asked my professor whether a compiler is created first or the language itself, much like the classic chicken and egg problem, and his explanation inspired me to explore this fascinating cycle hands-on by building one myself.

Go felt like the right tool: it's simple, fast to build with, and lets me focus on compiler concepts without drowning in boilerplate. While many people associate Go with web APIs and microservices, I see it as a capable systems language; after all, projects like Docker and Kubernetes prove it can handle complex, low-latency workloads. Its speed, concurrency model, and built-in data structures make it a great fit compared to heavier options like Java or Python, or more memory-heavy ones like C. Of course, nothing is perfect; Go has its trade-offs, but for me, the pros far outweigh the cons, which is why I chose it for Andromex.

The Andromex compiler will follow a structured pipeline similar to traditional language systems. Source code written in Andromex first passes through the **lexer**, which converts raw text into tokens. These tokens are then fed into the **parser**, where the language's grammar rules organize them into a structured form like *Reverse Polish Notation* (RPN) or an *Abstract Syntax Tree* (AST). Next, the **semantic analysis** phase (planned for future versions) will validate types, scopes, and logical consistency. The validated structure is then translated by the **compiler** into an intermediate representation, which the **assembler** converts into efficient **bytecode**. Finally, the virtual machine executes the bytecode, producing the program's output.

You might wonder why a virtual machine is needed here — unlike languages like C++ that compile directly to machine code, Andromex first translates code into bytecode to ensure platform independence, simplify execution, and make future features like optimization, debugging, and JIT compilation easier to implement. Go, as the implementation language for the Andromex compiler and VM, handles all the infrastructure: reading source code, tokenizing it (lexer), parsing it into RPN or AST, performing semantic checks, compiling to bytecode, and running that bytecode inside the VM. Its fast compilation, memory safety, and strong standard library make Go ideal for building Andromex's core components efficiently and reliably. This modular flow makes Andromex both extensible and easier to enhance with features such as type checking and eventual native code generation, while Go acts as the host language that brings the entire system to life.

The adventure started with something simple: installing Go. I hadn't used it much before, so I kept the docs open on the side and decided to learn it *on the fly* while building Andromex. I wanted a clean setup, so I reached for the trusty Homebrew:

```bash
brew install go
```

Quick, painless, done. That's why Homebrew exists.

Once Go was installed, I created the project module:

```bash
go mod init github.com/myname/andromex
```

If you're coming from a Java world, think of `go.mod` like `pom.xml`. It's a single file that declares the identity of your project, including the version of Go it expects and the dependencies it requires. No `node_modules`, no endless XML, just a lean definition.

You can check out the source code [here](https://github.com/arps18/Project-Andromex).

## Our First REPL

The very first program was nothing fancy. It just printed a welcome message and exited. But I wanted to pretend at least it was a REPL.

```go
fmt.Println("Andromex REPL (ctrl+c to exit)")
```

That's it. It didn't read input yet, but it gave me the feeling of having booted up a shell of my own.

Go enforces a strict rule: no unused variables or imports. If you import `os` but never touch it, your program won't compile. That's why I added this line:

```go
_ = os.Args
```

The blank identifier `_` is Go's way of saying, "I know this exists, I'm just not using it right now." A neat trick while scaffolding code :)

## Run vs Build

In these early experiments, `go run main.go` was my best friend. It compiles and executes in one go, perfect for quick iteration. But when you want to ship something standalone, `go build` gives you a binary you can run without Go installed:

```bash
go build -o repl
./repl
```

The workflow feels natural: run while developing, build when you want something that lasts.

## Designing a Language

The real fun began when I thought about how Andromex should *look*. I wanted it tiny and explicit, something like a calculator language at first.

But there's a classic problem: **grammar ambiguity**. Take `2 + 3 * 4`. Should it be `(2 + 3) * 4 = 20` or `2 + (3 * 4) = 14`? Without operator precedence, both parses are valid.

The solution is to bake precedence into the grammar itself:

```
expression ::= term (('+' | '-') term)*
term       ::= factor (('*' | '/') factor)*
factor     ::= NUMBER | '(' expression ')'
```

Now multiplication and division bind tighter than addition and subtraction, just like you'd expect.

This isn't just theoretical. If your REPL can't parse expressions unambiguously, it'll happily give you wrong answers with a straight face :p

## Tokens

Before parsing comes lexing. The lexer's job is to take raw source code and split it into **tokens** — the basic words of the language. Numbers, operators, identifiers, semicolons. Tokens are the alphabet of a language.

For example, `let x = 42;` becomes:

```
[LET] [IDENT:x] [ASSIGN:=] [INT:42] [SEMICOLON]
```

I built a `token` package with two simple types:

```go
type TokenType string
```

```go
type Token struct {
    Type    TokenType
    Literal string
}
```

Readable, printable, and flexible. Strings make debugging friendlier than integer enums at this stage.

## Lexer

The lexer is where things start to feel alive. It's basically a scanner that walks through the input string one character at a time and decides what token to emit.

```go
type Lexer struct {
    input        string
    pos, readPos int
    ch           byte
}
```

The trick is managing **state**. You need to know your current character, the next one (lookahead), and when to stop. For example, is `=` just an assignment, or is it part of `==`? Without looking ahead, you can't know.

Here's how that logic looks:

```go
if l.ch == '=' {
    if l.peekChar() == '=' {
        return Token{Type: EQ, Literal: "=="}
    }
    return Token{Type: ASSIGN, Literal: "="}
}
```

This one-character lookahead is what makes the lexer work for both single- and multi-character tokens.

Let's put it together. For the input:

```
let x = 42 + 10;
```

The lexer produces:

```
{LET, "let"}
{IDENT, "x"}
{ASSIGN, "="}
{INT, "42"}
{PLUS, "+"}
{INT, "10"}
{SEMICOLON, ";"}
{EOF, ""}
```

That's the raw vocabulary your parser will consume to build a syntax tree and eventually run code.

## Documentation

Now that we've built our lexer, it's time to make it professional with proper documentation. One thing I love about Go: documentation is built in. Write a proper comment above a package, type, or function, and `godoc` will pick it up. It feels like Javadoc without the ceremony.

```go
// Lexer represents a lexical analyzer for Andromex.
type Lexer struct { ... }
```

Now you can check the docs locally:

```bash
# View package documentation
go doc github.com/arps18/andromex/lexer

# View specific function
go doc github.com/arps18/andromex/lexer.New
go doc github.com/arps18/andromex/lexer.Lexer.NextToken

# View with source code
go doc -src github.com/arps18/andromex/lexer.NextToken
```

And get clean, structured docs for free. Run `godoc -http=:8080` and you've got a local documentation server in your browser. It makes your toy language feel like a real project.

If you want something like Javadoc hosted over a web server, then:

```bash
# Install godoc tool (if not already installed)
go install golang.org/x/tools/cmd/godoc@latest

# Start local documentation server
godoc -http=:8080

# Open browser to:
# http://localhost:8080
# Navigate to your package:
# http://localhost:6060/pkg/github.com/arps18/andromex/lexer/
```

## What's Next

Currently, Andromex can tokenize input and pretend to be a REPL. Next up is parsing those tokens into an abstract syntax tree and actually evaluating expressions. Eventually, I'd love for it to support variables, functions, and maybe even conditionals.

But the journey so far has been the fun part: installing Go, setting up modules, designing grammar, and building a lexer. Every little step turns abstract compiler theory into something tangible on my screen.

Right now, it's still very early, so instead of evaluating `2 + 3 * 4 = 14` I just got the tokens. But honestly, seeing your language spit out *anything at all* feels magical.

**Roadmap:**

- **Parser:** Build an Abstract Syntax Tree (AST) from tokens.
- **Semantic Analysis:** Add symbol tables and type checking.
- **Intermediate Representation (IR):** Generate a lower-level form for analysis/translation.
- **Optimization:** Constant folding, dead code elimination, peephole optimizations.
- **Code Generation:** Output to a virtual machine or target assembly.
- **Error Handling:** More helpful syntax and runtime error messages.
- **Control Flow:** Support for `if`, `while`, `for`, etc.
- **Functions:** User-defined functions with parameters and return values.
- **Data Structures:** Arrays, structs, and beyond.
- **Object-Oriented Features:** Classes, methods, and inheritance.
