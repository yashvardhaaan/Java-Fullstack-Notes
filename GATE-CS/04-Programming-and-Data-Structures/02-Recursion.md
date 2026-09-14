# 02 — Recursion.md

````md
# 02 — Recursion: GATE CSE Notes, Tricks & PYQ Explanations

> **Target:** GATE CSE/IT  
> **Focus:** Recursion theory + recursion trees + recurrence relations + time complexity + output tracing + GATE PYQ patterns.

---

# 0. GATE Strategy for Recursion

Recursion is one of the most important topics in GATE because it connects:

```text
Recursion
   ↓
Call Stack
   ↓
Recurrence Relation
   ↓
Time Complexity
   ↓
Trees / Divide & Conquer
````

GATE commonly asks:

* Output of recursive programs
* Number of recursive calls
* Recurrence relations
* Time complexity
* Space complexity
* Recursion trees
* Nested recursion
* Multiple recursive calls
* Tail vs non-tail recursion
* Recursion involving arrays/pointers
* Recursion converted to iteration

---

# 1. What is Recursion?

Recursion is a technique in which a function calls itself.

Example:

```c
void f(int n) {
    if (n == 0)
        return;

    printf("%d ", n);
    f(n - 1);
}
```

Calling:

```c
f(3);
```

produces:

```text
3 2 1
```

---

# 2. Two Essential Parts of Recursion

Every useful recursive function generally contains:

```text
1. Base Case
2. Recursive Case
```

## Base Case

Stops recursion.

Example:

```c
if (n == 0)
    return;
```

## Recursive Case

Calls the function with a smaller/simpler input.

```c
f(n-1);
```

### GATE Trick

Always identify the base case first.

Ask:

> **When does recursion stop?**

Then determine how the input changes in every recursive call.

---

# 3. Simple Recursion

Consider:

```c
void f(int n) {
    if (n <= 0)
        return;

    printf("%d ", n);
    f(n-1);
}
```

For:

```text
f(4)
```

call sequence:

```text
f(4)
 ↓
f(3)
 ↓
f(2)
 ↓
f(1)
 ↓
f(0)
```

Output:

```text
4 3 2 1
```

---

# 4. Recursion Happens Using the Call Stack

Every function call creates a stack frame.

For:

```c
f(3);
```

the stack grows:

```text
f(3)
f(2)
f(1)
f(0)
```

At the base case, recursion returns.

Then stack frames are removed:

```text
f(0) returns
    ↓
f(1) returns
    ↓
f(2) returns
    ↓
f(3) returns
```

## GATE Trick

There are two directions:

```text
CALLING PHASE
3 → 2 → 1 → 0

RETURNING PHASE
0 → 1 → 2 → 3
```

Many output questions depend on whether `printf()` happens during the calling phase or returning phase.

---

# 5. Print Before Recursive Call

```c
void f(int n) {
    if (n == 0)
        return;

    printf("%d ", n);
    f(n-1);
}
```

For:

```text
f(4)
```

Output:

```text
4 3 2 1
```

Because printing occurs while going **down** the recursion.

---

# 6. Print After Recursive Call

```c
void f(int n) {
    if (n == 0)
        return;

    f(n-1);
    printf("%d ", n);
}
```

For:

```text
f(4)
```

Output:

```text
1 2 3 4
```

Because printing occurs while returning.

## Golden Trick

```text
Before recursive call → descending

After recursive call  → ascending
```

---

# 7. Print Both Before and After

Consider:

```c
void f(int n) {
    if (n == 0)
        return;

    printf("%d ", n);
    f(n-1);
    printf("%d ", n);
}
```

For:

```text
f(3)
```

Calling phase:

```text
3 2 1
```

Returning phase:

```text
1 2 3
```

Complete output:

```text
3 2 1 1 2 3
```

---

# 8. Recursion Tree

Consider:

```c
void f(int n) {
    if (n <= 0)
        return;

    f(n-1);
    f(n-1);
}
```

The recursion tree:

```text
             f(3)
            /    \
         f(2)    f(2)
         / \      / \
      f(1) f(1) f(1) f(1)
      / \   / \  / \   / \
    f(0) ...             f(0)
