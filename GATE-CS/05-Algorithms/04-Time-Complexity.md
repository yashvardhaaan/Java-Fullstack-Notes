# 04 — Time Complexity

# 1. THEORY

## 1.1 What is Time Complexity?

**Time complexity** describes how the running time of an algorithm grows as the input size `n` increases.

It does **not** mean the exact time in seconds.

Example:

```text id="1q4y9c"
Algorithm A → 10n operations
Algorithm B → n² operations
```

For large `n`:

$$
10n = O(n)
$$

while:

$$
n^2 = O(n^2)
$$

Therefore Algorithm A scales better.

---

# 2. INPUT SIZE `n`

`n` represents the size of the input.

Examples:

| Problem | `n`                                         |
| ------- | ------------------------------------------- |
| Array   | Number of elements                          |
| String  | Number of characters                        |
| Graph   | Usually `V` vertices and `E` edges          |
| Matrix  | Rows × columns                              |
| Number  | Number of bits/digits, depending on problem |

### GATE Trick

Always first identify:

> **What is `n`?**

Many complexity mistakes happen because the input parameter is misunderstood.

---

# 3. ASYMPTOTIC NOTATIONS ⭐⭐⭐⭐⭐

Three major notations:

```text id="1j8w4u"
O    → Upper Bound
Ω    → Lower Bound
Θ    → Tight Bound
```

---

# 4. BIG-O — `O()` ⭐⭐⭐⭐⭐

Big-O gives an **asymptotic upper bound**.

If:

$$
T(n)=3n^2+5n+10
$$

then:

$$
\boxed{T(n)=O(n^2)}
$$

because the highest-order term dominates for large `n`.

---

# 5. BIG-Ω — `Ω()`

Omega represents an asymptotic **lower bound**.

For:

$$
T(n)=3n^2+5n+10
$$

we can say:

$$
\boxed{T(n)=\Omega(n^2)}
$$

---

# 6. BIG-Θ — `Θ()` ⭐⭐⭐⭐⭐

Theta gives a **tight asymptotic bound**.

For:

$$
T(n)=3n^2+5n+10
$$

we have:

$$
\boxed{T(n)=\Theta(n^2)}
$$

Therefore:

$$
T(n)=\Theta(n^2)
$$

also implies:

$$
T(n)=O(n^2)
$$

and:

$$
T(n)=\Omega(n^2)
$$

---

# 7. IMPORTANT RELATION

If:

$$
f(n)=\Theta(g(n))
$$

then:

$$
\boxed{f(n)=O(g(n))}
$$

and:

$$
\boxed{f(n)=\Omega(g(n))}
$$

But:

$$
f(n)=O(g(n))
$$

does **not** necessarily imply:

$$
f(n)=\Theta(g(n))
$$

---

# 8. GROWTH-RATE ORDER ⭐⭐⭐⭐⭐

Memorize this order:

$$
\boxed{
1
<
\log n
<
\sqrt n
<
n
<
n\log n
<
n^2
<
n^3
<
2^n
<
n!
}
$$

From **fastest-growing efficiency** to **slowest-growing algorithm**:

```text id="d2r5c6"
O(1)
 ↓
O(log n)
 ↓
O(√n)
 ↓
O(n)
 ↓
O(n log n)
 ↓
O(n²)
 ↓
O(n³)
 ↓
O(2ⁿ)
 ↓
O(n!)
```

### GATE Trick 🔥

For large `n`:

$$
\boxed{\log n \ll n \ll n\log n \ll n^2 \ll 2^n}
$$

---

# 9. CONSTANT COMPLEXITY — O(1)

Example:

```text id="m42o8u"
x = A[5]
```

Array indexing takes constant time:

$$
\boxed{O(1)}
$$

Even if the array contains one billion elements, accessing a known index is still constant time.

---

# 10. LOGARITHMIC COMPLEXITY — O(log n)

Occurs when the problem size is repeatedly divided by a constant.

Example:

```text id="l8q42u"
n
n/2
n/4
n/8
...
1
```

Number of steps:

$$
\boxed{\log_2 n}
$$

Examples:

* Binary Search
* Balanced BST search
* Divide-by-two algorithms

---

# 11. LINEAR COMPLEXITY — O(n)

One complete traversal:

```text id="u4j4ds"
for i = 0 to n-1
    do something
```

Complexity:

$$
\boxed{O(n)}
$$

---

# 12. N LOG N — O(n log n)

Common examples:

* Merge Sort
* Heap Sort
* Average-case Quick Sort

Typical structure:

```text id="j7kz6h"
Divide → log n levels
Each level → O(n) work
```

Therefore:

$$
\boxed{O(n\log n)}
$$

---

# 13. QUADRATIC — O(n²)

Two nested loops:

```text id="q2i6sm"
for i = 1 to n
    for j = 1 to n
        operation
```

Number of operations:

$$
n\times n=n^2
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 14. THREE NESTED LOOPS

```text id="1a7v7x"
for i = 1 to n
    for j = 1 to n
        for k = 1 to n
            operation
```

Total:

$$
n^3
$$

Therefore:

$$
\boxed{O(n^3)}
$$

---

# 15. ADDITION RULE ⭐⭐⭐⭐⭐

Suppose:

```text id="j8w1hi"
Loop 1 → O(n)
Loop 2 → O(n²)
Loop 3 → O(n)
```

Total:

$$
O(n)+O(n^2)+O(n)
$$

Highest order dominates:

$$
\boxed{O(n^2)}
$$

### Trick

**Sequential blocks → ADD, then keep the largest term.**

---

# 16. MULTIPLICATION RULE ⭐⭐⭐⭐⭐

Nested loops usually multiply.

```text id="a8m3r2"
for i = 1 to n
    for j = 1 to n
```

$$
n\times n=n^2
$$

Therefore:

$$
\boxed{O(n^2)}
$$

### Memory

```text id="2xkg44"
Sequential → Add
Nested → Multiply
```

---

# 17. DIFFERENT LOOP LIMITS

Example:

```text id="4q0d6g"
for i = 1 to n
    for j = 1 to i
        operation
```

Number of operations:

$$
1+2+3+\cdots+n
$$

$$
=\frac{n(n+1)}2
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 18. TRIANGULAR LOOP ⭐⭐⭐⭐

```text id="7x8k9j"
for(i=1; i<=n; i++)
    for(j=1; j<=i; j++)
```

Do NOT say:

$$
O(n)
$$

The inner loop executes:

```text id="08h2pl"
1 + 2 + 3 + ... + n
```

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 19. LOOP THAT DOUBLES ⭐⭐⭐⭐⭐

```text id="6e6k79"
for(i=1; i<=n; i=i*2)
    operation
```

Values:

```text id="y0v2ri"
1
2
4
8
16
...
n
```

Number of iterations:

$$
\boxed{O(\log n)}
$$

---

# 20. LOOP THAT HALVES ⭐⭐⭐⭐⭐

```text id="s3f9hx"
for(i=n; i>=1; i=i/2)
    operation
```

Iterations:

$$
n,\frac n2,\frac n4,\ldots,1
$$

Therefore:

$$
\boxed{O(\log n)}
$$

---

# 21. LOGARITHMIC NESTED LOOP

Consider:

```text id="7dmbz7"
for(i=1; i<=n; i=i*2)
    for(j=1; j<=n; j=j*2)
        operation
```

Outer:

$$
O(\log n)
$$

Inner:

$$
O(\log n)
$$

Total:

$$
\boxed{O((\log n)^2)}
$$

---

# 22. LOOP WITH `i *= 2` AND `j <= i`

Consider:

```text id="l6qv03"
for(i=1; i<=n; i=i*2)
    for(j=1; j<=i; j++)
        operation
```

Work:

$$
1+2+4+8+\cdots+n
$$

This geometric series equals:

$$
O(n)
$$

Therefore:

$$
\boxed{O(n)}
$$

### GATE Trap 🔥

Do not automatically multiply:

$$
\log n\times n
$$

because the inner loop's size changes with `i`.

---

# 23. BREAK / EARLY TERMINATION ⭐⭐⭐⭐

Consider:

```text id="t8qf2r"
for(i=0; i<n; i++)
{
    if(A[i] == x)
        break;
}
```

### Best Case

Element is first:

$$
\boxed{O(1)}
$$

### Worst Case

Element is last/not present:

$$
\boxed{O(n)}
$$

### Important

