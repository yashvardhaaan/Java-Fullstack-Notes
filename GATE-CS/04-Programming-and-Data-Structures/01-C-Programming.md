# 01 — C Programming: GATE CSE Notes, Tricks & PYQ Explanations

> **Target:** GATE CSE/IT  
> **Use this file for:** concept revision + output tracing + pointer/array practice + PYQ preparation.

---

## 0. GATE Strategy for C Programming

C questions in GATE are usually less about writing a large program and more about **tracing a small program exactly**.

### Highest-priority areas

| Priority | Topic | What GATE tests |
|---|---|---|
| 🔥🔥🔥 | Pointers | `*`, `&`, pointer arithmetic, pointer-to-pointer |
| 🔥🔥🔥 | Arrays + pointers | `a`, `&a`, `a+i`, `*(a+i)`, 2-D arrays |
| 🔥🔥🔥 | Functions | call by value, pointer parameters, scope |
| 🔥🔥🔥 | Recursion | base case, return flow, stack |
| 🔥🔥🔥 | Storage classes | `static`, `auto`, local/global scope |
| 🔥🔥 | Operators | precedence, associativity, `++`, `--`, `?:` |
| 🔥🔥 | Strings | character arrays, `'\0'`, pointer traversal |
| 🔥🔥 | Structures | memory layout, pointer to structure |
| 🔥 | Dynamic memory | `malloc`, `calloc`, `realloc`, `free` |
| 🔥 | Bitwise operators | masks, shifts, parity, powers of 2 |

### Golden GATE rule

When tracing C code:

1. Write the values of important variables.
2. For every pointer, write **what it points to**.
3. Do not mentally skip `++`, `--`, `*`, `&`.
4. Separate **value change** from **pointer movement**.
5. For recursion, draw the calls first and return values second.
6. Check whether the expression has **undefined behavior** before calculating an output.

---

# 1. C Program Execution Model

A typical C program has:

```text
Source Code
    ↓
Preprocessor
    ↓
Compiler
    ↓
Assembler
    ↓
Linker
    ↓
Executable
    ↓
Loader
    ↓
Execution
```

For GATE, remember the broad roles:

- **Preprocessor:** handles `#include`, `#define`, conditional compilation.
- **Compiler:** translates C source into lower-level code and detects many compile-time errors.
- **Linker:** combines object files/libraries and resolves external symbols.
- **Loader:** places the executable into memory for execution.

---

# 2. Basic C Data Types

Common fundamental types:

```c
char
int
float
double
void
```

Modifiers:

```c
signed
unsigned
short
long
```

Example:

```c
unsigned int x;
long int y;
short int z;
```

## Important GATE point

Do **not** blindly assume every C implementation has the same size for every type.

For GATE questions, use the size explicitly supplied by the question.

Example:

> Assume an integer requires 4 bytes.

Then pointer arithmetic becomes numerical:

```c
int a[10];
a + 3
```

moves by:

```text
3 × sizeof(int) = 12 bytes
```

---

# 3. Variables: Scope, Lifetime and Storage

Three concepts must be separated:

### Scope
Where the variable can be accessed.

### Lifetime
How long the variable exists.

### Storage duration
How long its storage remains allocated.

For GATE, the most important keyword is `static`.

---

## 3.1 Local automatic variable

```c
void f() {
    int x = 10;
}
```

Normally, `x` is created when execution enters the block and disappears when the block ends.

---

## 3.2 Static local variable

```c
void f() {
    static int x = 0;
    x++;
    printf("%d ", x);
}
```

If:

```c
f();
f();
f();
```

output is:

```text
1 2 3
```

### Trick

`static local`:

> **scope = local, lifetime = entire program**

It remembers its previous value between function calls.

---

# 4. Operators

## Arithmetic

```text
+  -  *  /  %
```

For integers:

```c
7 / 2
```

gives:

```text
3
```

while:

```c
7.0 / 2
```

gives:

```text
3.5
```

### `%`

```c
17 % 5 = 2
```

For positive integers, `%` gives the remainder.

---

# 5. Relational and Logical Operators

Relational:

```text
<  <=  >  >=  ==  !=
```

Logical:

```text
&&  ||  !
```

C treats:

```text
0       → false
nonzero → true
```

Therefore:

```c
if (5)
```

is true.

```c
if (-2)
```

