# 07 — COMPILER DESIGN

## 01 — Lexical Analysis — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**
> Focus heavily on **tokens, lexemes, patterns, regular expressions, finite automata, longest match, symbol table, lexical errors, and input buffering**.

---

# 1. What is Lexical Analysis?

**Lexical Analysis** is the first phase of a compiler.

It converts:

$$
\boxed{\text{Source Program} \rightarrow \text{Tokens}}
$$

Example:

```c
int sum = a + 10;
```

Lexical analyzer produces:

```text
int     → keyword
sum     → identifier
=       → operator
a       → identifier
+       → operator
10      → constant
;       → delimiter
```

### Compiler flow

```text
Source Code
    ↓
Lexical Analysis
    ↓
Tokens
    ↓
Syntax Analysis
    ↓
Parse Tree
    ↓
Semantic Analysis
    ↓
Intermediate Code
    ↓
Optimization
    ↓
Target Code
```

---

# 2. Token, Lexeme and Pattern

This is **extremely important for GATE**.

### Token

A **token** is a category/class of lexical units.

Examples:

```text
IDENTIFIER
NUMBER
KEYWORD
OPERATOR
```

### Lexeme

The actual sequence of characters in the source program.

Example:

```c
count = 25;
```

Here:

| Lexeme  | Token      |
| ------- | ---------- |
| `count` | IDENTIFIER |
| `=`     | ASSIGNMENT |
| `25`    | NUMBER     |
| `;`     | SEMICOLON  |

### Pattern

A rule describing all lexemes belonging to a token.

For identifier:

$$
\text{letter}(\text{letter}|\text{digit})^*
$$

---

## 🔥 GATE Trick

Remember:

$$
\boxed{\text{Token = Category}}
$$

$$
\boxed{\text{Lexeme = Actual string}}
$$

$$
\boxed{\text{Pattern = Rule}}
$$

Example:

```text
Token   → IDENTIFIER
Lexeme  → total23
Pattern → letter(letter|digit)*
```

---

# 3. Main Responsibilities of Lexical Analyzer

The lexical analyzer:

### 1. Reads source characters

### 2. Groups characters into lexemes

### 3. Produces tokens

### 4. Removes whitespace

Usually:

```text
space
tab
newline
```

### 5. Removes comments

For example:

```c
// comment
```

or

```c
/* comment */
```

### 6. Detects lexical errors

### 7. Maintains/communicates with symbol table

---

# 4. What Lexical Analyzer Does NOT Do

A common GATE trap.

Lexical analyzer does **not** normally check grammatical structure.

For example:

```c
a + * b
```

The lexical analyzer can recognize:

```text
IDENTIFIER
PLUS
MULTIPLY
IDENTIFIER
```

The **parser** determines whether this sequence follows the grammar.

### Remember

```text
Lexical → "What are these characters?"
Syntax  → "Is this sequence grammatically valid?"
Semantic → "Does it make sense?"
```

---

# 5. Regular Expressions in Lexical Analysis

Lexical specifications are generally described using:

$$
\boxed{\text{Regular Expressions}}
$$

and implemented using:

$$
\boxed{\text{Finite Automata}}
$$

Typical flow:

```text
Regular Expression
       ↓
      NFA
       ↓
      DFA
       ↓
Lexical Analyzer
```

---

# 6. Examples of Token Patterns

## Identifier

Suppose identifiers start with a letter:

$$
\boxed{letter(letter|digit)^*}
$$

Examples:

```text
x
sum
abc123
total9
```

Invalid:

```text
123abc
```

if identifiers cannot start with digits.

---

## Integer

$$
digit^+
$$

Examples:

```text
0
5
123
9999
```

---

## Decimal Number

A simplified pattern:

$$
digit^+(.digit^+)?
$$

Examples:

```text
10
10.5
123.456
```

---

# 7. Keywords vs Identifiers

Consider:

```c
int count;
```

`int` is a **keyword**.

`count` is an **identifier**.

A keyword is a reserved word with predefined meaning.

Examples:

```text
if
else
while
for
int
return
```

---