If asked for **worst-case complexity**, use:

$$
\boxed{O(n)}
$$

---

# 24. CONDITIONAL BRANCHES

```text id="v8z5ji"
if(condition)
    O(n)
else
    O(n²)
```

Worst case:

$$
\boxed{O(n^2)}
$$

Because only one branch executes.

### GATE Trick

For `if-else`:

> **Take the maximum**, not the sum.

---

# 25. RECURSION ⭐⭐⭐⭐⭐

Recursive complexity is usually expressed using a recurrence.

Example:

$$
T(n)=T(n-1)+1
$$

Expand:

$$
T(n)=T(n-2)+2
$$

Eventually:

$$
T(n)=T(1)+(n-1)
$$

Therefore:

$$
\boxed{O(n)}
$$

---

# 26. BINARY SEARCH RECURRENCE

$$
T(n)=T(n/2)+O(1)
$$

Therefore:

$$
\boxed{O(\log n)}
$$

---

# 27. MERGE SORT RECURRENCE

$$
T(n)=2T(n/2)+O(n)
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

---

# 28. QUICKSORT RECURRENCES

### Balanced partition

$$
T(n)=2T(n/2)+O(n)
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

### Worst partition

$$
T(n)=T(n-1)+O(n)
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 29. MASTER THEOREM ⭐⭐⭐⭐⭐

For:

$$
T(n)=aT(n/b)+f(n)
$$

compare:

$$
f(n)
$$

with:

$$
n^{\log_ba}
$$

---

## Case 1

If:

$$
f(n)=O(n^{\log_ba-\epsilon})
$$

then:

$$
\boxed{T(n)=\Theta(n^{\log_ba})}
$$

---

## Case 2

If:

$$
f(n)=\Theta(n^{\log_ba}\log^k n)
$$

then:

$$
\boxed{T(n)=\Theta(n^{\log_ba}\log^{k+1}n)}
$$

---

## Case 3

If:

$$
f(n)=\Omega(n^{\log_ba+\epsilon})
$$

with regularity condition, then:

$$
\boxed{T(n)=\Theta(f(n))}
$$

---

# 30. MASTER THEOREM — GATE SHORTCUT ⭐⭐⭐⭐⭐

Calculate:

$$
p=\log_ba
$$

Then compare `f(n)` with:

$$
n^p
$$

### Example 1

$$
T(n)=2T(n/2)+n
$$

Here:

```text id="5u1yus"
a=2
b=2
```

Therefore:

$$
\log_2 2=1
$$

Compare:

$$
f(n)=n
$$

with:

$$
n^1=n
$$

Same order.

Therefore:

$$
\boxed{T(n)=\Theta(n\log n)}
$$

---

# 31. MASTER THEOREM EXAMPLE 2

$$
T(n)=T(n/2)+1
$$

Here:

```text id="h5h6s2"
a=1
b=2
```

$$
\log_2 1=0
$$

Therefore:

$$
n^0=1
$$

and:

$$
f(n)=1
$$

Same order.

Therefore:

$$
\boxed{T(n)=\Theta(\log n)}
$$

---

# 32. MASTER THEOREM EXAMPLE 3

$$
T(n)=4T(n/2)+n
$$

Here:

$$
a=4,\quad b=2
$$

$$
\log_2 4=2
$$

Therefore:

$$
n^{\log_ba}=n^2
$$

But:

$$
f(n)=n
$$

is smaller.

Therefore:

$$
\boxed{T(n)=\Theta(n^2)}
$$

---

# 33. MASTER THEOREM EXAMPLE 4

$$
T(n)=2T(n/2)+n^2
$$

Here:

$$
n^{\log_2 2}=n
$$

But:

$$
f(n)=n^2
$$

is polynomially larger.

Therefore:

$$
\boxed{T(n)=\Theta(n^2)}
$$

---

# 34. AMORTIZED ANALYSIS ⭐⭐⭐

Amortized analysis calculates the average cost of operations over a **sequence of operations**.

Classic example:

### Dynamic Array

Most insertions:

$$
O(1)
$$

Occasionally resizing requires:

$$
O(n)
$$

But over many insertions:

$$
\boxed{\text{Amortized insertion}=O(1)}
$$

### GATE Trap

