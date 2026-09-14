# 04 — Stacks.md

````md
# 04 — Stacks: GATE CSE Notes, Tricks & PYQ Explanations

> **Target:** GATE CSE/IT  
> **Focus:** Stack ADT, implementation, operations, applications, recursion, expression conversion/evaluation, parentheses, monotonic stack, complexity, and GATE PYQ patterns.

---

# 0. GATE Strategy for Stacks

Stack is a very important GATE topic because it connects:

```text
Stack
  ↓
LIFO
  ↓
Function Calls / Recursion
  ↓
Expression Conversion
  ↓
Expression Evaluation
  ↓
Parentheses Matching
  ↓
DFS
  ↓
Monotonic Stack
````

GATE commonly asks:

* Push/pop sequences
* Stack permutation
* Valid stack output
* Infix → postfix
* Infix → prefix
* Postfix evaluation
* Prefix evaluation
* Operator precedence
* Function-call stack
* Recursion and stack
* Stack implementation using arrays
* Stack implementation using linked lists
* Overflow/underflow
* Multiple stacks
* Complexity analysis
* Queue using stacks
* Parentheses matching

---

# 1. What is a Stack?

A stack is a linear data structure that follows:

> **LIFO — Last In, First Out**

The element inserted last is removed first.

Example:

```text
Push:
10
20
30
```

Stack:

```text
    +----+
TOP | 30 |
    +----+
    | 20 |
    +----+
    | 10 |
    +----+
```

The first element removed is:

```text
30
```

---

# 2. Stack Terminology

Important operations:

```text
push()
pop()
peek() / top()
isEmpty()
isFull()
```

## Push

Adds an element to the top.

```text
Before:
10
20

Push 30:

30 ← TOP
20
10
```

---

## Pop

Removes the top element.

```text
Before:
30 ← TOP
20
10

Pop:

20 ← TOP
10
```

---

## Peek / Top

Returns the top element without removing it.

---

# 3. Stack ADT

A Stack is an **Abstract Data Type**.

The ADT defines behavior:

```text
push
pop
peek
isEmpty
```

but does not require a particular implementation.

It can be implemented using:

```text
Array
Linked List
```

---

# 4. Stack Properties

```text
Insertion → TOP
Deletion  → TOP
Access     → TOP
```

Unlike arrays:

```text
stack does NOT normally allow arbitrary insertion/deletion
```

The restricted access is what makes it a stack.

---

# 5. Stack Using Array

Suppose:

```c
int stack[5];
int top = -1;
```

Initial state:

```text
top = -1
```

Stack:

```text
empty
```

---

# 6. Push Using Array

```c
void push(int x) {
    if(top == MAX-1)
        printf("Overflow");
    else
        stack[++top] = x;
}
```

For:

```text
MAX = 5
```

valid top values:

```text
-1
0
1
2
3
4
```

---

# 7. Pop Using Array

```c
int pop() {
    if(top == -1)
        printf("Underflow");
    else
        return stack[top--];
}
```

The top element is returned and `top` decreases.

---

# 8. Stack Overflow

Overflow occurs when we attempt:

```text
push
```

on a full stack.

For an array of size `n`:

```text
full condition:

top == n-1
```

---

# 9. Stack Underflow

Underflow occurs when we attempt:

```text
pop
```

from an empty stack.

For the common array implementation:

```text
empty condition:

top == -1
```

---

# 10. GATE Stack Conditions

For:

```c
int stack[n];
int top = -1;
```

remember:

```text
Empty:
top = -1

Full:
top = n-1
```

After pushing an element:

```text
top++
```

After popping:

```text
top--
```

---

# 11. Stack Operations Complexity

Using an array:

| Operation | Complexity |
| --------- | ---------: |
| Push      |       Θ(1) |
| Pop       |       Θ(1) |
| Peek      |       Θ(1) |
| isEmpty   |       Θ(1) |
| isFull    |       Θ(1) |

Using a linked list with insertion/deletion at head:

```text
push → Θ(1)
pop  → Θ(1)
peek → Θ(1)
```

---

# 12. Stack Using Linked List

A stack can be represented as:

```text
TOP
 ↓