# 8. How Does Lexer Distinguish Keyword and Identifier?

Suppose:

```text
int
integer
```

Both can initially match the identifier pattern.

The lexer can:

1. Recognize the lexeme as an identifier.
2. Look it up in the keyword table.
3. If present → keyword.
4. Otherwise → identifier.

Example:

```text
"while"
```

→ keyword

```text
"while1"
```

→ identifier

---

# 9. Longest Match Rule

🔥 **VERY IMPORTANT FOR GATE**

Lexical analyzers generally follow:

$$
\boxed{\text{Longest Match / Maximal Munch}}
$$

The lexer chooses the **longest possible lexeme** matching a token pattern.

Example:

```c
a >= b
```

Possible interpretation:

```text
>   =
```

or:

```text
>=
```

The lexer chooses:

$$
\boxed{>=}
$$

because it is the longer valid token.

---

# 10. Example of Longest Match

Suppose operators are:

```text
=
==
```

Input:

```text
a == b
```

Lexer chooses:

```text
==
```

not:

```text
=
=
```

because:

$$
|==|>|=|
$$

---

# 11. Lookahead

Sometimes the lexer needs to read an extra character to decide the token.

Example:

```text
<
<=
```

When lexer sees:

```text
<
```

it checks the next character.

If next character is:

```text
=
```

then:

```text
<=
```

Otherwise:

```text
<
```

This is called **lookahead**.

---

# 12. Lexical Errors

A lexical error occurs when the input cannot be converted into valid tokens according to the lexical rules.

Examples:

```text
@#$     // if not valid symbols
12abc   // depending on language rules
"hello  // unterminated string
```

### Examples of lexical errors

* Invalid character
* Unterminated string
* Unterminated comment
* Invalid numeric literal
* Malformed identifier

---

# 13. Lexical Error vs Syntax Error

Very important.

### Lexical error

Characters cannot form a valid token.

Example:

```text
12abc
```

if the language does not permit this form.

### Syntax error

Tokens exist, but their arrangement violates grammar.

Example:

```c
a + * b
```

Tokens are valid:

```text
ID + * ID
```

but the sequence is grammatically invalid.

---

# 14. Lexical Analyzer and Symbol Table

The lexical analyzer may interact with the **symbol table**.

For example:

```c
int total;
```

When `total` is encountered:

```text
Token → IDENTIFIER
Lexeme → total
```

The identifier can be entered/looked up in the symbol table.

### Symbol table stores information such as:

```text
name
type
scope
memory location
```

depending on the compiler phase and implementation.

---

# 15. Finite Automata and Lexical Analysis

Since token patterns are regular languages:

$$
\boxed{\text{Lexical Analyzer can be implemented using FA}}
$$

Typical process:

$$
RE \rightarrow NFA \rightarrow DFA
$$

Example identifier:

$$
letter(letter|digit)^*
$$

can be converted to a DFA.

---

# 16. DFA for Identifier — Concept

Suppose:

$$
L=letter(letter|digit)^*
$$

DFA:

```text
          letter
       ┌──────────┐
       ↓          │
     (q0) → q1 ───┘
             ↑
          letter/digit
```

`q1` is accepting.

Why?

The first character must be a letter.

After that:

```text
letter
or
digit
```

is allowed.

---

# 17. Input Buffering

Lexical analyzers frequently use **input buffering** to efficiently read source code.

Instead of reading one character from disk at a time:

```text
Disk → character → lexer
```

a block of characters is read:

```text
Disk
 ↓
Buffer
 ↓
Lexer
```

This reduces expensive I/O operations.

---

# 18. Two-Buffer Scheme

A classic compiler-design concept.

Two buffers are used:

```text
Buffer 1 | Buffer 2
```

The lexer can process one buffer while the other is being loaded/refilled.

This reduces overhead at buffer boundaries.

---

# 19. Sentinel

A **sentinel** is placed at the end of a buffer to indicate the end of the buffer.

Conceptually:

```text
Buffer:
[a][b][c][d][e][EOF]
             ↑
          sentinel
```

It helps reduce repeated boundary checks.

### GATE Point