is also true.

---

# 6. Short-Circuit Evaluation

This is a very important GATE trick.

## `&&`

```c
A && B
```

If `A` is false, `B` is **not evaluated**.

Example:

```c
int x = 0;

if (x && ++x)
    printf("Yes");
```

`++x` is not executed.

So:

```text
x = 0
```

---

## `||`

```c
A || B
```

If `A` is true, `B` is **not evaluated**.

Example:

```c
int x = 5;

if (x || ++x)
    printf("Yes");
```

`++x` is not executed.

So:

```text
x = 5
```

### GATE Trick

Whenever you see:

```c
&&
||
```

ask:

> **Will the right side actually execute?**

---

# 7. Increment and Decrement

## Pre-increment

```c
++x
```

First increment, then use.

Example:

```c
int x = 5;
int y = ++x;
```

Result:

```text
x = 6
y = 6
```

## Post-increment

```c
x++
```

First use, then increment.

```c
int x = 5;
int y = x++;
```

Result:

```text
x = 6
y = 5
```

---

## Pointer increment

```c
p++;
```

does **not** mean:

```text
address + 1 byte
```

It means:

```text
address + sizeof(*p)
```

If `p` is an `int *` and `int` is 4 bytes:

```text
p++ → address + 4 bytes
```

---

# 8. Operator Precedence — GATE Revision

You do not need to memorize every obscure operator combination. Know these:

```text
()
[]
-> .
        highest

unary:
++ -- * & ! ~

* / %

+ -

< <= > >=

== !=

&

^

|

&&

||

?:

= += -= *= /= ...

        lowest
```

### Pointer warning

These are different:

```c
*p++
(*p)++
++*p
```

Interpretation:

### `*p++`

Equivalent to:

```c
*(p++)
```

Pointer moves.

### `(*p)++`

Value pointed to by `p` increases.

### `++*p`

Equivalent to:

```c
++(*p)
```

Value pointed to by `p` increases first.

### Super Trick

```text
*p++     → move pointer
(*p)++   → change value
++*p     → change value
```

---

# 9. Functions

C uses **pass by value**.

Example:

```c
void f(int x) {
    x = 100;
}

int main() {
    int a = 10;
    f(a);
    printf("%d", a);
}
```

Output:

```text
10
```

Because `x` is a copy.

---

# 10. Simulating Call by Reference Using Pointers

To modify the caller's variable:

```c
void f(int *x) {
    *x = 100;
}

int main() {
    int a = 10;
    f(&a);
    printf("%d", a);
}
```

Output:

```text
100
```

### GATE Trick

```text
f(a)    → value copied
f(&a)   → address passed
*x      → original value accessed
```

---

# 11. Pointer Basics

Suppose:

```c
int x = 10;
int *p = &x;
```

Then:

```text
x     = 10
&x    = address of x
p     = address of x
*p    = 10
&p    = address of pointer p
```

Visualize:

```text
       p
       |
       v
   +-------+
   |   10  |
   +-------+
       x
```

---

# 12. `&` and `*`

### Address operator

```c
&x
```

means:

> address of x

### Dereference operator

```c
*p
```

means:

> value stored at the address contained in p

---

# 13. Pointer to Pointer

```c
int x = 10;
int *p = &x;
int **q = &p;
```

Relationship:

```text
q → p → x
```

Therefore:

```c
*q
```

is `p`.

```c
**q
```

is `x`.

So:

```c
**q = 50;
```

changes `x` to:

```text
50
```

### GATE Trick

Count the `*`:

```text
p       → one level
*p      → value
q       → pointer to pointer
*q      → pointer
**q     → final value
```

---

# 14. Arrays

```c
int a[5] = {10,20,30,40,50};
```

Memory:

```text
index:   0   1   2   3   4
value:  10  20  30  40  50
```

Important:

```c
a[i] == *(a+i)
```

Therefore:

```c
a[3]
```

is:

```c
*(a+3)
```

which is:

```text
40
```

---

# 15. Array Name and Pointer

For most expressions:

```c
a
```

behaves like:

```c
&a[0]
```

Therefore:

```c
a + 2
```

points to:

```text
a[2]
```

and:

```c
*(a+2)
```

is:

```text
a[2]
```

### Important exception

Array name does **not** behave as a modifiable pointer.