+----+----+    +----+----+    +----+----+
| 30 |  *------>| 20 |  *------>| 10 |NULL|
+----+----+    +----+----+    +----+----+
```

Push:

```text
insert at head
```

Pop:

```text
delete from head
```

Both:

```text
Θ(1)
```

---

# 13. Why Insert at Head?

Suppose linked-list stack inserts at the tail.

To pop from tail in a singly linked list, we may need to traverse the list.

Therefore:

```text
pop from tail → Θ(n)
```

Instead, use:

```text
head = TOP
```

Then:

```text
push → Θ(1)
pop  → Θ(1)
```

---

# 14. Stack vs Queue

| Feature        | Stack          | Queue           |
| -------------- | -------------- | --------------- |
| Principle      | LIFO           | FIFO            |
| Insert         | Top            | Rear            |
| Delete         | Top            | Front           |
| Main operation | Push/Pop       | Enqueue/Dequeue |
| Example        | Function calls | Printer queue   |

Remember:

```text
Stack → Last In First Out
Queue → First In First Out
```

---

# 15. Stack Example

Operations:

```text
push(10)
push(20)
push(30)
pop()
push(40)
pop()
```

Trace:

```text
push(10)

10
```

```text
push(20)

20
10
```

```text
push(30)

30
20
10
```

```text
pop()

20
10
```

```text
push(40)

40
20
10
```

```text
pop()

20
10
```

Final stack:

```text
TOP
 ↓
20
10
```

---

# 16. GATE Stack Trace Table

Use this for questions:

| Operation | Stack | Output |
| --------- | ----- | ------ |
| push(10)  | 10    | -      |
| push(20)  | 10,20 | -      |
| pop()     | 10    | 20     |
| push(30)  | 10,30 | -      |
| pop()     | 10    | 30     |

This makes stack-sequence questions much easier.

---

# 17. Stack Permutation

Suppose input arrives in:

```text
1 2 3
```

We push elements onto a stack and can pop whenever desired.

Possible outputs include:

```text
1 2 3
1 3 2
2 1 3
2 3 1
3 2 1
```

But not every permutation is possible.

For three elements:

```text
3 1 2
```

is impossible.

---

# 18. Why `3 1 2` is Impossible?

Input:

```text
1 2 3
```

To output `3` first:

```text
push 1
push 2
push 3
pop 3
```

Stack contains:

```text
2
1
```

Next output required:

```text
1
```

But `2` is on top.

We cannot access `1` before removing `2`.

Therefore:

```text
3 1 2
```

is impossible.

---

# 19. Stack Permutation GATE Trick

When checking whether an output sequence is possible:

1. Read input from left to right.
2. Push input elements until required output appears at top.
3. If top matches required output, pop.
4. If input is exhausted and top does not match required output, impossible.

---

# 20. Stack Permutation Algorithm

Given input:

```text
1 2 3 4 5
```

and desired output:

```text
2 1 4 5 3
```

Algorithm:

```text
Input pointer = 1
Stack = empty
Output pointer = 2
```

Push:

```text
1
2
```

Now top is `2`.

Pop:

```text
2
```

Top becomes:

```text
1
```

Pop:

```text
1
```

Continue with:

```text
3
4
```

Pop:

```text
4
```

Then:

```text
5
```

Pop:

```text
5
```

Finally:

```text
3
```

Pop.

Therefore output is possible.

---

# 21. Catalan Numbers and Stack Permutations

The number of valid stack permutations of `n` distinct elements is:

```text
C_n = 1/(n+1) × binomial(2n,n)
```

These are Catalan numbers.

First values:

```text
n = 0 → 1
n = 1 → 1
n = 2 → 2
n = 3 → 5
n = 4 → 14
n = 5 → 42
```

Therefore for `n=3`:

```text
5
```

valid stack permutations exist.

---

# 22. Catalan Number GATE Trick

Catalan numbers appear in:

```text
Valid parentheses
Binary search trees
Full binary trees
Stack permutations
Different binary tree structures
```

Formula:

```text
C_n = (2n)! / ((n+1)!n!)
```

Equivalent:

```text
C_n = 1/(n+1) × C(2n,n)
```

---

# 23. Applications of Stack

Important applications:

```text
1. Function calls
2. Recursion
3. Expression conversion
4. Expression evaluation
5. Parentheses matching
6. Undo operations
7. Browser back button
8. DFS
9. Backtracking
10. Syntax parsing
```

For GATE, the most important are:

```text
Function calls
Expressions
DFS
Parentheses
```

---

# 24. Stack and Function Calls

When a function is called, information such as:

```text
return address
parameters
local variables
saved registers
```

may be stored in a call stack.

Example:

```c
main()
 ↓
f()
 ↓
g()
```

Stack:

```text
TOP
 ↓
g()
f()
main()
```

When `g()` returns:

```text
g() removed
```

Then:

```text
f()
```

resumes.

---

# 25. Stack and Recursion

For:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
}
```

Calling:

```text
f(3)
```

creates frames:

```text
f(3)
f(2)
f(1)
f(0)
```

Maximum stack depth:

```text
Θ(n)
```

This is why recursion consumes stack memory.

---

# 26. Stack Space vs Time

Consider:

```c
f(n-1);
f(n-1);
```

Time may be:

```text
Θ(2^n)
```

but stack space:

```text
Θ(n)
```

because both calls do not remain active simultaneously.

## Golden GATE Trick

```text
Total recursive calls ≠ Maximum stack depth
```

---

# 27. Expression Types

Three common expression notations:

```text
Infix
Prefix
Postfix
```

---

# 28. Infix Expression

Operator appears between operands.

Example:

```text
A + B
```

Another:

```text
A + B * C
```

Humans commonly use infix notation.

---

# 29. Prefix Expression

Operator appears before operands.

Example:

```text
+ A B
```

For:

```text
A + B * C
```

prefix:

```text
+ A * B C
```

---

# 30. Postfix Expression

Operator appears after operands.

Example:

```text
A B +
```

For:

```text
A + B * C
```

postfix:

```text
A B C * +
```

---

# 31. Why Postfix is Useful

Postfix expressions do not require parentheses or precedence rules during evaluation.

Example:

```text
A B C * +
```

means:

```text
A + (B*C)
```

---

# 32. Operator Precedence

Important order:

```text
Highest
    ()
    ^

    * / %

    + -

Lowest
```

For C-like expressions, associativity must also be considered.

---

# 33. Associativity

For most arithmetic operators:

```text
+ - * /
```

associativity is:

```text
Left to Right
```

Example:

```text
A-B-C
```

means:

```text
(A-B)-C
```

not:

```text
A-(B-C)
```

---

# 34. Exponentiation and Associativity

In mathematical expression-conversion questions, exponentiation `^` is often treated as:

```text
Right associative
```

Example:

```text
A ^ B ^ C
```

means:

```text
A ^ (B ^ C)
```

Important:

> Do not confuse mathematical exponentiation `^` with C's bitwise XOR operator.

---

# 35. Infix → Postfix

Use a stack for operators.

Example:

```text
A + B * C
```

## Step 1

Read:

```text
A
```

Output:

```text
A
```

---

## Step 2

Read:

```text
+
```

Push to stack.

```text
Stack:
+
```

---

## Step 3

Read:

```text
B
```

Output:

```text
AB
```

---

## Step 4

Read:

```text
*
```

`*` has higher precedence than `+`.

Push:

```text
Stack:
*
+
```

---

## Step 5

Read:

```text
C
```

Output:

```text
ABC
```

---

## Step 6

Pop remaining operators:

```text
*
+
```

Final:

```text
ABC*+
```

---

# 36. Infix → Postfix Rules

When reading tokens:

### Operand

Immediately add to output.

```text
A → output
```

### `(`

Push onto stack.

### `)`

Pop until `(` is encountered.

### Operator

Pop operators with higher precedence.

For equal precedence, associativity matters.

Then push current operator.

### End

Pop all remaining operators.

---

# 37. Example — Postfix

Convert:

```text
A + B * C
```

Answer:

```text
ABC*+
```

---

# 38. Example — Parentheses

Convert:

```text
(A+B)*C
```

First:

```text
A+B
```

postfix:

```text
AB+
```

Then multiply by `C`:

```text
AB+C*
```

Answer:

```text
AB+C*
```

---

# 39. Example — Complex Expression

Convert:

```text
A+B*(C-D)
```

Inside parentheses:

```text
C D -
```

Then:

```text
B * (C-D)
```

becomes:

```text
B C D - *
```

Then add `A`:

```text
A B C D - * +
```

Final:

```text
ABCD-*+
```

---

# 40. Infix → Prefix Trick

A common method:

1. Reverse the infix expression.
2. Replace `(` with `)`, and `)` with `(`.
3. Convert the modified expression to postfix.
4. Reverse the result.

Example:

```text
(A+B)*C
```

Prefix:

```text
*+ABC
```

---

# 41. Postfix Evaluation

Use a stack.

Example:

```text
2 3 + 4 *
```

## Step 1

Push:

```text
2
3
```

## Step 2

Read `+`.

Pop:

```text
3
2
```

Compute:

```text
2+3=5
```

Push:

```text
5
```

## Step 3

Read:

```text
4
```

Push.

Stack:

```text
5
4
```

## Step 4

Read `*`.

Compute:

```text
5×4=20
```

Answer:

```text
20
```

---

# 42. Postfix Evaluation — Golden Rule

For operator:

```text
op
```

pop:

```text
right operand first
left operand second
```

Then calculate:

```text
left op right
```

Example:

```text
8 3 -
```

Pop:

```text
3 → right
8 → left
```

Calculate:

```text
8-3=5
```

---

# 43. Common Postfix Mistake

For:

```text
8 3 /
```

do NOT calculate:

```text
3/8
```

Correct:

```text
8/3
```

because:

```text
first popped = right operand
second popped = left operand
```

---

# 44. Prefix Evaluation

For prefix expressions, scan:

> **Right to left**

Example:

```text
* + 2 3 4
```

Scan from right:

```text
4
3
2
+
*
```

Calculate:

```text
2+3=5
5×4=20
```

Answer:

```text
20
```

---

# 45. Prefix Evaluation Rule

For prefix:

```text
scan right → left
```

For postfix:

```text
scan left → right
```

---

# 46. Postfix vs Prefix

| Expression | Scan Direction |
| ---------- | -------------- |
| Postfix    | Left → Right   |
| Prefix     | Right → Left   |

Both can be evaluated using a stack.

---

# 47. Parentheses Matching

Stack can check balanced parentheses.

Example:

```text
{[()]}
```

Algorithm:

* Opening bracket → push.
* Closing bracket → top must contain matching opening bracket.
* Pop if matched.
* At end, stack must be empty.

---

# 48. Parentheses Example

Expression:

```text
{[()]}
```

Trace:

```text
{ → push
[ → push
( → push
) → pop (
] → pop [
} → pop {
```

Stack ends empty.

Therefore:

```text
Balanced
```

---

# 49. Invalid Parentheses

Example:

```text
{[(])}
```

Trace:

```text
{ → push
[ → push
( → push
] → expected [
```

Top is:

```text
(
```

which does not match.

Therefore:

```text
Invalid
```

---

# 50. Parentheses Complexity

For a string of length `n`:

Time:

```text
Θ(n)
```

Space:

```text
Θ(n)
```

in the worst case.

Example:

```text
(((((((
```

may require `n` stack elements.

---

# 51. Monotonic Stack

A monotonic stack maintains elements in increasing or decreasing order.

Common applications:

```text
Next Greater Element
Next Smaller Element
Previous Greater Element
Previous Smaller Element
Largest Rectangle in Histogram
Stock Span
```

This is increasingly useful for GATE-style algorithmic questions.

---

# 52. Next Greater Element

Given:

```text
[4,5,2,10]
```

For each element, find the first greater element to its right.

Answer:

```text
4 → 5
5 → 10
2 → 10
10 → -1
```

Result:

```text
[5,10,10,-1]
```

---

# 53. Next Greater Element Using Stack

Scan from right to left.

For:

```text
[4,5,2,10]
```

Maintain decreasing candidates in the stack.

For each element:

1. Remove elements smaller than or equal to current.
2. Top becomes next greater.
3. Push current.

Each element is pushed once and popped at most once.

Therefore:

```text
Time = Θ(n)
```

---

# 54. Why Monotonic Stack is Θ(n)

At first it may appear to be:

```text
O(n²)
```

because there can be an inner `while`.

But each element can be:

```text
pushed once
popped once
```

Therefore total stack operations are:

```text
O(n)
```

## GATE Trick

> Nested loops do not automatically imply `O(n²)`.

Count how many times each element can enter/leave the stack.

---

# 55. Stock Span Problem

Given stock prices:

```text
100 80 60 70 60 75 85
```

Stock span for each day is the number of consecutive previous days with price less than or equal to today's price.

Result:

```text
1 1 1 2 1 4 6
```

A monotonic stack can solve this in:

```text
Θ(n)
```

---

# 56. Largest Rectangle in Histogram

Given:

```text
[2,1,5,6,2,3]
```

Maximum rectangle area is:

```text
10
```

The bars:

```text
5,6
```

produce:

```text
height = 5
width = 2
area = 10
```

A monotonic increasing stack gives:

```text
Θ(n)
```

solution.

---

# 57. Stack for DFS

Depth First Search can be implemented using:

```text
Recursion
```

or:

```text
Explicit Stack
```

Recursive DFS:

```text
function call stack
```

Iterative DFS:

```text
explicit stack
```

Both follow depth-first behavior.

---

# 58. DFS Stack Example

Graph:

```text
A
├── B
│   ├── D
│   └── E
└── C
```

Starting from `A`, a possible DFS order is:

```text
A B D E C
```

An explicit stack can simulate this.

---

# 59. Stack and Backtracking

Stack naturally supports:

```text
try choice
 ↓
go deeper
 ↓
dead end
 ↓
pop
 ↓
try another choice
```

Applications:

```text
Maze solving
N-Queens
DFS
Path finding
Combinatorial search
```