Two-buffer scheme + sentinel:

$$
\boxed{\text{Efficient input scanning}}
$$

---

# 20. Two Pointers

Lexical analyzers commonly use:

### `lexemeBegin`

Points to the beginning of the current lexeme.

### `forward`

Moves ahead while scanning characters.

Example:

```text
a b c + d
↑
lexemeBegin

      ↑
    forward
```

When a token is identified, the range:

```text
lexemeBegin → forward
```

represents the lexeme.

---

# 21. Retracting

Sometimes the lexer reads one character too far.

Example:

```text
abc+
```

To recognize `abc` as an identifier, it may read `+` before knowing the identifier ended.

Then it performs:

$$
\boxed{\text{retract}}
$$

and lets `+` be processed as the next token.

---

# 22. Lexical Analyzer Output

Usually token information can be represented as:

$$
\boxed{<token,\ attribute>}
$$

Example:

```c
sum = 25;
```

Possible output:

```text
<ID, pointer-to-symbol-table-entry>
<ASSIGN, ->
<NUM, 25>
<SEMICOLON, ->
```

The exact implementation depends on the compiler.

---

# 23. Important GATE Concept — Token Attributes

A token can have an associated attribute.

For:

```text
count
```

the token is:

```text
ID
```

but its attribute might be:

```text
pointer to symbol-table entry
```

For:

```text
123
```

the token might be:

```text
NUM
```

with attribute:

```text
123
```

---

# 24. Lexical Analyzer Tools

A famous tool:

$$
\boxed{\text{Lex / Flex}}
$$

is used for generating lexical analyzers.

The programmer specifies token patterns, usually using regular expressions, and the tool generates scanner code.

### GATE Concept

```text
Lex/Flex → Lexical Analyzer
Yacc/Bison → Parser
```

Remember:

$$
\boxed{Lex \rightarrow Lexer}
$$

$$
\boxed{Yacc \rightarrow Parser}
$$

---

# 25. Regular Languages and Lexical Analysis

A very important theoretical connection:

$$
\boxed{\text{Tokens are generally specified by regular languages}}
$$

Therefore:

```text
Regular Expression
       ↕
Finite Automaton
       ↓
Lexical Analyzer
```

### GATE Shortcut

If a question asks which formalism is most appropriate for token specification:

$$
\boxed{\text{Regular Expression}}
$$

---

# 26. Why CFG is Not Normally Used for Tokens

Consider identifiers:

$$
letter(letter|digit)^*
$$

This is regular.

Finite automata are sufficient.

CFG/PDA is more powerful than necessary.

### General division

| Compiler phase    | Common formalism               |
| ----------------- | ------------------------------ |
| Lexical Analysis  | Regular Expression / FA        |
| Syntax Analysis   | CFG / PDA                      |
| Semantic Analysis | Attributes, symbol table, etc. |

---

# 27. 🔥 GATE Tricks

### Trick 1

If the question says:

> "Pattern for tokens"

Think:

$$
\boxed{Regular\ Expression}
$$

---

### Trick 2

If it asks:

> "Machine used to recognize tokens"

Think:

$$
\boxed{Finite\ Automaton}
$$

---

### Trick 3

If two tokens match the same prefix:

$$
\boxed{\text{Longest match}}
$$

---

### Trick 4

If a keyword also matches identifier pattern:

$$
\boxed{\text{Keyword table / reserved-word lookup}}
$$

---

### Trick 5

Characters → tokens:

$$
\boxed{\text{Lexical analysis}}
$$

Tokens → parse tree:

$$
\boxed{\text{Syntax analysis}}
$$

---

# 28. Common GATE Traps

### ❌ Trap 1

"Lexical analyzer checks whether the program is syntactically correct."

**False.**

Parser performs syntax analysis.

---

### ❌ Trap 2

"Every token corresponds to exactly one lexeme."

Not necessarily.

A token is a **class**, while many lexemes can belong to the same token.

Example:

```text
x
y
count
total
```

can all be:

```text
IDENTIFIER
```

---

### ❌ Trap 3

"Lexer always chooses the first matching token."