This is invalid:

```c
a++;
```

---

# 16. Pointer Arithmetic

If:

```c
int a[5];
int *p = a;
```

then:

```text
p + 0 → a[0]
p + 1 → a[1]
p + 2 → a[2]
```

It is scaled by the size of the pointed type.

If:

```text
sizeof(int) = 4
```

and:

```text
a starts at 1000
```

then:

```text
a+1 = 1004
a+2 = 1008
a+3 = 1012
```

---

# 17. Pointer Difference

If:

```c
int a[10];
int *p = &a[2];
int *q = &a[7];
```

then:

```c
q - p
```

is:

```text
5
```

not:

```text
20
```

because pointer difference counts elements.

---

# 18. Two-Dimensional Arrays

Consider:

```c
int a[3][4];
```

There are:

```text
3 rows
4 columns
12 integers
```

`a[i][j]` means:

```c
*(*(a+i)+j)
```

### Most important identity

```text
a[i][j]
= *(a[i] + j)
= *(*(a+i)+j)
```

---

# 19. Row-Major Storage

C stores a 2-D array in **row-major order**.

For:

```c
int a[2][3] = {
    {1,2,3},
    {4,5,6}
};
```

memory is:

```text
1 2 3 4 5 6
```

not:

```text
1 4 2 5 3 6
```

---

# 20. 2-D Array Address Trick

For:

```c
int a[R][C];
```

the element:

```c
a[i][j]
```

is located after:

```text
i*C + j
```

elements from the first element.

So:

```c
*(a[1] + 2)
```

means:

```text
row 1, column 2
```

---

# 21. String Basics

C strings are character arrays ending with:

```c
'\0'
```

Example:

```c
char s[] = "GATE";
```

Memory:

```text
G A T E \0
```

So size is:

```text
5
```

not 4.

---

# 22. `strlen` vs `sizeof`

For:

```c
char s[] = "GATE";
```

```c
strlen(s) = 4
sizeof(s) = 5
```

because `sizeof` includes the null character.

For:

```c
char *p = "GATE";
```

`sizeof(p)` is the size of the pointer, **not** the string length.

### GATE Trick

```text
strlen → characters before '\0'
sizeof  → storage occupied by the object
```

---

# 23. Character Array vs String Literal Pointer

```c
char s[] = "GATE";
```

creates an array containing the characters.

But:

```c
char *p = "GATE";
```

makes `p` point to a string literal.

Do not assume a string literal is writable.

Avoid:

```c
p[0] = 'X';
```

---

# 24. Recursion

A recursive function must have:

1. Base case
2. Recursive case

Example:

```c
int fact(int n) {
    if (n == 0)
        return 1;

    return n * fact(n-1);
}
```

For:

```c
fact(4)
```

trace:

```text
fact(4)
= 4 × fact(3)
= 4 × 3 × fact(2)
= 4 × 3 × 2 × fact(1)
= 4 × 3 × 2 × 1 × fact(0)
= 24
```

---

# 25. Recursion Stack Trick

For:

```c
void f(int n) {
    if(n == 0)
        return;

    printf("%d ", n);
    f(n-1);
}
```

`f(3)` prints:

```text
3 2 1
```

But:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
    printf("%d ", n);
}
```

prints:

```text
1 2 3
```

### GATE Trick

- `printf` **before recursion** → descending order.
- `printf` **after recursion** → ascending order.

---

# 26. Recursion with Two Calls

Example:

```c
void f(int n) {
    if(n <= 0) return;

    printf("%d ", n);
    f(n-1);
    f(n-1);
}
```

Do not assume the two calls execute simultaneously.

They execute sequentially:

```text
f(n)
 ├── f(n-1)
 │    ├── ...
 │    └── ...
 └── f(n-1)
      ├── ...
      └── ...
```

Number of calls often gives a recurrence.

For:

```c
T(n) = 2T(n-1) + O(1)
```

time is:

```text
O(2^n)
```

---

# 27. Scope and Shadowing

Example:

```c
int x = 10;