```

Number of calls grows exponentially.

Recurrence:

```text
T(n) = 2T(n-1) + Θ(1)
```

Therefore:

```text
T(n) = Θ(2^n)
```

---

# 9. Number of Calls in Binary Recursion

For:

```c
f(n) {
    if(n == 0)
        return;

    f(n-1);
    f(n-1);
}
```

Let:

```text
C(n) = number of calls
```

Then:

```text
C(n) = 2C(n-1) + 1
```

with:

```text
C(0) = 1
```

Solution:

```text
C(n) = 2^(n+1) - 1
```

Therefore:

```text
C(n) = Θ(2^n)
```

## GATE Trick

If each call generates two calls with input `n-1`:

```text
number of calls ≈ 2^n
```

---

# 10. Linear Recursion

Example:

```c
void f(int n) {
    if (n == 0)
        return;

    f(n-1);
}
```

Only one recursive call.

Recurrence:

```text
T(n) = T(n-1) + Θ(1)
```

Therefore:

```text
T(n) = Θ(n)
```

Space:

```text
Θ(n)
```

because there can be `n` active stack frames.

---

# 11. Recursion with `n/2`

Consider:

```c
void f(int n) {
    if (n <= 1)
        return;

    f(n/2);
}
```

Recurrence:

```text
T(n) = T(n/2) + Θ(1)
```

Therefore:

```text
T(n) = Θ(log n)
```

Stack depth:

```text
Θ(log n)
```

---

# 12. Recursion with `n/2` Twice

Consider:

```c
void f(int n) {
    if (n <= 1)
        return;

    f(n/2);
    f(n/2);
}
```

Recurrence:

```text
T(n) = 2T(n/2) + Θ(1)
```

Using Master Theorem:

```text
a = 2
b = 2
f(n) = Θ(1)
```

Since:

```text
n^(log_b a)
= n^(log₂2)
= n
```

we get:

```text
T(n) = Θ(n)
```

---

# 13. Important Recurrence Patterns

Memorize these.

| Recurrence           | Complexity               |
| -------------------- | ------------------------ |
| `T(n)=T(n-1)+1`      | `Θ(n)`                   |
| `T(n)=T(n-1)+n`      | `Θ(n²)`                  |
| `T(n)=T(n/2)+1`      | `Θ(log n)`               |
| `T(n)=T(n/2)+n`      | `Θ(n)`                   |
| `T(n)=2T(n/2)+1`     | `Θ(n)`                   |
| `T(n)=2T(n/2)+n`     | `Θ(n log n)`             |
| `T(n)=4T(n/2)+n`     | `Θ(n²)`                  |
| `T(n)=2T(n-1)+1`     | `Θ(2^n)`                 |
| `T(n)=T(n-1)+T(n-2)` | `Θ(φ^n)` naive recursion |
| `T(n)=T(n-1)+log n`  | `Θ(n log n)`             |

where:

```text
φ ≈ 1.618
```

---

# 14. Recurrence: `T(n)=T(n-1)+n`

Consider:

```c
void f(int n) {
    if(n <= 0)
        return;

    for(int i=0; i<n; i++)
        printf("*");

    f(n-1);
}
```

Work:

```text
n + (n-1) + (n-2) + ... + 1
```

Sum:

```text
n(n+1)/2
```

Therefore:

```text
T(n) = Θ(n²)
```

## GATE Trick

Whenever:

```text
T(n) = T(n-1) + n
```

think:

```text
1 + 2 + ... + n
= Θ(n²)
```

---

# 15. Recurrence: `T(n)=T(n/2)+n`

Consider:

```c
void f(int n) {
    if(n <= 1)
        return;

    for(int i=0; i<n; i++)
        printf("*");

    f(n/2);
}
```

Work:

```text
n + n/2 + n/4 + n/8 + ...
```

This is a geometric series.

Therefore:

```text
T(n) = Θ(n)
```

## GATE Trick

Do not automatically multiply recursion depth by work.

Use the actual recursion tree or recurrence.

---

# 16. Recursion with Two Different Sizes

Consider:

```text
T(n) = T(n/2) + T(n/4) + n
```

The recursion tree is not a standard Master Theorem form.

Master Theorem directly applies to:

```text
aT(n/b) + f(n)
```

but not generally to:

```text
T(n/2) + T(n/4)
```

## GATE Trick

Do not force every recurrence into Master Theorem.

Use:

* recursion tree
* substitution
* Akra-Bazzi, when required
* bounds

---

# 17. Factorial Recursion

```c
int fact(int n) {
    if(n == 0)
        return 1;

    return n * fact(n-1);
}
```

Recurrence:

```text
T(n) = T(n-1) + Θ(1)
```

Therefore:

```text
Time = Θ(n)
Space = Θ(n)
```

Important:

```text
factorial value ≠ factorial time complexity
```

The function computes:

```text
n!
```

but its running time is only:

```text
Θ(n)
```

---

# 18. Fibonacci Recursion

Naive implementation:

```c
int fib(int n) {
    if(n <= 1)
        return n;

    return fib(n-1) + fib(n-2);
}
```

Recurrence:

```text
T(n) = T(n-1) + T(n-2) + Θ(1)
```

This gives exponential time.

More precisely:

```text
T(n) = Θ(φ^n)
```

where:

```text
φ = (1 + √5)/2
```

Often described simply as:

```text
O(2^n)
```

in basic GATE analysis.

Space:

```text
Θ(n)
```

because the maximum recursion depth is `n`.

---

# 19. Fibonacci with Memoization

If already computed values are stored:

```text
fib(0)
fib(1)
...
fib(n)
```

each state is computed once.

Time:

```text
Θ(n)
```

Space:

```text
Θ(n)
```

This is an important comparison:

```text
Naive Fibonacci:
Time  → exponential
Space → linear