---

# 60. Two Stacks in One Array

A common GATE/data-structure question asks how to implement two stacks in one array.

Use:

```text
Stack 1 → grows from left
Stack 2 → grows from right
```

Example:

```text
0                        n-1
↓                         ↓
[ S1 → → →       ← ← ← S2 ]
```

Stack 1 top moves:

```text
left → right
```

Stack 2 top moves:

```text
right → left
```

Overflow occurs when:

```text
top1 + 1 == top2
```

---

# 61. Why Two Stacks in One Array?

It allows unused space to be shared dynamically.

If stack 1 needs more space and stack 2 has unused space, stack 1 can use it.

This is better than statically splitting the array into two equal halves.

---

# 62. Implement Queue Using Two Stacks

A queue can be implemented using two stacks:

```text
S1
S2
```

## Enqueue

Push into:

```text
S1
```

## Dequeue

If `S2` is empty:

```text
move all elements from S1 → S2
```

Then:

```text
pop S2
```

This reverses the order and creates FIFO behavior.

---

# 63. Queue Using Two Stacks — Example

Enqueue:

```text
1
2
3
```

S1:

```text
3
2
1
```

Move to S2:

```text
1
2
3
```

Now:

```text
pop S2 → 1
```

Correct FIFO order.

---

# 64. Complexity of Queue Using Two Stacks

Individual dequeue may sometimes cost:

```text
Θ(n)
```

when transferring elements.

But over a sequence of operations:

> **Amortized complexity is Θ(1) per operation.**

Why?

Each element is moved from:

```text
S1 → S2
```

at most once before being removed.

Total work over many operations is linear in the number of operations.

---

# 65. Stack Using Two Queues

A stack can also be implemented using two queues.

Depending on the implementation:

### Push costly

Push new element and rotate older elements behind it.

Then:

```text
push → Θ(n)
pop  → Θ(1)
```

Or:

### Pop costly

Keep push cheap:

```text
push → Θ(1)
pop  → Θ(n)
```

GATE may ask which implementation gives which complexity.

---

# 66. Stack vs Queue Implementation Trick

Remember:

```text
Queue using stacks:
    FIFO from LIFO

Stack using queues:
    LIFO from FIFO
```

The implementation uses rearrangement to simulate the required ordering.

---

# 67. GATE PYQ Pattern 1 — Stack Operations

Given:

```text
push(1)
push(2)
push(3)
pop()
push(4)
pop()
```

Trace:

```text
push 1
→ [1]

push 2
→ [1,2]

push 3
→ [1,2,3]

pop
→ removes 3
→ [1,2]

push 4
→ [1,2,4]

pop
→ removes 4
→ [1,2]
```

Final stack:

```text
[1,2]
```

Output sequence:

```text
3,4
```

---

# 68. GATE PYQ Pattern 2 — Push/Pop Sequence

Input:

```text
1 2 3 4
```

Question:

> Can the output be `2 1 4 3`?

Trace:

```text
push 1
push 2
pop → 2
pop → 1
push 3
push 4
pop → 4
pop → 3
```

Therefore:

```text
2 1 4 3
```

is possible.

---

# 69. GATE PYQ Pattern 3 — Impossible Stack Permutation

Input:

```text
1 2 3
```

Desired:

```text
3 1 2
```

To output `3`:

```text
push 1
push 2
push 3
pop 3
```

Now stack:

```text
2
1
```

Desired next:

```text
1
```

But `2` is above `1`.

Therefore impossible.

Answer:

```text
Not a valid stack permutation.
```

---

# 70. GATE PYQ Pattern 4 — Postfix Evaluation

Evaluate:

```text
5 3 2 * +
```

Scan left to right.

Push:

```text
5
3
2
```

Read `*`:

```text
3 × 2 = 6
```

Stack:

```text
5
6
```

Read `+`:

```text
5 + 6 = 11
```

Answer:

```text
11
```

---

# 71. GATE PYQ Pattern 5 — Postfix Subtraction

Evaluate:

```text
8 2 3 + -
```

First:

```text
2+3 = 5
```

Then:

```text
8-5 = 3
```

Answer:

```text
3
```

## Trick

Always remember:

```text
right = first popped
left  = second popped
```

---

# 72. GATE PYQ Pattern 6 — Prefix Evaluation

Evaluate:

```text
- * 5 4 3
```

Scan right to left:

```text
3
4
5
*
-
```

Calculate:

```text
5×4 = 20
20-3 = 17
```

Answer:

```text
17
```

---

# 73. GATE PYQ Pattern 7 — Infix to Postfix

Convert:

```text
A+B*C
```

Precedence:

```text
* > +
```

Therefore:

```text
B*C
```

first.

Postfix:

```text
ABC*+
```

Answer:

```text
ABC*+
```

---

# 74. GATE PYQ Pattern 8 — Parentheses

Convert:

```text
(A+B)*(C-D)
```

First:

```text
A+B → AB+
C-D → CD-
```

Then multiply:

```text
AB+CD-*
```

Answer:

```text
AB+CD-*
```

---

# 75. GATE PYQ Pattern 9 — Operator Stack

Convert:

```text
A*(B+C)
```

Processing:

```text
A → output
* → stack
( → stack
B → output
+ → stack
C → output
) → pop +
end → pop *
```

Output:

```text
ABC+*
```

---

# 76. GATE PYQ Pattern 10 — Mixed Precedence

Convert:

```text
A+B*C-D
```

Multiplication first:

```text
B*C
```

Then left-to-right:

```text
(A+(B*C))-D
```

Postfix:

```text
ABC*+D-
```

Answer:

```text
ABC*+D-
```

---

# 77. GATE PYQ Pattern 11 — `*` and `/`

Expression:

```text
A/B*C
```

Since `*` and `/` have equal precedence and are left associative:

```text
(A/B)*C
```

Postfix:

```text
AB/C*
```

NOT:

```text
ABC*/
```

---

# 78. GATE PYQ Pattern 12 — Right Associativity

For exponentiation:

```text
A^B^C
```

if `^` is treated as right associative:

```text
A^(B^C)
```

Postfix:

```text
ABC^^
```

## GATE Trick

Equal precedence does not always mean left-to-right.

Always check:

```text
precedence
+
associativity
```

---

# 79. GATE PYQ Pattern 13 — Stack Depth

Suppose operations are:

```text
push(1)
push(2)
push(3)
pop()
push(4)
push(5)
```

Maximum number of simultaneously stored elements:

```text
3
```

Trace:

```text
after push 1 → 1
after push 2 → 2
after push 3 → 3
after pop     → 2
after push 4  → 3
after push 5  → 4
```

Actually maximum becomes:

```text
4
```

Therefore:

```text
Maximum stack size = 4
```

## GATE Trick

Do not count total pushes.

Count:

> **Maximum number of elements present at any one time.**

---

# 80. GATE PYQ Pattern 14 — Overflow

Suppose stack size:

```text
5
```

Operations:

```text
push 1
push 2
push 3
push 4
push 5
push 6
```

After five pushes:

```text
stack full
```

The sixth push causes:

```text
Stack Overflow
```

---

# 81. GATE PYQ Pattern 15 — Underflow

Suppose:

```text
stack = [10]
```

Operations:

```text
pop()
pop()
```

First pop:

```text
10
```

Stack becomes empty.

Second pop:

```text
Underflow
```

---

# 82. GATE PYQ Pattern 16 — Recursion Stack

Consider:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
}
```

For:

```text
f(5)
```

maximum active function calls are approximately:

```text
f(5)
f(4)
f(3)
f(2)
f(1)
f(0)
```

So:

```text
6 frames
```

or:

```text
Θ(n)
```

asymptotically.

---

# 83. GATE PYQ Pattern 17 — Recursive Output

```c
void f(int n) {
    if(n == 0)
        return;

    printf("%d ", n);
    f(n-1);
}
```

For:

```text
f(4)
```

output:

```text
4 3 2 1
```

If:

```c
f(n-1);
printf("%d ", n);
```

then:

```text
1 2 3 4
```

This is directly related to stack unwinding.

---

# 84. GATE PYQ Pattern 18 — Monotonic Stack

Given:

```text
4 5 2 10
```

Next greater elements:

```text
4 → 5
5 → 10
2 → 10
10 → -1
```

Answer:

```text
5 10 10 -1
```

Complexity:

```text
Θ(n)
```

---

# 85. GATE PYQ Pattern 19 — Amortized Stack Operations

Suppose an algorithm repeatedly:

```text
pushes each element once
pops each element at most once
```

Even if there is a `while` loop, total stack operations are:

```text
O(n)
```

because every element can be removed only once.

## GATE Trick

This pattern often appears in:

```text
Next Greater Element
Stock Span
Monotonic Stack
```

Answer:

```text
Θ(n)
```

---

# 86. GATE PYQ Pattern 20 — Two Stacks in Array

Array size:

```text
10
```

Stack 1 starts:

```text
top1 = -1
```

Stack 2 starts:

```text
top2 = 10
```

They grow toward each other.

Overflow when:

```text
top1 + 1 == top2
```

This allows both stacks to share unused memory.

---

# 87. Expression Conversion Cheat Sheet

```text
Infix:
A+B