void f() {
    int x = 20;
    printf("%d", x);
}
```

Inside `f`, the local `x` shadows the global `x`.

Output:

```text
20
```

### Trick

Search for the **nearest declaration in the current scope**.

---

# 28. `static` and Recursion

Example:

```c
void f(int n) {
    static int x = 0;

    if(n == 0)
        return;

    x++;
    printf("%d ", x);
    f(n-1);
}
```

For `f(3)`:

```text
1 2 3
```

`x` is shared across recursive calls because it is static.

---

# 29. Storage Classes — Quick Table

| Keyword | Typical scope | Lifetime |
|---|---|---|
| `auto` | local/block | block execution |
| `register` | local/block | block execution |
| `static` local | local/block | entire program |
| `extern` | depends on declaration | external/global object lifetime |

### GATE focus

`static` is the most frequently useful one for output tracing.

---

# 30. Structures

Example:

```c
struct Student {
    int age;
    char grade;
};
```

Create:

```c
struct Student s;
```

Access:

```c
s.age
s.grade
```

Pointer:

```c
struct Student *p = &s;
```

Access with:

```c
p->age
```

which is equivalent to:

```c
(*p).age
```

### Trick

```text
object      → .
pointer     → ->
```

---

# 31. Dynamic Memory

Important functions:

```c
malloc()
calloc()
realloc()
free()
```

### `malloc`

Allocates a block of uninitialized memory.

```c
int *p = malloc(5 * sizeof(int));
```

### `calloc`

Allocates and initializes allocated bytes to zero.

```c
int *p = calloc(5, sizeof(int));
```

### `realloc`

Changes the size of an existing allocation.

### `free`

Releases dynamically allocated memory.

---

# 32. Dangling Pointer

Example:

```c
int *p = malloc(sizeof(int));
free(p);
```

After `free(p)`, using `*p` is invalid.

`p` is a dangling pointer unless it is reset:

```c
p = NULL;
```

---

# 33. Returning Address of a Local Variable

Dangerous:

```c
int *f() {
    int x = 10;
    return &x;
}
```

After `f` returns, the local variable's lifetime has ended.

Therefore the returned pointer is invalid for accessing that local object.

### GATE Trick

Ask:

> Does the pointed object still exist after the function returns?

If not, the pointer is invalid/dangling.

---

# 34. Undefined Behavior — Extremely Important

GATE may ask about a program that should **not** be evaluated as a normal deterministic output question.

Examples include:

```c
int i = 5;
printf("%d %d", i++, i++);
```

The order/evaluation interaction can make the program undefined depending on the exact expression and language rules.

Also dangerous:

```c
int a[3];
printf("%d", a[5]);
```

or dereferencing an invalid pointer.

### Rule

If the C standard does not define a unique behavior:

> **Do not invent an output.**

---

# 35. Bitwise Operators

Operators:

```text
&
|
^
~
<<
>>
```

## AND

```text
1 & 1 = 1
otherwise 0
```

Useful for masking.

## OR

```text
0 | 0 = 0
otherwise 1
```

## XOR

```text
0 ^ 0 = 0
1 ^ 1 = 0
0 ^ 1 = 1
1 ^ 0 = 1
```

Important properties:

```text
x ^ 0 = x
x ^ x = 0
x ^ y ^ y = x
```

---

# 36. Shift Tricks

For non-negative integers, when no overflow/sign issue is involved:

```text
x << 1  ≈ x × 2
x << k  ≈ x × 2^k
x >> 1  ≈ x / 2
```

Be careful with signed integers and boundary cases.

### Power of 2 test

For positive integer `n`:

```c
(n & (n-1)) == 0
```

means `n` is a power of 2.

Examples:

```text
8  = 1000
7  = 0111

1000 & 0111 = 0000
```

---

# 37. Common GATE Pointer Traps

## Trap 1

```c
int a[] = {10,20,30};
int *p = a;

printf("%d", *p++);
```

Interpret as:

```c
*(p++)
```

Output:

```text
10
```

Afterwards:

```text
p → a[1]
```

---

## Trap 2

```c
printf("%d", (*p)++);
```

Value is printed first, then the pointed value increases.

---

## Trap 3

```c
printf("%d", ++*p);
```

Pointed value increases first.

---

# 38. Common Array Traps

Remember:

```c
a[i] == i[a]
```

because both become:

```c
*(a+i)
```

Example:

```c
int a[] = {10,20,30};