Amortized `O(1)` does **not** mean every individual operation is `O(1)`.

---

# 35. BEST, AVERAGE AND WORST CASE ⭐⭐⭐⭐⭐

### Best Case

Minimum running time for an input of size `n`.

### Worst Case

Maximum running time.

### Average Case

Expected running time under an assumed input distribution.

Example: Linear Search

| Case    | Complexity |
| ------- | ---------: |
| Best    |       O(1) |
| Average |       O(n) |
| Worst   |       O(n) |

---

# 36. GATE TRICKS 🧠🔥

## Trick 1

Drop constants:

$$
5n\rightarrow O(n)
$$

$$
100n^2\rightarrow O(n^2)
$$

---

## Trick 2

Keep dominant term:

$$
n^3+n^2+n
$$

becomes:

$$
\boxed{O(n^3)}
$$

---

## Trick 3

Log base doesn't matter asymptotically:

$$
\log_2n=\Theta(\log_3n)
$$

because:

$$
\log_b n=\frac{\log_a n}{\log_a b}
$$

and the denominator is constant.

---

## Trick 4

Polynomial beats logarithm:

$$
n^{0.1}>\log n
$$

for sufficiently large `n`.

---

## Trick 5

Exponential beats polynomial:

$$
2^n \gg n^{100}
$$

for sufficiently large `n`.

---

## Trick 6

Factorial grows extremely fast:

$$
n! \gg 2^n
$$

for sufficiently large `n`.

---

# 37. COMMON LOOP PATTERNS ⭐⭐⭐⭐⭐

| Code Pattern           |     Complexity |
| ---------------------- | -------------: |
| `i++`                  |           O(n) |
| `i += 5`               |           O(n) |
| `i *= 2`               |       O(log n) |
| `i /= 2`               |       O(log n) |
| Nested `n × n`         |          O(n²) |
| Nested `n × log n`     |     O(n log n) |
| Three nested `n` loops |          O(n³) |
| `1+2+...+n`            |          O(n²) |
| `1+2+4+...+n`          |           O(n) |
| Binary recursion       | Often O(log n) |
| `T(n)=T(n-1)+1`        |           O(n) |
| `T(n)=2T(n/2)+n`       |     O(n log n) |

---

# 38. PYQ-STYLE QUESTION 1

Find the complexity:

```text id="9h7i5d"
for(i=1; i<=n; i++)
    for(j=1; j<=n; j++)
        count++;
```

### Solution

Outer:

$$
n
$$

Inner:

$$
n
$$

Total:

$$
n\times n=n^2
$$

### Answer

$$
\boxed{O(n^2)}
$$

---

# 39. PYQ-STYLE QUESTION 2

Find the complexity:

```text id="1cc8wm"
for(i=1; i<=n; i=i*2)
    count++;
```

### Solution

Values:

```text id="i9q3kw"
1,2,4,8,...,n
```

Let number of iterations be `k`:

$$
2^k=n
$$

Therefore:

$$
k=\log_2n
$$

### Answer

$$
\boxed{O(\log n)}
$$

---

# 40. PYQ-STYLE QUESTION 3 ⭐

Find the complexity:

```text id="3o0lzh"
for(i=1; i<=n; i=i*2)
    for(j=1; j<=i; j++)
        count++;
```

### Solution

Iterations:

```text id="2k7yr7"
i=1    → 1
i=2    → 2
i=4    → 4
i=8    → 8
...
i=n    → n
```

Total:

$$
1+2+4+8+\cdots+n
$$

Geometric series:

$$
=2n-1
$$

Therefore:

$$
\boxed{O(n)}
$$

### 🔥 GATE Trap

It is **not** `O(n log n)`.

---

# 41. PYQ-STYLE QUESTION 4

Find the complexity:

```text id="nqgqvf"
for(i=1; i<=n; i++)
    for(j=1; j<=i; j++)
        count++;
```

### Solution

Total:

$$
1+2+3+\cdots+n
$$

$$
=\frac{n(n+1)}2
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 42. PYQ-STYLE QUESTION 5 — Recurrence

Solve:

$$
T(n)=2T(n/2)+n
$$

### Solution

Here:

$$
a=2,\quad b=2
$$

$$
n^{\log_ba}=n^{\log_22}=n
$$