Prefix:
+AB

Postfix:
AB+
```

Example:

```text
Infix:
A+B*C
```

Prefix:

```text
+A*BC
```

Postfix:

```text
ABC*+
```

---

# 88. Operator Precedence Cheat Sheet

For expression conversion:

```text
Highest
    ()
    ^
    * / %
    + -
Lowest
```

For equal precedence:

```text
+ - * /
→ Left associative

^
→ Usually right associative in mathematical expression questions
```

---

# 89. Postfix Evaluation Cheat Sheet

```text
Scan:
Left → Right

Operand:
Push

Operator:
    pop right
    pop left
    result = left operator right
    push result
```

---

# 90. Prefix Evaluation Cheat Sheet

```text
Scan:
Right → Left

Operand:
Push

Operator:
    pop left/right according to stack order
    calculate
    push result
```

For an operator encountered during right-to-left scanning:

```text
first popped  → left operand
second popped → right operand
```

Example:

```text
- 8 3
```

Result:

```text
8-3=5
```

---

# 91. Stack Permutation Cheat Sheet

To test whether output is possible:

```text
1. Start with empty stack.
2. Read input sequentially.
3. Push until required output is available.
4. If stack top == required output:
       pop
5. Otherwise continue pushing.
6. If input ends and required output cannot be produced:
       impossible
```

---

# 92. Catalan Cheat Sheet

```text
C0 = 1
C1 = 1
C2 = 2
C3 = 5
C4 = 14
C5 = 42
C6 = 132
```

Formula:

```text
Cn = 1/(n+1) × C(2n,n)
```

Appears in:

```text
Stack permutations
Balanced parentheses
BST structures
Full binary trees
```

---

# 93. Important Stack Complexities

| Operation / Application |   Time |
| ----------------------- | -----: |
| Push                    |   Θ(1) |
| Pop                     |   Θ(1) |
| Peek                    |   Θ(1) |
| Parentheses Matching    |   Θ(n) |
| Infix → Postfix         |   Θ(n) |
| Postfix Evaluation      |   Θ(n) |
| Prefix Evaluation       |   Θ(n) |
| DFS using stack         | Θ(V+E) |
| Next Greater Element    |   Θ(n) |
| Stock Span              |   Θ(n) |
| Largest Rectangle       |   Θ(n) |

---

# 94. Stack Memory Complexity

For an array implementation:

```text
n elements
```

requires:

```text
Θ(n)
```

space.

For a linked-list implementation:

```text
n nodes
```

requires:

```text
Θ(n)
```

space.

For recursion:

```text
depth = d
```

stack usage:

```text
Θ(d)
```

---

# 95. Stack and DFS Complexity

For a graph with:

```text
V vertices
E edges
```

DFS using adjacency lists:

```text
Θ(V+E)
```

Why?

Each vertex is processed and each edge is examined a constant number of times.

---

# 96. Stack and BFS

BFS uses:

> **Queue**

DFS uses:

> **Stack**

Easy GATE memory trick:

```text
DFS → Stack
BFS → Queue
```

Recursive DFS internally uses:

```text
Call Stack
```

---

# 97. Stack and Expression Parsing

Compilers and parsers use stack-like mechanisms for:

```text
Parentheses
Nested constructs
Function calls
Operator handling
Syntax analysis
```

A nested structure naturally follows LIFO behavior.

Example:

```text
(
  {
    [
    ]
  }
)
```

The most recently opened construct must be closed first.

---

# 98. GATE Common Traps

## Trap 1

Thinking stack allows arbitrary access.

Wrong.

Standard stack operations access only the top.

---

## Trap 2

Confusing:

```text
Overflow
```

with:

```text
Underflow
```

Remember:

```text
Full + push → Overflow

Empty + pop → Underflow
```

---

## Trap 3

Forgetting operand order in postfix.

For:

```text
8 2 -
```

answer:

```text
6
```

not:

```text
-6
```

---

## Trap 4

Forgetting that equal precedence requires associativity.

---

## Trap 5

Thinking nested `while` means `O(n²)` in monotonic-stack algorithms.

It may still be:

```text
Θ(n)
```

because each element is pushed/popped a bounded number of times.

---

# 99. GATE Question-Solving Workflow

For a stack question:

### Step 1

Identify:

```text
LIFO
```

### Step 2

Draw:

```text
TOP
 ↓