printf("%d", 2[a]);
```

Output:

```text
30
```

This is legal C syntax, although rarely used in real code.

---

# 39. Pointer-to-Array vs Array-of-Pointers

These are different.

```c
int *p[5];
```

means:

> array of 5 pointers to int

But:

```c
int (*p)[5];
```

means:

> pointer to an array of 5 integers

### Bracket trick

Look immediately next to the variable name.

```text
*p[5]      → [] binds before *
(*p)[5]    → p is pointer to array
```

---

# 40. Function Pointer Basics

```c
int (*fp)(int);
```

means:

> `fp` is a pointer to a function taking an `int` and returning `int`.

Do not confuse with:

```c
int *fp(int);
```

which declares a function returning `int *`.

---

# 41. Macro Trap

```c
#define SQUARE(x) x*x
```

Then:

```c
SQUARE(2+3)
```

expands to:

```c
2+3*2+3
```

which gives:

```text
11
```

not 25.

Correct macro:

```c
#define SQUARE(x) ((x)*(x))
```

### GATE Trick

Preprocessor macros are textual substitution.

---

# 42. `sizeof` Tricks

For:

```c
int a[10];
```

inside the same scope:

```c
sizeof(a)
```

gives total bytes occupied by the array.

If:

```text
sizeof(int) = 4
```

then:

```text
sizeof(a) = 40
```

But after passing `a` to a function:

```c
void f(int a[])
```

the parameter behaves as a pointer for this purpose.

So:

```c
sizeof(a)
```

inside `f` gives pointer size, not the complete original array size.

---

# 43. GATE Output-Tracing Template

Use this table:

| Step | Variable | Pointer | Action |
|---|---|---|---|
| 1 | `x=10` | `p→x` | initialize |
| 2 | `x=20` | `p→x` | `*p=20` |
| 3 | `x=20` | `p→a[1]` | `p++` |

For complicated programs, this avoids mental mistakes.

---

# 44. PYQ 1 — GATE 2026 Set 2

### Question

Consider:

```c
int *ptr, a, b, c;

a = 5;
b = 11;
c = 20;

ptr = &a;
*ptr = c;

ptr = &c;
a = *(&b);
c = *ptr - a;

printf("%d", c);
```

### Step 1

Initially:

```text
a=5
b=11
c=20
```

### Step 2

```c
ptr = &a;
*ptr = c;
```

So:

```text
a = 20
```

Now:

```text
a=20
b=11
c=20
```

### Step 3

```c
ptr = &c;
a = *(&b);
```

`&b` is address of `b`, and `*(&b)` is `b`.

Therefore:

```text
a = 11
```

### Step 4

```c
c = *ptr - a;
```

Since `ptr → c`:

```text
*ptr = c = 20
```

Therefore:

```text
c = 20 - 11 = 9
```

### Answer

```text
9
```

**Concept:** pointer dereferencing + address operator.

---

# 45. PYQ 2 — GATE 2025 Set 2

Consider:

```c
int a;
int arr[5] = {30,50,10};
int *ptr;

ptr = &arr[0] + 1;
a = *ptr;
(*ptr)++;
ptr++;

printf("%d", a + (*ptr) + arr[1]);
```

### Trace

Initially:

```text
arr = {30,50,10,0,0}
```

Then:

```c
ptr = &arr[0] + 1;
```

So:

```text
ptr → arr[1]
```

Then:

```c
a = *ptr;
```

Therefore:

```text
a = 50
```

Then:

```c
(*ptr)++;
```

so:

```text
arr[1] = 51
```

Then:

```c
ptr++;
```

Now:

```text
ptr → arr[2]
```

Therefore:

```text
*ptr = 10
arr[1] = 51
a = 50
```

Output:

```text
50 + 10 + 51 = 111
```

### Answer

```text
111
```

**Concept:** pointer movement vs pointed-value modification.

---

# 46. PYQ 3 — GATE 2025 Set 2

Consider the string-copy program where:

```c
char a[30] = "@#Hello World!";
stringcopy(a, a+2);
```

and the function repeatedly copies the character pointed to by `t` into `s`, while advancing both pointers.

### Key observation

Initially:

```text
a:
@ # H e l l o   W o r l d ! \0
```

Source pointer:

```text
a+2 → H
```

Destination pointer:

```text
a → @
```

Characters are copied from the third character toward the beginning.

The copy continues until `'\0'`.

The important subtlety is that **source and destination overlap**, so the destination writes can alter characters that the source pointer will later read.

Tracing the overlap produces the corresponding GATE answer.

### Concept tested

```text
pointer arithmetic
+
character arrays
+
overlapping copy
+
'\0'
```

### GATE Trick

When source and destination are within the same array:

> Never assume a string copy behaves like `memmove`.

Trace the exact read/write sequence.

---

# 47. PYQ 4 — GATE 2025 Set 1

```c
void foo(int *p, int x) {
    *p = x;
}