Memoized Fibonacci:
Time  → linear
Space → linear
```

---

# 20. Tail Recursion

Example:

```c
void f(int n) {
    if(n == 0)
        return;

    printf("%d ", n);
    f(n-1);
}
```

The recursive call is the final operation.

This is called:

> Tail recursion.

Conceptually:

```text
work
 ↓
recursive call
 ↓
nothing after return
```

---

# 21. Non-Tail Recursion

Example:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
    printf("%d ", n);
}
```

There is work after the recursive call.

Therefore:

> Non-tail recursion.

---

# 22. GATE Trick — Tail vs Non-Tail

Look at what happens after the recursive call.

```c
f(n-1);
```

If nothing happens afterward:

```text
Tail recursion
```

If something happens afterward:

```text
Non-tail recursion
```

---

# 23. Recursion and Stack Space

Consider:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
}
```

Maximum active calls:

```text
n+1
```

approximately:

```text
Θ(n)
```

Therefore stack space:

```text
Θ(n)
```

---

# 24. Multiple Recursive Calls and Stack Space

Consider:

```c
void f(int n) {
    if(n <= 1)
        return;

    f(n-1);
    f(n-1);
}
```

Time:

```text
Θ(2^n)
```

But stack space is:

```text
Θ(n)
```

## Very Important GATE Trick

> Exponential number of calls does NOT necessarily mean exponential stack space.

Why?

Because recursive calls execute sequentially.

Only one branch is active at a time.

---

# 25. Time vs Space

Example:

```c
f(n-1);
f(n-1);
```

may produce:

```text
Time  = Θ(2^n)
Space = Θ(n)
```

Do not confuse:

```text
total number of calls
```

with:

```text
maximum simultaneous calls
```

---

# 26. Recursive Binary Search

Binary search can be written recursively:

```c
int binarySearch(int a[], int low, int high, int key) {
    if(low > high)
        return -1;

    int mid = (low + high) / 2;

    if(a[mid] == key)
        return mid;

    if(key < a[mid])
        return binarySearch(a, low, mid-1, key);

    return binarySearch(a, mid+1, high, key);
}
```

At every level, only one half is searched.

Recurrence:

```text
T(n) = T(n/2) + Θ(1)
```

Therefore:

```text
Time = Θ(log n)
Space = Θ(log n)
```

for recursive implementation.

---

# 27. Recursive Merge Sort

Merge sort:

```text
Divide array into two halves
        ↓