...
```

### Step 3

Process operations one by one.

### Step 4

For expression questions:

```text
identify precedence
+
associativity
```

### Step 5

For postfix:

```text
scan left → right
```

### Step 6

For prefix:

```text
scan right → left
```

### Step 7

For permutation questions:

```text
simulate push/pop
```

### Step 8

For complexity:

```text
count pushes/pops
```

---

# 100. Most Important GATE Tricks

```text
Stack
→ LIFO
```

```text
push
→ insert at TOP
```

```text
pop
→ delete from TOP
```

```text
empty array stack
→ top = -1
```

```text
full array stack
→ top = n-1
```

```text
push full stack
→ overflow
```

```text
pop empty stack
→ underflow
```

```text
DFS
→ Stack
```

```text
BFS
→ Queue
```

```text
postfix
→ scan left to right
```

```text
prefix
→ scan right to left
```

```text
postfix operator:
first popped = right
second popped = left
```

```text
monotonic stack
→ often Θ(n)
```

```text
two stacks in one array:
top1 + 1 == top2
→ overflow
```

---

# 101. Stack PYQ Practice Order

For GATE, solve stack questions in this order:

```text
1. Basic push/pop
        ↓
2. Overflow/underflow
        ↓
3. Stack tracing
        ↓
4. Stack permutations
        ↓
5. Catalan numbers
        ↓
6. Infix → postfix
        ↓
7. Infix → prefix
        ↓
8. Postfix evaluation
        ↓
9. Prefix evaluation
        ↓
10. Parentheses
        ↓
11. Recursion stack
        ↓
12. DFS
        ↓
13. Queue using stacks
        ↓
14. Stack using queues
        ↓
15. Monotonic stack
        ↓
16. Mixed complexity questions
```

---

# 102. Final Rapid Revision Sheet

```text
STACK

Principle:
    LIFO

Insertion:
    TOP

Deletion:
    TOP

Array implementation:
    top = -1 initially

Empty:
    top == -1

Full:
    top == n-1

Push:
    top++

Pop:
    top--

Push full:
    Overflow

Pop empty:
    Underflow

Push:
    Θ(1)

Pop:
    Θ(1)

Peek:
    Θ(1)

DFS:
    Stack

BFS:
    Queue

Recursion:
    Call Stack

Postfix:
    Left → Right

Prefix:
    Right → Left

Postfix:
    first popped = right operand
    second popped = left operand

Infix → Postfix:
    operands → output
    operators → stack

Parentheses:
    opening → push
    closing → match + pop

Stack permutation:
    simulate push/pop

Catalan:
    Cn = 1/(n+1) × C(2n,n)

Next Greater Element:
    Monotonic Stack
    Θ(n)

Stock Span:
    Monotonic Stack
    Θ(n)

Largest Rectangle:
    Monotonic Stack
    Θ(n)

Two stacks in one array:
    stack1 → left to right
    stack2 → right to left

Overflow:
    top1 + 1 == top2
```

---

# 103. Final GATE Checklist

Before considering Stacks complete:

* [ ] Understand LIFO
* [ ] Stack ADT
* [ ] Push
* [ ] Pop
* [ ] Peek
* [ ] Overflow
* [ ] Underflow
* [ ] Array implementation
* [ ] Linked-list implementation
* [ ] Stack complexity
* [ ] Stack tracing
* [ ] Stack permutation
* [ ] Catalan numbers
* [ ] Function-call stack
* [ ] Recursion stack
* [ ] Infix expression
* [ ] Prefix expression
* [ ] Postfix expression
* [ ] Operator precedence
* [ ] Operator associativity
* [ ] Infix → postfix
* [ ] Infix → prefix
* [ ] Postfix evaluation
* [ ] Prefix evaluation
* [ ] Parentheses matching
* [ ] DFS using stack
* [ ] Queue using two stacks
* [ ] Stack using two queues
* [ ] Two stacks in one array
* [ ] Monotonic stack
* [ ] Next Greater Element
* [ ] Stock Span
* [ ] Largest Rectangle in Histogram
* [ ] Amortized stack analysis
* [ ] Time vs space complexity

---

# 104. Final GATE Rule

Whenever you see a stack question, immediately ask:

```text
1. Is the structure LIFO?

2. What is currently at TOP?

3. Is the operation push or pop?

4. Can the required output actually be generated?

5. If expression-based:
   what is precedence?
   what is associativity?

6. If postfix:
   scan left → right.

7. If prefix:
   scan right → left.

8. For recursion:
   what is the maximum call-stack depth?

9. For monotonic stack:
   how many times can each element be pushed/popped?

10. Is the question asking total operations
    or maximum simultaneous stack size?
```

> **GATE Master Trick:**
> Most stack questions become easy once you draw the **TOP** explicitly and process every operation one at a time.

```
```