int main() {
    int *z;
    int a = 20, b = 25;

    z = &a;
    foo(z, b);

    printf("%d", a);
}
```

### Trace

Initially:

```text
a = 20
b = 25
```

`z` points to `a`.

Function call:

```c
foo(z,b)
```

means:

```text
p → a
x = 25
```

Then:

```c
*p = x;
```

becomes:

```text
a = 25
```

### Answer

```text
25
```

**Concept:** modifying caller data using a pointer.

---

# 48. PYQ 5 — GATE 2024 Set 2

```c
double a[2] = {20.0, 25.0}, *p, *q;

p = a;
q = p + 1;

printf("%d,%d", (int)(q-p), (int)(*q-*p));
```

### First expression

```c
q - p
```

Both pointers point into the same array.

```text
q → a[1]
p → a[0]
```

Therefore:

```text
q-p = 1
```

### Second expression

```c
*q - *p
```

is:

```text
25.0 - 20.0 = 5.0
```

After conversion to `int`:

```text
5
```

### Answer

```text
1,5
```

### Trick

Separate:

```text
pointer difference → number of elements
value difference   → numerical value difference
```

---

# 49. PYQ 6 — GATE 2022

Consider:

```c
int x = 1, z[2] = {10,11};
int *p = NULL;

p = &x;
*p = 10;

p = &z[1];
*(&z[0] + 1) += 3;

printf("%d, %d, %d", x, z[0], z[1]);
```

### Trace

Initially:

```text
x=1
z={10,11}
```

```c
p=&x;
*p=10;
```

Therefore:

```text
x=10
```

Then:

```c
*(&z[0]+1) += 3;
```

`&z[0] + 1` points to `z[1]`.

So:

```text
z[1] = 11+3 = 14
```

### Answer

```text
10, 10, 14
```

**Concept:** pointer arithmetic inside arrays.

---

# 50. PYQ 7 — GATE 2019

```c
int arr[] = {2,4,6,8,10};
int i, sum=0, *b=arr+4;

for(i=0;i<5;i++)
    sum = sum + (*b-i) - *(b-i);
```

Here:

```text
b → arr[4] → 10
```

For each `i`:

```text
i=0: (10-0) - arr[4] = 0
i=1: (10-1) - arr[3] = 1
i=2: (10-2) - arr[2] = 2
i=3: (10-3) - arr[1] = 3
i=4: (10-4) - arr[0] = 4
```

Therefore:

```text
sum = 0+1+2+3+4 = 10
```

### Answer

```text
10
```

### Trick

Convert pointer expressions into array indices immediately.

---

# 51. PYQ 8 — GATE 2018

```c
void fun1(char *s1, char *s2) {
    char *tmp;
    tmp = s1;
    s1 = s2;
    s2 = tmp;
}

void fun2(char **s1, char **s2) {
    char *tmp;
    tmp = *s1;
    *s1 = *s2;
    *s2 = tmp;
}
```

The key difference:

### `fun1`

Parameters are copied.

Changing:

```c
s1
s2
```

does not change the caller's pointers.

### `fun2`

The addresses of the caller's pointers are passed.

So:

```c
*s1
*s2
```

can modify the caller's pointer variables.

### GATE takeaway

```text
int *p     → can modify int through *p
char **p   → can modify a char* through *p
```

---

# 52. PYQ 9 — GATE 2016

```c
void mystery(int *ptra, int *ptrb) {
    int *temp;
    temp = ptrb;
    ptrb = ptra;
    ptra = temp;
}
```

Question asks whether the original variables change after calling:

```c
mystery(&a, &b);
```

### Answer reasoning

`ptra` and `ptrb` are local pointer variables.

Swapping them only swaps the **local copies of the addresses**.

The caller's `a` and `b` values are not modified.

### GATE Trick

Passing:

```c
&a, &b
```

does not automatically mean the function can swap `a` and `b`.

To change the caller's pointer variables themselves, you need pointer-to-pointer parameters.

---

# 53. PYQ 10 — GATE 2015

```c
void f1(int a, int b) {
    int c;
    c=a;
    a=b;
    b=c;
}