Recursively sort both halves
        ↓
Merge
```

Recurrence:

```text
T(n) = 2T(n/2) + Θ(n)
```

Using Master Theorem:

```text
a = 2
b = 2
f(n) = Θ(n)
```

Therefore:

```text
T(n) = Θ(n log n)
```

---

# 28. Recursive Quick Sort

Average case:

```text
T(n) = 2T(n/2) + Θ(n)
```

approximately:

```text
Θ(n log n)
```

Worst case:

```text
T(n) = T(n-1) + Θ(n)
```

therefore:

```text
Θ(n²)
```

Stack space:

```text
Average → Θ(log n)
Worst   → Θ(n)
```

depending on partition behavior and implementation.

---

# 29. Master Theorem

For:

```text
T(n) = aT(n/b) + f(n)
```

compare:

```text
f(n)
```

with:

```text
n^(log_b a)
```

---

## Case 1

If:

```text
f(n) = O(n^(log_b a - ε))
```

for some:

```text
ε > 0
```

then:

```text
T(n) = Θ(n^(log_b a))
```

---

## Case 2

If:

```text
f(n) = Θ(n^(log_b a) log^k n)
```

then:

```text
T(n) = Θ(n^(log_b a) log^(k+1)n)
```

---

## Case 3

If:

```text
f(n) = Ω(n^(log_b a + ε))
```

and regularity conditions hold:

```text
T(n) = Θ(f(n))
```

---

# 30. Master Theorem GATE Shortcut

For:

```text
T(n) = aT(n/b) + f(n)
```

first calculate:

```text
p = log_b(a)
```

Then compare:

```text
f(n)
```

with:

```text
n^p
```

Example:

```text
T(n) = 2T(n/2) + n
```

Calculate:

```text
log₂2 = 1
```

Therefore:

```text
n^1 = n
```

and:

```text
f(n)=n
```

They are equal.

Therefore:

```text
T(n)=Θ(n log n)
```

---

# 31. Recursion Tree — Merge Sort

For:

```text
T(n) = 2T(n/2) + n
```

tree:

```text
Level 0:             n
                   /   \
Level 1:          n/2   n/2
                 / \   / \
Level 2:       n/4 ... ... n/4
```

Cost per level:

```text
n
n
n
...
```

Number of levels:

```text
log₂ n
```

Therefore:

```text
Total = n × log n
```

Hence:

```text
Θ(n log n)
```

---

# 32. Recursion Tree — `2T(n-1)`

For:

```text
T(n)=2T(n-1)+1
```

tree:

```text
                  n
              /       \
            n-1       n-1
           /  \       /  \
        n-2  n-2   n-2  n-2
```

Number of nodes grows approximately:

```text
2^n
```

Therefore:

```text
T(n)=Θ(2^n)
```

---

# 33. Nested Recursion

Example:

```c
int f(int n) {
    if(n > 100)
        return n - 10;

    return f(f(n + 11));
}
```

This type of recursion is much harder than ordinary recursion.

## GATE Strategy

Do not immediately write a recurrence.

Instead:

1. Determine the inner call.
2. Substitute its returned value into the outer call.
3. Continue until reaching the base condition.
4. Then work backward.

Nested recursion is usually an **output tracing / mathematical reasoning** problem.

---

# 34. Mutual Recursion

Two functions can call each other.

```c
void A(int n) {
    if(n > 0)
        B(n-1);
}

void B(int n) {
    if(n > 0)
        A(n-1);
}
```

This is:

> Mutual recursion.

The function does not necessarily call itself directly.

---

# 35. Indirect Recursion

```text
A()
 ↓
B()
 ↓
C()
 ↓
A()
```

This is indirect recursion.

GATE may give a program where recursion is hidden across multiple functions.

## Trick

Build a call graph:

```text
A → B
B → C
C → A
```

Then identify the cycle.

---

# 36. Recursion with Static Variable

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

For:

```text
f(3)
```

output:

```text
1 2 3
```

Because the static variable is shared between calls.

---

# 37. Recursion with Local Variable

Consider:

```c
void f(int n) {
    int x = 0;

    if(n == 0)
        return;

    x++;
    printf("%d ", x);
    f(n-1);
}
```

Output for:

```text
f(3)
```

is:

```text
1 1 1
```

because every recursive call gets a new local `x`.

## Very Important

```text
local variable:
each stack frame → separate copy