Generally false.

It uses the **longest-match rule**, subject to lexical rules/priorities.

---

### ❌ Trap 4

"Lexical analysis requires a PDA."

Usually false.

Regular expressions and finite automata are sufficient for standard token recognition.

---

# 29. PYQ Pattern 1 — Token Identification

Given:

```c
int a = b + 10;
```

Expected token sequence:

```text
KEYWORD
IDENTIFIER
ASSIGNMENT
IDENTIFIER
PLUS
NUMBER
SEMICOLON
```

### GATE tests

* Number of tokens
* Number of lexemes
* Token categories
* Identifier recognition

---

# 30. PYQ Pattern 2 — Longest Match

Suppose the operators are:

```text
<
<=
>
>=
==
=
```

Input:

```text
a <= b
```

Correct token:

$$
\boxed{<=}
$$

not:

```text
<
=
```

---

# 31. PYQ Pattern 3 — Regular Expression

Suppose an identifier is defined as:

```text
First character = alphabet
Remaining characters = alphabet or digit
```

Then:

$$
\boxed{(a-z|A-Z)(a-z|A-Z|0-9)^*}
$$

The exact character set depends on the question.

---

# 32. PYQ Pattern 4 — DFA States

For a token such as:

$$
a(a|b)^*
$$

you may be asked:

* Minimum DFA states
* Number of accepting states
* Which strings are accepted
* Equivalent states

Use your **automata knowledge**.

---

# 33. PYQ Pattern 5 — Lexical vs Syntax Error

Given:

```c
int = +;
```

All characters may form valid tokens:

```text
int
=
+
;
```

But their arrangement may violate grammar.

Therefore the issue is primarily:

$$
\boxed{\text{Syntax}}
$$

not lexical recognition.

---

# 34. HIGH-YIELD Comparison

| Feature      | Lexical Analysis       | Syntax Analysis               |
| ------------ | ---------------------- | ----------------------------- |
| Input        | Characters             | Tokens                        |
| Output       | Tokens                 | Parse tree / syntax structure |
| Formal basis | Regular languages      | Context-free languages        |
| Main tool    | RE, DFA, NFA           | CFG, PDA, parsing             |
| Detects      | Lexical errors         | Syntax errors                 |
| Example      | Identifier recognition | Expression grammar            |

---

# 35. 🧠 Last-Minute GATE Sheet

Memorize this:

```text
SOURCE CODE
     ↓
LEXICAL ANALYZER
     ↓
TOKENS
```

### Three terms

$$
\boxed{Token = Category}
$$

$$
\boxed{Lexeme = Actual\ String}
$$

$$
\boxed{Pattern = Rule}
$$

### Recognition

$$
\boxed{RE \leftrightarrow FA}
$$

### Lexer rule

$$
\boxed{\text{Longest Match}}
$$

### Errors

```text
Invalid character/token → Lexical error
Invalid token sequence  → Syntax error
Meaning/type problem    → Semantic error
```

### Tools

$$
\boxed{Lex/Flex \rightarrow Lexer}
$$

$$
\boxed{Yacc/Bison \rightarrow Parser}
$$

### Buffering

```text
Two buffers
+
Sentinel
+
lexemeBegin
+
forward
+
retract
```

---

# 🎯 GATE Priority Checklist

Before moving to **02 — Parsing**, make sure you can answer:

* [ ] Token vs lexeme vs pattern
* [ ] Identify tokens in source code
* [ ] Write RE for identifiers/numbers
* [ ] Convert token RE to DFA conceptually
* [ ] Longest-match rule
* [ ] Keyword vs identifier
* [ ] Lexical vs syntax error
* [ ] Lexical analyzer and symbol table
* [ ] Input buffering
* [ ] Two-buffer scheme
* [ ] Sentinel
* [ ] `lexemeBegin` and `forward`
* [ ] Retract operation
* [ ] Lex/Flex vs Yacc/Bison
* [ ] Why regular expressions/FA are used for lexical analysis

**Next file: `02-Parsing.md` — this is one of the highest-weight Compiler Design topics for GATE.**