void f2(int *a, int *b) {
    int c;
    c=*a;
    *a=*b;
    *b=c;
}
```

### `f1`

Only local copies are exchanged.

Caller variables remain unchanged.

### `f2`

Actual caller variables are exchanged through pointers.

### GATE concept

```text
f1(a,b)       → local copies
f2(&a,&b)     → modifies original values
```

---

# 54. PYQ 11 — GATE 2012: Static Variables

A common GATE pattern uses:

```c
static int a = 1;
```

in one function and another `static` variable inside a called function.

### Important observation

Two variables named `a` can still be completely different objects if they are declared in different scopes.

Example:

```c
int main() {
    static int a = 1;
    f();
}

void f() {
    static int a = 2;
}
```

These are **two different variables**.

### GATE Trick

Same name ≠ same variable.

Always identify:

```text
scope
+
declaration
```

before tracing.

---

# 55. PYQ 12 — GATE 2008

A classic question uses:

```c
int f(int x, int *py, int **ppz)
```

with operations such as:

```c
**ppz += 1;
*py += 2;
x += 3;
```

### Correct tracing method

If:

```text
x = 4
b = &c
a = &b
```

then:

```text
x     → copy of c
py    → c
*py   → c
ppz   → b
*ppz  → b
**ppz → c
```

Therefore:

```c
**ppz += 1;
```

changes the original `c`.

Similarly:

```c
*py += 2;
```

also changes the original `c`.

But:

```c
x += 3;
```

only changes the local copy.

### GATE Trick

For every parameter, write:

```text
parameter → what object?
```

before evaluating the function.

---

# 56. PYQ 13 — GATE 2001: Bad Pointers

Three common patterns:

### P1

```c
int *g(void) {
    int x=10;
    return &x;
}
```

Problem:

```text
x is a local variable
```

It no longer exists after the function returns.

---

### P2

```c
int *g(void) {
    int *px;
    *px = 10;
    return px;
}
```

`px` is an uninitialized pointer.

Dereferencing it is invalid.

---

### P3

```c
int *g(void) {
    int *px = malloc(sizeof(int));
    *px = 10;
    return px;
}
```

The allocated object remains alive until `free` is called.

### GATE takeaway

Safe pointer return generally requires the pointed object to remain alive after function return.

---

# 57. Most Important GATE Tricks — One Page

## Trick 1

```c
a[i] == *(a+i)
```

---

## Trick 2

```c
i[a] == a[i]
```

---

## Trick 3

```c
*p++ == *(p++)
```

---

## Trick 4

```c
(*p)++
```

changes the value.

---

## Trick 5

```c
p++
```

moves the pointer.

---

## Trick 6

```c
*p = x
```

changes the object pointed to by `p`.

---

## Trick 7

```c
q-p
```

counts array elements between pointers.

---

## Trick 8

```c
a[i][j] == *(*(a+i)+j)
```

---

## Trick 9

```c
p->x == (*p).x
```

---

## Trick 10

```text
static local → remembers value
```

---

## Trick 11

```text
f(x) → x copied
f(&x) → address passed
```

---

## Trick 12

```text
strlen("GATE") = 4
sizeof("GATE") = 5
```

---

## Trick 13

```text
&& → stop on false
|| → stop on true
```

---

## Trick 14

```text
printf before recursion → downward
printf after recursion  → upward
```

---

## Trick 15

```text
array name ≈ pointer to first element
```

but:

```c
a++;
```

is not valid for an array object.

---

# 58. Common Mistakes to Avoid

### Mistake 1: Treating `p++` as changing the value

Wrong:

```text
p++ → *p increases
```

Correct:

```text
p++ → pointer moves
```

---

### Mistake 2: Forgetting null character

```c
char s[]="ABC";
```

requires:

```text
A B C \0
```

---

### Mistake 3: Confusing `&p` with `*p`

```text
&p → address of pointer
*p → object pointed to
```

---

### Mistake 4: Assuming all function arguments modify originals

C is pass-by-value.

---

### Mistake 5: Ignoring scope

Two variables with the same name may be different objects.

---

### Mistake 6: Calculating an output despite undefined behavior

Always check validity first.

---

# 59. GATE Question-Solving Workflow

For an output question:

### Step 1 — Mark declarations

Underline:

```text
int
char
*
[]
static
```

### Step 2 — Draw pointers

Example:

```text
p → x
q → p
```

### Step 3 — Convert array expressions

```c
*(a+3)
```

to:

```text
a[3]
```

### Step 4 — Apply operator precedence

Especially:

```c
*p++
(*p)++
++*p
```

### Step 5 — Execute line by line

Never jump multiple lines.

### Step 6 — Check undefined behavior

Only then give the output.

---

# 60. Rapid Revision Sheet

```text
C is pass-by-value.