static variable:
all calls → same object
```

---

# 38. Recursion and Global Variable

If a global variable is modified inside recursion:

```c
int x = 0;

void f(int n) {
    if(n == 0)
        return;

    x++;
    f(n-1);
}
```

all recursive calls access the same global variable.

After:

```text
f(5)
```

we get:

```text
x = 5
```

---

# 39. Recursive Array Traversal

Example:

```c
void print(int a[], int n) {
    if(n == 0)
        return;

    printf("%d ", a[0]);
    print(a+1, n-1);
}
```

Suppose:

```text
a = {10,20,30,40}
```

Then:

```text
First call:
a → 10

Second:
a+1 → 20

Third:
a+2 → 30

Fourth:
a+3 → 40
```

Output:

```text
10 20 30 40
```

## GATE Trick

```c
a+1
```

moves the pointer by one array element.

---

# 40. Recursive Array Traversal from Right to Left

Example:

```c
void print(int a[], int n) {
    if(n == 0)
        return;

    print(a+1, n-1);
    printf("%d ", a[0]);
}
```

For:

```text
{10,20,30,40}
```

output:

```text
40 30 20 10
```

This combines:

```text
array pointer
+
recursion
+
return phase
```

---

# 41. Recursive Sum

```c
int sum(int a[], int n) {
    if(n == 0)
        return 0;

    return a[0] + sum(a+1, n-1);
}
```

For:

```text
a = {10,20,30}
```

then:

```text
sum(3)
= 10 + sum(2)
= 10 + 20 + sum(1)
= 10 + 20 + 30 + sum(0)
= 60
```

Time:

```text
Θ(n)
```

Space:

```text
Θ(n)
```

---

# 42. Recursive Maximum

```c
int max(int a[], int n) {
    if(n == 1)
        return a[0];

    int m = max(a+1, n-1);

    return a[0] > m ? a[0] : m;
}
```

This reduces the problem:

```text
maximum of n elements
```

to:

```text
maximum of n-1 elements
```

Time:

```text
Θ(n)
```

---

# 43. Recursive GCD

Euclidean algorithm:

```c
int gcd(int a, int b) {
    if(b == 0)
        return a;

    return gcd(b, a % b);
}
```

Example:

```text
gcd(48,18)

→ gcd(18,12)
→ gcd(12,6)
→ gcd(6,0)
→ 6
```

Time complexity:

```text
O(log(min(a,b)))
```

---

# 44. Recursive Power

Naive:

```c
int power(int x, int n) {
    if(n == 0)
        return 1;

    return x * power(x, n-1);
}
```

Time:

```text
Θ(n)
```

---

# 45. Fast Power

Instead of:

```text
x^n = x × x × ... × x
```

use:

```text
x^n
```

as:

```text
if n is even:
    x^n = (x^(n/2))²

if n is odd:
    x^n = x × x^(n-1)
```

This gives:

```text
T(n) = T(n/2) + Θ(1)
```

Therefore:

```text
Θ(log n)
```

## GATE Comparison

```text
Naive power:
Θ(n)

Fast exponentiation:
Θ(log n)
```

---

# 46. Recursive Binary Search — PYQ Pattern

A common GATE question gives:

```c
binarySearch(a, low, high, key)
```

and asks complexity.

At every call:

```text
n → n/2
```

Only one recursive branch executes.

Therefore:

```text
T(n) = T(n/2) + Θ(1)
```

Answer:

```text
Θ(log n)
```

### Common Mistake

Do NOT write:

```text
2T(n/2)
```

because binary search only follows **one** branch.

---

# 47. Recursive Merge Sort — PYQ Pattern

Typical code:

```c
mergeSort(a, low, mid);
mergeSort(a, mid+1, high);
merge(a, low, mid, high);
```

Two recursive calls:

```text
2T(n/2)
```

Merge cost:

```text
Θ(n)
```

Therefore:

```text
T(n)=2T(n/2)+Θ(n)
```

Answer:

```text
Θ(n log n)
```

---

# 48. Fibonacci — PYQ Pattern

Typical question:

```c
fib(n) {
    if(n <= 1)
        return n;

    return fib(n-1)+fib(n-2);
}
```

Two calls with different sizes.

Approximate recursion tree:

```text
                    fib(n)
                  /        \
             fib(n-1)    fib(n-2)
              /   \        /   \
             ...  ...     ...  ...