And:

$$
f(n)=n
$$

Same order.

Therefore Master Theorem Case 2:

$$
\boxed{T(n)=\Theta(n\log n)}
$$

---

# 43. PYQ-STYLE QUESTION 6

Solve:

$$
T(n)=3T(n/2)+n
$$

### Solution

$$
a=3,\quad b=2
$$

$$
n^{\log_23}\approx n^{1.585}
$$

Compare:

$$
n < n^{1.585}
$$

So Case 1 applies:

$$
\boxed{T(n)=\Theta(n^{\log_23})}
$$

---

# 44. PYQ-STYLE QUESTION 7

Arrange the following in increasing order:

$$
n,\quad \log n,\quad n^2,\quad 2^n,\quad n\log n
$$

### Answer

$$
\boxed{
\log n<n<n\log n<n^2<2^n
}
$$

---

# 45. PYQ-STYLE QUESTION 8 — Big-O

Which statement is true?

A.

$$
n^2=O(n)
$$

B.

$$
n=O(n^2)
$$

C.

$$
n^2=\Theta(n)
$$

D.

$$
2^n=O(n^3)
$$

### Answer

$$
\boxed{B}
$$

Because for sufficiently large `n`:

$$
n\le n^2
$$

---

# 46. PYQ-STYLE QUESTION 9 — Recursion

Consider:

```text id="k7i5k0"
f(n):
    if n <= 1:
        return
    f(n/2)
    f(n/2)
```

What is the complexity?

### Recurrence

$$
T(n)=2T(n/2)+O(1)
$$

Therefore:

$$
\boxed{O(n)}
$$

### GATE Trick

Two recursive calls do **not automatically mean** `O(2^n)`.

The argument is:

$$
n/2
$$

not:

$$
n-1
$$

---

# 47. PYQ-STYLE QUESTION 10 — Exponential Recursion

Consider:

```text id="n4q3te"
f(n):
    if n <= 1:
        return
    f(n-1)
    f(n-1)
```

Recurrence:

$$
T(n)=2T(n-1)+O(1)
$$

Therefore:

$$
\boxed{O(2^n)}
$$

### Compare

```text id="ajzvkt"
f(n/2) → often polynomial/logarithmic
f(n-1) → can become exponential
```

---

# 48. 🔥 GATE FINAL CHEAT SHEET

### Growth

$$
\boxed{
1<\log n<\sqrt n<n<n\log n<n^2<n^3<2^n<n!
}
$$

### Sequential

$$
\boxed{\text{ADD}}
$$

### Nested

$$
\boxed{\text{MULTIPLY}}
$$

### If-else

$$
\boxed{\text{MAX}}
$$

### Divide by 2

$$
\boxed{O(\log n)}
$$

### Increase by 1

$$
\boxed{O(n)}
$$

### Geometric sum

$$
1+2+4+\cdots+n=O(n)
$$

### Arithmetic sum

$$
1+2+3+\cdots+n=O(n^2)
$$

### Binary Search

$$
\boxed{T(n)=T(n/2)+1=O(\log n)}
$$

### Merge Sort

$$
\boxed{2T(n/2)+n=O(n\log n)}
$$

### Linear Recursion

$$
\boxed{T(n)=T(n-1)+1=O(n)}
$$

### Exponential Recursion

$$
\boxed{T(n)=2T(n-1)+1=O(2^n)}
$$

### Master Theorem

$$
\boxed{T(n)=aT(n/b)+f(n)}
$$

First calculate:

$$
\boxed{n^{\log_ba}}
$$

then compare with `f(n)`.

---

# 🎯 GATE PRIORITY

**Must master:**

1. Big-O, Ω, Θ
2. Growth-rate ordering
3. Loop analysis
4. Nested/triangular loops
5. Logarithmic loops
6. Recurrence solving
7. Master Theorem
8. Recursive tree analysis
9. Best/Average/Worst case
10. Amortized analysis

These concepts are used throughout **Sorting, Searching, Hashing, Greedy, DP and Graph Algorithms**, so mastering this chapter makes the remaining algorithm chapters much easier.

**Next: `05-Space-Complexity.md` — auxiliary space, input/output space, recursion stack, in-place algorithms, recursion examples, GATE tricks + PYQs.**