&a       = address of a
*p       = value pointed to by p

a[i]     = *(a+i)

p+i      = pointer shifted by i elements
q-p      = number of elements between pointers

a[i][j]  = *(*(a+i)+j)

p->x     = (*p).x

*p++     = *(p++)
(*p)++   = increment pointed value
++*p     = increment pointed value before use

&&       = short-circuit if left is false
||       = short-circuit if left is true

static local = retains value across function calls

strlen   = characters before '\0'
sizeof   = storage size of object

malloc   = allocated memory, not initialized to zero
calloc   = allocated memory initialized to zero
free     = release allocated memory

char *p = "ABC";
char a[] = "ABC";

array    = contiguous memory
C 2-D arrays = row-major

struct object  → .
struct pointer → ->

x ^ x = 0
x ^ 0 = x
x & (x-1) = 0 for positive power-of-two x
```

---

# 61. PYQ Topic Mapping

| PYQ concept | Topic to revise |
|---|---|
| Pointer modifying variable | `*`, `&` |
| `q-p` | pointer arithmetic |
| `a+i` | array-pointer relation |
| `a[i][j]` | 2-D arrays |
| `char *` and strings | strings |
| `**p` | pointer-to-pointer |
| `static` | storage class |
| local pointer return | lifetime/dangling pointer |
| recursion output | call stack |
| `f(x)` vs `f(&x)` | parameter passing |
| `->` | structures |
| `malloc` | dynamic memory |
| `&&`, `||` | short-circuit |
| `++` with pointers | precedence |

---

# 62. What to Memorize vs What to Understand

## Memorize

```text
a[i] = *(a+i)

a[i][j] = *(*(a+i)+j)

p->x = (*p).x

*p++ = *(p++)

strlen excludes '\0'

C passes arguments by value

static local retains value
```

## Understand

```text
pointer arithmetic
recursion stack
scope
lifetime
array memory layout
pointer-to-pointer
dynamic allocation
undefined behavior
```

Do not try to memorize output answers. Memorize the **method of tracing**.

---

# 63. Final GATE Checklist for C Programming

Before moving to the next subject, you should be able to solve without notes:

- [ ] Pointer dereferencing
- [ ] Pointer arithmetic
- [ ] Pointer-to-pointer
- [ ] Array-pointer equivalence
- [ ] 2-D array addressing
- [ ] String memory representation
- [ ] `strlen` vs `sizeof`
- [ ] Function parameter behavior
- [ ] Recursion tracing
- [ ] Static local variables
- [ ] Scope/shadowing
- [ ] Structure pointer `->`
- [ ] `malloc/calloc/free`
- [ ] Dangling/uninitialized pointers
- [ ] Operator precedence
- [ ] `*p++`, `(*p)++`, `++*p`
- [ ] Short-circuit evaluation
- [ ] Bitwise operations
- [ ] Undefined behavior recognition
- [ ] Output tracing using a variable table

---

# 64. PYQ Practice Order

For GATE preparation, solve C PYQs in this order:

```text
1. Pointer + Array
        ↓
2. Pointer + Function
        ↓
3. Recursion
        ↓
4. Storage Class
        ↓
5. Strings
        ↓
6. 2-D Arrays
        ↓
7. Dynamic Memory
        ↓
8. Structures
        ↓
9. Bitwise
        ↓
10. Mixed Output Questions
```

### Recommended revision cycle

```text
Concept → 5 PYQs → error analysis → 10 mixed questions → revision
```

The goal is not merely to know C syntax.

The GATE goal is:

> **Given a short C program, determine exactly what each object contains at every important step.**