```

The number of calls grows exponentially.

Answer:

```text
Exponential time
```

More precisely:

```text
Θ(φ^n)
```

for the standard naive implementation.

---

# 49. PYQ Pattern — Number of Leaves

Consider:

```c
void f(int n) {
    if(n == 0)
        return;

    f(n-1);
    f(n-1);
}
```

Each non-base node has two children.

For depth `n`:

```text
Number of leaves = 2^n
```

Total nodes:

```text
2^(n+1)-1
```

Therefore:

```text
Time = Θ(2^n)
```

---

# 50. PYQ Pattern — Output Order

Consider:

```c
void f(int n) {
    if(n == 0)
        return;

    printf("%d ", n);
    f(n-1);
    printf("%d ", n);
}
```

For:

```text
f(2)
```

Trace:

```text
f(2)
 print 2
    f(1)
    print 1
        f(0)
    print 1
 print 2
```

Output:

```text
2 1 1 2
```

### GATE Trick

Write the call tree first.

Then mark:

```text
↓ before recursive call
↑ after recursive call
```

---

# 51. PYQ Pattern — Recurrence Identification

Suppose code contains:

```c
f(n/2);
f(n/2);
```

and a loop:

```c
for(i=0;i<n;i++)
```

Then:

```text
Two recursive calls → 2T(n/2)

Loop → Θ(n)
```

Therefore:

```text
T(n)=2T(n/2)+Θ(n)
```

Answer:

```text
Θ(n log n)
```

---

# 52. PYQ Pattern — One Recursive Call + Loop

Suppose:

```c
for(i=0;i<n;i++)
    work();

f(n/2);
```

Then:

```text
T(n)=T(n/2)+Θ(n)
```

Therefore:

```text
Θ(n)
```

### Common GATE Mistake

Some students answer:

```text
Θ(n log n)
```

because recursion exists.

Wrong.

The work at each level is:

```text
n + n/2 + n/4 + ...
```

which is:

```text
Θ(n)
```

---

# 53. PYQ Pattern — One Recursive Call + Constant Work

```c
f(n/2);
```

with no significant loop.

Then:

```text
T(n)=T(n/2)+Θ(1)
```

Answer:

```text
Θ(log n)
```

---

# 54. PYQ Pattern — Recursive Call with `n-1`

```c
f(n-1);
```

with constant work.

Then:

```text
T(n)=T(n-1)+Θ(1)
```

Answer:

```text
Θ(n)
```

---

# 55. PYQ Pattern — Recursive Call with `n-1` + Loop

```c
for(i=0;i<n;i++)
    work();

f(n-1);
```

Then:

```text
T(n)=T(n-1)+Θ(n)
```

Answer:

```text
Θ(n²)
```

---

# 56. PYQ Pattern — Two Calls with `n-1`

```c
f(n-1);
f(n-1);
```

Then:

```text
T(n)=2T(n-1)+Θ(1)
```

Answer:

```text
Θ(2^n)
```

---

# 57. Recursion Complexity Cheat Table

```text
f(n-1)
    → Θ(n)

f(n/2)
    → Θ(log n)

2f(n-1)
    → Θ(2^n)

2f(n/2)
    → Θ(n)

2f(n/2) + n
    → Θ(n log n)

f(n-1) + n
    → Θ(n²)

f(n/2) + n
    → Θ(n)

4f(n/2) + n
    → Θ(n²)
```

---

# 58. Recursion: Number of Levels

## `n-1`

```text
n
n-1
n-2
...
1
0
```

Levels:

```text
Θ(n)
```

---

## `n/2`

```text
n
n/2
n/4
n/8
...
1
```

Levels:

```text
Θ(log n)
```

---

# 59. Recursion Tree Level Trick

For:

```text
T(n)=2T(n/2)+n
```

At every level:

```text
total work = n
```

Number of levels:

```text
log n
```

Therefore:

```text
n × log n
= Θ(n log n)
```

For:

```text
T(n)=4T(n/2)+n
```

Level costs:

```text
Level 0 → n
Level 1 → 2n
Level 2 → 4n
Level 3 → 8n
...
```

Last level dominates:

```text
Θ(n²)
```

---

# 60. GATE Master Theorem Quick Revision

For:

```text
T(n)=aT(n/b)+f(n)
```

calculate:

```text
n^(log_b a)
```

### Example 1

```text
T(n)=2T(n/2)+1
```

```text
n^(log₂2)
= n
```

`f(n)=1` is smaller.

Therefore:

```text
Θ(n)
```

---

### Example 2

```text
T(n)=2T(n/2)+n
```

Equal:

```text
Θ(n log n)
```

---

### Example 3

```text
T(n)=2T(n/2)+n²
```

`n²` dominates `n`.

Therefore:

```text
Θ(n²)
```

---

### Example 4

```text
T(n)=4T(n/2)+n
```

```text
n^(log₂4)
= n²
```

`n` is smaller.

Therefore:

```text
Θ(n²)
```

---

# 61. Recursion vs Iteration

Recursive solution:

```c
int sum(int n) {
    if(n == 0)
        return 0;

    return n + sum(n-1);
}
```

Iterative solution:

```c
int sum(int n) {
    int s = 0;

    for(int i=1;i<=n;i++)
        s += i;

    return s;
}
```

Both:

```text
Time = Θ(n)
```

But recursion generally requires:

```text
Stack = Θ(n)
```

while the iterative version can use:

```text
Extra space = Θ(1)
```

---

# 62. Recursion Conversion Trick

For simple recursion:

```c
f(n) {
    if(base)
        return;

    operation;
    f(n-1);
}
```

can usually be converted to:

```c
while(!base) {
    operation;
    n--;
}
```

But non-tail recursion may require an explicit stack.

Example:

```c
f(n-1);
printf(n);
```

cannot always be converted to a simple loop without preserving the pending values.

---

# 63. Recursion and Stack Overflow

If recursion depth becomes too large:

```text
stack memory
    ↓
exhausted
    ↓
stack overflow
```

For:

```c
f(n-1)
```

depth is:

```text
Θ(n)
```

For:

```c
f(n/2)
```

depth is:

```text
Θ(log n)
```

---

# 64. GATE Mistakes to Avoid

## Mistake 1

Seeing recursion and immediately answering:

```text
O(n)
```

Wrong.

You must determine:

```text
number of calls
+
work per call
```

---

## Mistake 2

Assuming two recursive calls always mean:

```text
O(2^n)
```

Wrong.

For:

```text
2T(n/2)
```

the answer is:

```text
Θ(n)
```

---

## Mistake 3

Confusing stack depth with total calls.

Example:

```text
2T(n-1)
```

can have:

```text
Time  = Θ(2^n)
Space = Θ(n)
```

---

## Mistake 4

Ignoring work outside recursion.

Example:

```text
T(n)=2T(n/2)+n
```

is not merely:

```text
Θ(n)
```

It is:

```text
Θ(n log n)
```

---

## Mistake 5

Forgetting return-phase execution.

Always check whether code occurs:

```text
before recursive call
```

or:

```text
after recursive call
```

---

# 65. GATE Output-Tracing Method

For recursive output questions:

### Step 1

Write the first call.

```text
f(3)
```

### Step 2

Expand all calls.

```text
f(3)
 └── f(2)
      └── f(1)
           └── f(0)
```

### Step 3

Mark output before recursion:

```text
↓
```

### Step 4

Mark output after recursion:

```text
↑
```

### Step 5

Read output in execution order.

---

# 66. GATE Recurrence-Solving Method

Whenever you see recursive code:

## Step 1

Count recursive calls.

```text
one call
two calls
three calls
```

## Step 2

Determine input size.

```text
n-1
n/2
n/3
...
```

## Step 3

Find non-recursive work.

```text
Θ(1)
Θ(n)
Θ(n²)
```

## Step 4

Write recurrence.

Example:

```text
2T(n/2)+n
```

## Step 5

Solve using:

```text
Master Theorem
Recursion Tree
Substitution
```

---

# 67. Most Important Recursion Formulas

```text
1 + 2 + 3 + ... + n
= n(n+1)/2
= Θ(n²)
```

```text
1 + 2 + 4 + ... + 2^n
= Θ(2^n)
```

```text
1 + 1/2 + 1/4 + 1/8 + ...
= Θ(1)
```

```text
n + n/2 + n/4 + ...
= Θ(n)
```

```text
log₂ n
= number of times n can be divided by 2 before reaching 1
```

---

# 68. Ultra-Important GATE Tricks

```text
f(n-1)
→ linear depth
→ Θ(n)
```

```text
f(n/2)
→ logarithmic depth
→ Θ(log n)
```

```text
2f(n-1)
→ exponential calls
→ Θ(2^n)
```

```text
2f(n/2)
→ linear total work
→ Θ(n)
```

```text
2f(n/2)+n
→ Θ(n log n)
```

```text
f(n-1)+n
→ Θ(n²)
```

```text
f(n/2)+n
→ Θ(n)
```

---

# 69. Final One-Page Revision

```text
RECURSION

Every recursion:
    Base case
    Recursive case

Before recursive call:
    output during CALL phase

After recursive call:
    output during RETURN phase

f(n-1)
    → Θ(n)

f(n/2)
    → Θ(log n)

2f(n-1)
    → Θ(2^n)

2f(n/2)
    → Θ(n)

2f(n/2)+n
    → Θ(n log n)

f(n-1)+n
    → Θ(n²)

f(n/2)+n
    → Θ(n)

Naive Fibonacci
    → exponential

Memoized Fibonacci
    → Θ(n)

Binary Search
    → Θ(log n)

Merge Sort
    → Θ(n log n)

Quick Sort
    Average → Θ(n log n)
    Worst   → Θ(n²)

Recursion depth:
    n-1 → Θ(n)
    n/2 → Θ(log n)

Multiple recursive calls:
    Time can be huge
    Stack may still be small
```

---

# 70. Final GATE Checklist

Before considering Recursion complete:

* [ ] Identify base case
* [ ] Identify recursive case
* [ ] Trace recursive calls
* [ ] Trace return phase
* [ ] Draw recursion tree
* [ ] Count number of calls
* [ ] Calculate recursion depth
* [ ] Distinguish time and space complexity
* [ ] Solve `T(n)=T(n-1)+1`
* [ ] Solve `T(n)=T(n-1)+n`
* [ ] Solve `T(n)=T(n/2)+1`
* [ ] Solve `T(n)=T(n/2)+n`
* [ ] Solve `T(n)=2T(n/2)+n`
* [ ] Solve `T(n)=2T(n-1)+1`
* [ ] Apply Master Theorem
* [ ] Trace recursion output
* [ ] Understand tail recursion
* [ ] Understand nested recursion
* [ ] Understand mutual recursion
* [ ] Understand recursive array traversal
* [ ] Analyze Fibonacci
* [ ] Analyze Binary Search
* [ ] Analyze Merge Sort
* [ ] Analyze Quick Sort
* [ ] Convert simple recursion to iteration

---

# 71. PYQ Revision Order

For GATE, practice recursion questions in this order:

```text
1. Simple output recursion
        ↓
2. Before/after recursive call
        ↓
3. Recursive array traversal
        ↓
4. Number of recursive calls
        ↓
5. Recurrence relation
        ↓
6. Recursion tree
        ↓
7. Master Theorem
        ↓
8. Binary Search
        ↓
9. Merge Sort
        ↓
10. Fibonacci
        ↓
11. Nested Recursion
        ↓
12. Mixed Recursion + Pointer/Array
```

## Final Rule

For every recursive GATE question, ask these four questions:

```text
1. How many recursive calls are made?

2. What is the size of each recursive subproblem?

3. What work happens outside recursion?

4. What happens during the return phase?
```

If you can answer these four questions, most GATE recursion questions become straightforward.

```
```
