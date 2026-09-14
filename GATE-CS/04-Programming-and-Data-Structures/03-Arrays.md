# 03 — Arrays.md

````md
# 03 — Arrays: GATE CSE Notes, Tricks & PYQ Explanations

> **Target:** GATE CSE/IT  
> **Focus:** 1-D arrays, 2-D arrays, multidimensional arrays, address calculation, array-pointer relationship, searching, sorting, complexity, and GATE PYQ patterns.

---

# 0. GATE Strategy for Arrays

Arrays are one of the most important topics in GATE because they connect directly with:

```text
Arrays
  ↓
Pointers
  ↓
Memory Addressing
  ↓
Searching
  ↓
Sorting
  ↓
Time Complexity
````

GATE commonly asks:

* Array indexing
* Address calculation
* 1-D array traversal
* 2-D array addressing
* Row-major order
* Multidimensional arrays
* Array and pointer relationship
* `sizeof`
* Character arrays
* Searching
* Sorting
* Prefix/suffix techniques
* Output tracing
* Complexity analysis

---

# 1. What is an Array?

An array is a collection of elements of the **same data type** stored in contiguous memory locations.

Example:

```c
int a[5];
```

Conceptually:

```text
a[0]   a[1]   a[2]   a[3]   a[4]
 ↓      ↓      ↓      ↓      ↓
+----+ +----+ +----+ +----+ +----+
|    | |    | |    | |    | |    |
+----+ +----+ +----+ +----+ +----+
```

The important property is:

> Array elements are stored contiguously.

---

# 2. Array Declaration

```c
int a[5];
```

means:

```text
5 elements
index 0 to 4
```

Valid:

```c
a[0]
a[1]
a[2]
a[3]
a[4]
```

Invalid:

```c
a[5]
```

because valid indices are:

```text
0 ≤ index < 5
```

---

# 3. Array Initialization

```c
int a[5] = {10,20,30,40,50};
```

Memory:

```text
Index:   0   1   2   3   4
Value:  10  20  30  40  50
```

---

## Partial Initialization

```c
int a[5] = {10,20};
```

Remaining elements are initialized to zero:

```text
10 20 0 0 0
```

---

## Complete Initialization

```c
int a[] = {10,20,30};
```

Compiler determines the size:

```text
size = 3
```

---

# 4. Array Indexing

C uses zero-based indexing.

For:

```c
int a[5];
```

the first element is:

```c
a[0]
```

and the last is:

```c
a[4]
```

## GATE Trick

For an array of size `n`:

```text
first index = 0
last index  = n-1
```

---

# 5. Array and Pointer Relationship

For:

```c
int a[5];
```

in most expressions:

```c
a
```

behaves like:

```c
&a[0]
```

Therefore:

```c
a + i
```

points to:

```c
a[i]
```

and:

```c
*(a+i)
```

gives:

```c
a[i]
```

---

# 6. Most Important Array Identity

Memorize:

```c
a[i] == *(a+i)
```

This is one of the most important GATE tricks.

Example:

```c
int a[] = {10,20,30};

printf("%d", *(a+1));
```

Output:

```text
20
```

---

# 7. Reverse Array Trick

Because:

```c
a[i] == *(a+i)
```

we can write:

```c
i[a]
```

instead of:

```c
a[i]
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

because:

```text
2[a]
= *(2+a)
= *(a+2)
= a[2]
= 30
```

---

# 8. Pointer Arithmetic

Suppose:

```c
int a[5];
int *p = a;
```

Then:

```text
p     → a[0]
p+1   → a[1]
p+2   → a[2]
p+3   → a[3]
```

Pointer arithmetic depends on the data type.

If:

```text
sizeof(int) = 4
```

and:

```text
a = 1000
```

then:

```text
a+1 = 1004
a+2 = 1008
a+3 = 1012
```

---

# 9. Address Calculation — 1-D Array

For:

```c
int a[10];
```

suppose:

```text
Base address = 1000
sizeof(int) = 4
```

Address of:

```c
a[i]
```

is:

```text
Base + i × element_size
```

Therefore:

```text
Address(a[i])
=
1000 + i×4
```

---

# 10. GATE Formula — 1-D Array

For zero-based indexing:

```text
Address(A[i])
=
Base(A)
+
i × w
```

where:

```text
w = size of each element
```

Example:

```text
Base = 1000
w = 4
i = 6
```

Then:

```text
Address(A[6])
=
1000 + 6×4
=
1024
```

---

# 11. General 1-D Array Address Formula

If lower bound is `L`:

```text
Address(A[i])
=
Base + (i-L)×w
```

In C, normal arrays have:

```text
L = 0
```

so:

```text
Address(A[i])
=
Base + i×w
```

---

# 12. Array Traversal

Typical traversal:

```c
for(int i=0; i<n; i++)
    printf("%d ", a[i]);
```

Time complexity:

```text
Θ(n)
```

Space:

```text
Θ(1)
```

if no additional array is used.

---

# 13. Reverse Traversal

```c
for(int i=n-1; i>=0; i--)
    printf("%d ", a[i]);
```

Time:

```text
Θ(n)
```

---

# 14. Sum of Array

```c
int sum = 0;

for(int i=0; i<n; i++)
    sum += a[i];
```

Time:

```text
Θ(n)
```

---

# 15. Finding Maximum

```c
int max = a[0];

for(int i=1; i<n; i++) {
    if(a[i] > max)
        max = a[i];
}
```

Time:

```text
Θ(n)
```

Extra space:

```text
Θ(1)
```

---

# 16. Finding Minimum

```c
int min = a[0];

for(int i=1; i<n; i++) {
    if(a[i] < min)
        min = a[i];
}
```

Time:

```text
Θ(n)
```

---

# 17. Linear Search

To search for an element:

```c
int linearSearch(int a[], int n, int key) {
    for(int i=0; i<n; i++) {
        if(a[i] == key)
            return i;
    }

    return -1;
}
```

## Complexity

Best case:

```text
Θ(1)
```

Worst case:

```text
Θ(n)
```

Average case:

```text
Θ(n)
```

---

# 18. Binary Search

Binary search requires:

> **Sorted array**

Example:

```text
10 20 30 40 50 60 70
```

Check middle:

```text
40
```

If key is smaller:

```text
search left half
```

If key is larger:

```text
search right half
```

Each step reduces the search space approximately by half.

Recurrence:

```text
T(n) = T(n/2) + Θ(1)
```

Therefore:

```text
Θ(log n)
```

---

# 19. Linear Search vs Binary Search

| Feature         | Linear Search | Binary Search           |
| --------------- | ------------- | ----------------------- |
| Sorted required | No            | Yes                     |
| Best            | Θ(1)          | Θ(1)                    |
| Worst           | Θ(n)          | Θ(log n)                |
| Method          | Sequential    | Divide by 2             |
| Data structure  | Array/list    | Random-access structure |

## GATE Trick

If the array is **not sorted**, ordinary binary search cannot be directly applied.

---

# 20. Array Insertion

Suppose:

```text
10 20 30 40
```

Insert:

```text
25
```

at index `2`.

Elements must shift right:

```text
10 20 30 40
      ↓
10 20 25 30 40
```

Worst-case time:

```text
Θ(n)
```

because many elements may need to move.

---

# 21. Array Deletion

Suppose:

```text
10 20 30 40 50
```

delete:

```text
30
```

Elements after it shift left:

```text
10 20 40 50
```

Worst-case:

```text
Θ(n)
```

---

# 22. Access Complexity

Because array elements are contiguous and indexed:

```c
a[i]
```

can be accessed directly.

Time:

```text
Θ(1)
```

## Important

Array:

```text
Access → Θ(1)
```

Linked list:

```text
Access → Θ(n)
```

This distinction is frequently tested by GATE.

---

# 23. 2-D Arrays

Consider:

```c
int a[3][4];
```

Meaning:

```text
3 rows
4 columns
```

Total elements:

```text
3 × 4 = 12
```

Indices:

```text
row    → 0,1,2
column → 0,1,2,3
```

---

# 24. Row-Major Order

C stores multidimensional arrays in:

> **Row-major order**

Example:

```c
int a[2][3] = {
    {1,2,3},
    {4,5,6}
};
```

Memory:

```text
1 2 3 4 5 6
```

The first row is stored completely before the second row.

---

# 25. 2-D Address Formula

For:

```c
int A[R][C];
```

with zero-based indexing:

```text
Address(A[i][j])
=
Base
+
(i × C + j) × w
```

where:

```text
C = number of columns
w = size of each element
```

---

# 26. Example — 2-D Address Calculation

Suppose:

```text
A[3][4]
Base = 1000
sizeof(int) = 4
```

Find address of:

```text
A[2][1]
```

Formula:

```text
Address
=
1000 + (2×4 + 1)×4
```

Therefore:

```text
=
1000 + 9×4
=
1036
```

Answer:

```text
1036
```

---

# 27. GATE Trick — Number of Columns Matters

For:

```c
int A[5][10];
```

address of:

```c
A[i][j]
```

uses:

```text
10
```

not:

```text
5
```

Formula:

```text
Base + (i×10+j)×w
```

## Golden Rule

For row-major arrays:

> **Multiply row index by number of columns.**

---

# 28. 3-D Arrays

Consider:

```c
int A[X][Y][Z];
```

The element:

```c
A[i][j][k]
```

has offset:

```text
(i × Y × Z)
+
(j × Z)
+
k
```

Therefore:

```text
Address
=
Base
+
(iYZ + jZ + k) × w
```

---

# 29. Example — 3-D Array

Suppose:

```text
A[2][3][4]
```

Find offset of:

```text
A[1][2][3]
```

Formula:

```text
1×3×4 + 2×4 + 3
```

```text
= 12 + 8 + 3
= 23
```

Therefore the element is:

```text
23 elements
```

after the base element.

If:

```text
w = 4
```

byte offset:

```text
23×4 = 92 bytes
```

---

# 30. General Multidimensional Array Formula

For:

```text
A[d1][d2]...[dk]
```

in row-major order, the rightmost dimension changes fastest.

For:

```text
A[i][j][k]
```

the offset is:

```text
i × d2 × d3
+
j × d3
+
k
```

## GATE Trick

Read dimensions from **right to left** when calculating multipliers.

---

# 31. Row-Major vs Column-Major

## Row-major

Rows are stored consecutively.

Used by:

```text
C
C++
Java arrays of arrays
```

## Column-major

Columns are stored consecutively.

Commonly associated with:

```text
Fortran
MATLAB
```

## GATE Warning

Do not confuse:

```text
row-major
```

with:

```text
row-wise traversal
```

The memory layout is what matters.

---

# 32. 2-D Array and Pointer

For:

```c
int a[3][4];
```

`a` behaves like a pointer to:

```text
array of 4 integers
```

Therefore:

```text
a + 1
```

moves to the next row.

That means it moves by:

```text
4 integers
```

not by one integer.

---

# 33. Important 2-D Identity

```c
a[i][j]
```

is equivalent to:

```c
*(*(a+i)+j)
```

Example:

```c
int a[2][3] = {
    {10,20,30},
    {40,50,60}
};
```

Then:

```c
*(*(a+1)+2)
```

means:

```text
row 1
column 2
```

which is:

```text
60
```

---

# 34. Pointer to Array

Consider:

```c
int (*p)[4];
```

This means:

> `p` is a pointer to an array of 4 integers.

If:

```c
int a[3][4];
p = a;
```

then:

```text
p     → row 0
p+1   → row 1
p+2   → row 2
```

---

# 35. Array of Pointers

Consider:

```c
int *p[4];
```

This means:

> `p` is an array containing 4 pointers to integers.

Compare:

```text
int (*p)[4]
```

vs

```text
int *p[4]
```

| Declaration   | Meaning                    |
| ------------- | -------------------------- |
| `int (*p)[4]` | Pointer to array of 4 ints |
| `int *p[4]`   | Array of 4 int pointers    |

## GATE Trick

Parentheses change everything.

---

# 36. `sizeof` Array

Suppose:

```c
int a[10];
```

and:

```text
sizeof(int) = 4
```

Then:

```c
sizeof(a)
```

is:

```text
40 bytes
```

Number of elements:

```c
sizeof(a) / sizeof(a[0])
```

gives:

```text
10
```

---

# 37. `sizeof` in Function

Consider:

```c
void f(int a[]) {
    printf("%zu", sizeof(a));
}
```

Inside the function parameter:

```text
a
```

behaves as a pointer.

Therefore:

```c
sizeof(a)
```

is the size of the pointer.

It is **not** the size of the original array.

## GATE Trick

At function boundaries:

```text
array parameter → pointer
```

---

# 38. Passing Array to Function

Consider:

```c
void f(int a[], int n)
```

This is effectively similar to:

```c
void f(int *a, int n)
```

for parameter adjustment.

Therefore:

```c
f(a,n);
```

allows the function to modify:

```c
a[i]
```

in the caller's array.

---

# 39. Array Cannot Be Assigned

This is invalid:

```c
int a[3];
int b[3];

a = b;
```

Arrays cannot be assigned like ordinary scalar variables.

Instead, elements must be copied:

```c
for(int i=0; i<3; i++)
    a[i] = b[i];
```

---

# 40. Array Name Cannot Be Incremented

Invalid:

```c
int a[5];

a++;
```

The array name is not a modifiable pointer.

But:

```c
int *p = a;
p++;
```

is valid.

---

# 41. Character Arrays

Example:

```c
char a[] = "GATE";
```

Memory:

```text
G A T E \0
```

Number of characters:

```text
4
```

Array size:

```text
5
```

Therefore:

```c
strlen(a) = 4
sizeof(a) = 5
```

---

# 42. 2-D Character Array

Example:

```c
char names[3][10];
```

This reserves:

```text
3 × 10 = 30
```

characters.

Each row can hold at most:

```text
9 visible characters + '\0'
```

if used as a C string.

---

# 43. Jagged vs Rectangular Arrays

A true C multidimensional array:

```c
int a[3][4];
```

is rectangular:

```text
3 rows × 4 columns
```

But an array of pointers can represent rows of different sizes:

```c
int *a[3];
```

Each pointer can point to a separately allocated array.

This can create a jagged structure.

---

# 44. Prefix Sum

Prefix sum is useful for repeated range-sum queries.

Given:

```text
a = [2,4,6,8]
```

prefix:

```text
P = [2,6,12,20]
```

Definition:

```text
P[i] = a[0] + a[1] + ... + a[i]
```

Then range sum from `l` to `r`:

```text
sum(l,r)
=
P[r] - P[l-1]
```

for:

```text
l > 0
```

If:

```text
l = 0
```

then:

```text
sum(0,r) = P[r]
```

---

# 45. Prefix Sum Complexity

Building prefix array:

```text
Θ(n)
```

Each range-sum query:

```text
Θ(1)
```

Total for `q` queries:

```text
Θ(n+q)
```

instead of:

```text
Θ(nq)
```

for naive range summation.

---

# 46. Difference Array

A difference array can efficiently represent range updates.

For:

```text
a[l...r] += x
```

use:

```text
diff[l] += x
diff[r+1] -= x
```

Then recover the final array using prefix sums.

This can reduce multiple range updates from:

```text
O(nq)
```

to approximately:

```text
O(n+q)
```

depending on the exact problem.

---

# 47. Two-Pointer Technique

For sorted arrays, two pointers can solve many problems.

Example:

```text
a = [1,2,4,7,11]
```

Find whether two numbers sum to:

```text
9
```

Use:

```text
left = 0
right = n-1
```

If:

```text
a[left] + a[right] > target
```

move:

```text
right--
```

If:

```text
sum < target
```

move:

```text
left++
```

Time:

```text
Θ(n)
```

---

# 48. Kadane's Algorithm

Used to find the maximum subarray sum.

Example:

```text
[-2,1,-3,4,-1,2,1,-5,4]
```

Maximum subarray:

```text
[4,-1,2,1]
```

sum:

```text
6
```

Core idea:

```text
current = max(a[i], current + a[i])
best = max(best, current)
```

Time:

```text
Θ(n)
```

Extra space:

```text
Θ(1)
```

---

# 49. Important Array Sorting Complexities

| Algorithm      |                   Best |    Average |      Worst |  Extra Space |
| -------------- | ---------------------: | ---------: | ---------: | -----------: |
| Bubble Sort    | Θ(n) with optimization |      Θ(n²) |      Θ(n²) |         Θ(1) |
| Selection Sort |                  Θ(n²) |      Θ(n²) |      Θ(n²) |         Θ(1) |
| Insertion Sort |                   Θ(n) |      Θ(n²) |      Θ(n²) |         Θ(1) |
| Merge Sort     |             Θ(n log n) | Θ(n log n) | Θ(n log n) |         Θ(n) |
| Quick Sort     |             Θ(n log n) | Θ(n log n) |      Θ(n²) | Θ(log n) avg |
| Heap Sort      |             Θ(n log n) | Θ(n log n) | Θ(n log n) |         Θ(1) |

---

# 50. GATE Sorting Trick

Remember:

```text
Insertion Sort
    → excellent for nearly sorted data

Selection Sort
    → always Θ(n²)

Merge Sort
    → guaranteed Θ(n log n)

Quick Sort
    → average Θ(n log n)
    → worst Θ(n²)

Heap Sort
    → guaranteed Θ(n log n)
```

---

# 51. Stable Sorting

A sorting algorithm is stable if equal-key elements preserve their relative order.

Common examples:

```text
Bubble Sort → Stable
Insertion Sort → Stable
Merge Sort → Stable with standard stable implementation
```

Typically:

```text
Selection Sort → Not stable
Heap Sort → Not stable
Quick Sort → Not stable
```

unless specially modified.

---

# 52. In-Place Sorting

An algorithm is considered in-place when it uses only constant or very small extra storage beyond the input, depending on the definition.

Common GATE examples:

```text
Insertion Sort → In-place
Selection Sort → In-place
Heap Sort → In-place
```

Merge sort normally requires:

```text
Θ(n)
```

extra space for arrays.

---

# 53. PYQ Pattern 1 — Array Pointer

Consider:

```c
int a[] = {10,20,30,40,50};
int *p = a + 2;

printf("%d", *p);
```

Since:

```text
p → a[2]
```

therefore:

```text
*p = 30
```

Answer:

```text
30
```

---

# 54. PYQ Pattern 2 — Pointer Movement

```c
int a[] = {10,20,30,40};
int *p = a;

printf("%d ", *p);
p++;
printf("%d ", *p);
```

First:

```text
p → a[0]
*p = 10
```

After:

```text
p++
```

we get:

```text
p → a[1]
```

so:

```text
*p = 20
```

Output:

```text
10 20
```

---

# 55. PYQ Pattern 3 — `*p++`

```c
int a[] = {10,20,30};
int *p = a;

printf("%d ", *p++);
printf("%d", *p);
```

First expression:

```c
*p++
```

means:

```c
*(p++)
```

So:

```text
print 10
then p → a[1]
```

Second:

```text
*p = 20
```

Output:

```text
10 20
```

---

# 56. PYQ Pattern 4 — `(*p)++`

```c
int a[] = {10,20,30};
int *p = a;

printf("%d ", (*p)++);
printf("%d", *p);
```

First:

```text
(*p)++
```

uses current value:

```text
10
```

then changes:

```text
a[0] = 11
```

Therefore:

```text
10 11
```

---

# 57. PYQ Pattern 5 — `++*p`

```c
int a[] = {10,20,30};
int *p = a;

printf("%d", ++*p);
```

Equivalent to:

```c
++(*p)
```

So:

```text
a[0] = 11
```

and output:

```text
11
```

---

# 58. PYQ Pattern 6 — Pointer Difference

```c
int a[] = {10,20,30,40,50};

int *p = &a[1];
int *q = &a[4];

printf("%d", q-p);
```

Indices:

```text
p → 1
q → 4
```

Therefore:

```text
q-p = 4-1 = 3
```

Answer:

```text
3
```

---

# 59. PYQ Pattern 7 — 2-D Array

Consider:

```c
int a[2][3] = {
    {10,20,30},
    {40,50,60}
};

printf("%d", *(*(a+1)+2));
```

Step 1:

```text
a+1 → row 1
```

Step 2:

```text
*(a+1) → row 1
```

Step 3:

```text
*(a+1)+2 → column 2
```

Step 4:

```text
*(*(a+1)+2)
```

is:

```text
60
```

Answer:

```text
60
```

---

# 60. PYQ Pattern 8 — 2-D Address

Suppose:

```text
A[4][5]
Base = 1000
sizeof(int) = 4
```

Find:

```text
A[2][3]
```

Offset:

```text
2×5 + 3
= 13
```

Byte offset:

```text
13×4 = 52
```

Address:

```text
1000 + 52
= 1052
```

Answer:

```text
1052
```

---

# 61. PYQ Pattern 9 — 3-D Array

Suppose:

```text
A[2][3][4]
```

Find offset of:

```text
A[1][2][3]
```

Formula:

```text
i×Y×Z + j×Z + k
```

Therefore:

```text
1×3×4 + 2×4 + 3
= 12 + 8 + 3
= 23
```

Answer:

```text
23 elements from base
```

---

# 62. PYQ Pattern 10 — `sizeof`

Consider:

```c
int a[5];
```

If:

```text
sizeof(int) = 4
```

then:

```c
sizeof(a)
```

is:

```text
5×4
= 20 bytes
```

And:

```c
sizeof(a)/sizeof(a[0])
```

is:

```text
20/4
= 5
```

---

# 63. PYQ Pattern 11 — Partial Initialization

```c
int a[5] = {1,2};
```

Array becomes:

```text
1 2 0 0 0
```

Therefore:

```c
printf("%d", a[4]);
```

prints:

```text
0
```

---

# 64. PYQ Pattern 12 — Array Parameter

Consider:

```c
void f(int a[]) {
    a[0] = 100;
}

int main() {
    int a[] = {10,20,30};

    f(a);

    printf("%d", a[0]);
}
```

Inside function:

```text
a → original array
```

Therefore:

```text
a[0] = 100
```

Answer:

```text
100
```

---

# 65. PYQ Pattern 13 — `sizeof` Parameter

```c
void f(int a[]) {
    printf("%zu", sizeof(a));
}
```

Here:

```text
a
```

is adjusted to an `int *` parameter.

Therefore:

```text
sizeof(a)
```

is:

```text
size of pointer
```

not:

```text
size of original array
```

## GATE Trap

Never calculate function parameter `sizeof(a)` as:

```text
number of elements × element size
```

---

# 66. PYQ Pattern 14 — Nested Loop

Consider:

```c
for(int i=0; i<n; i++)
    for(int j=0; j<n; j++)
        printf("%d", a[i][j]);
```

Number of operations:

```text
n × n
```

Therefore:

```text
Θ(n²)
```

---

# 67. PYQ Pattern 15 — Triangular Loop

Consider:

```c
for(int i=0; i<n; i++)
    for(int j=0; j<=i; j++)
        printf("*");
```

Number of operations:

```text
1 + 2 + 3 + ... + n
```

Therefore:

```text
n(n+1)/2
```

and:

```text
Θ(n²)
```

---

# 68. PYQ Pattern 16 — Halving Index

Consider:

```c
for(int i=n; i>0; i=i/2)
    printf("%d", i);
```

Values approximately:

```text
n
n/2
n/4
n/8
...
1
```

Number of iterations:

```text
Θ(log n)
```

---

# 69. PYQ Pattern 17 — Doubling Index

```c
for(int i=1; i<n; i=i*2)
    printf("%d", i);
```

Values:

```text
1
2
4
8
16
...
```

Iterations:

```text
Θ(log n)
```

---

# 70. PYQ Pattern 18 — Two Independent Loops

```c
for(int i=0; i<n; i++)
    work();

for(int j=0; j<n; j++)
    work();
```

Total:

```text
n+n
= 2n
```

Therefore:

```text
Θ(n)
```

## GATE Trick

Sequential loops add:

```text
n+n = Θ(n)
```

They do not multiply.

---

# 71. PYQ Pattern 19 — Nested Dependent Loop

```c
for(int i=0; i<n; i++)
    for(int j=0; j<i; j++)
        work();
```

Operations:

```text
0 + 1 + 2 + ... + (n-1)
```

Therefore:

```text
Θ(n²)
```

---

# 72. PYQ Pattern 20 — Search Complexity

For an unsorted array:

```text
Linear Search
```

Worst case:

```text
Θ(n)
```

For sorted array:

```text
Binary Search
```

Worst case:

```text
Θ(log n)
```

## GATE Trick

The important condition is:

```text
sorted + random access
```

for ordinary binary search on an array.

---

# 73. Important Array Complexity Table

| Operation           |                 Array Complexity |
| ------------------- | -------------------------------: |
| Access `a[i]`       |                             Θ(1) |
| Update `a[i]`       |                             Θ(1) |
| Linear Search       |                             Θ(n) |
| Binary Search       |                         Θ(log n) |
| Insert at end       | Θ(1) amortized for dynamic array |
| Insert at beginning |                             Θ(n) |
| Delete at beginning |                             Θ(n) |
| Delete at middle    |                             Θ(n) |
| Traverse            |                             Θ(n) |

---

# 74. Static Array vs Dynamic Array

## Static Array

Example:

```c
int a[100];
```

Size is fixed.

## Dynamic Array

Memory can be allocated dynamically:

```c
int *a = malloc(n * sizeof(int));
```

The size can be managed dynamically.

In data structures, dynamic arrays may grow by allocating a larger block and copying elements.

---

# 75. Array Memory Trick

For an array:

```c
int a[5];
```

memory looks like:

```text
Base
 ↓
+----+----+----+----+----+
| a0 | a1 | a2 | a3 | a4 |
+----+----+----+----+----+
```

There are no gaps between elements in the array object.

Therefore:

```text
Address(a[i+1])
=
Address(a[i]) + sizeof(element)
```

---

# 76. GATE Trap — Array Bounds

For:

```c
int a[5];
```

valid:

```text
a[0] ... a[4]
```

not:

```text
a[5]
```

C does not automatically perform array bounds checking.

Accessing outside the valid object can lead to undefined behavior.

---

# 77. GATE Trap — Negative Index

This:

```c
a[-1]
```

is not automatically a valid "previous element."

It is equivalent to:

```c
*(a-1)
```

which is outside the array if `a` points to its first element.

Therefore it is generally invalid.

---

# 78. Array and Pointer Are NOT the Same

This statement is important:

> An array is not a pointer.

For many expressions, an array name converts to a pointer to its first element.

But they differ.

Example:

```c
int a[5];
int *p = a;
```

Then:

```c
sizeof(a)
```

is the complete array size.

But:

```c
sizeof(p)
```

is pointer size.

Also:

```c
a++;
```

is invalid.

But:

```c
p++;
```

is valid.

---

# 79. GATE Memory Formula Sheet

## 1-D

```text
Address(A[i])
=
Base + i×w
```

---

## 2-D Row-Major

```text
Address(A[i][j])
=
Base + (i×C+j)×w
```

---

## 3-D Row-Major

```text
Address(A[i][j][k])
=
Base + (i×Y×Z+j×Z+k)×w
```

---

## General

```text
rightmost dimension changes fastest
```

---

# 80. Most Important Array Tricks

```text
a[i] = *(a+i)
```

```text
i[a] = a[i]
```

```text
a = &a[0]   // in expressions, array-to-pointer conversion
```

```text
p+i → i elements ahead
```

```text
q-p → number of elements
```

```text
a[i][j] = *(*(a+i)+j)
```

```text
sizeof(array)
    → complete array size
```

```text
sizeof(array parameter)
    → pointer size
```

```text
C multidimensional arrays
    → row-major
```

---

# 81. Common GATE Mistakes

## Mistake 1

Thinking:

```text
a+1
```

always means one byte.

Wrong.

It means one element forward.

---

## Mistake 2

Using number of rows in the 2-D address formula.

Wrong.

Use:

```text
number of columns
```

---

## Mistake 3

Thinking:

```text
q-p
```

gives bytes.

Wrong.

It gives element difference when valid.

---

## Mistake 4

Thinking array and pointer are identical.

Wrong.

They are related but different.

---

## Mistake 5

Forgetting `'\0'` in strings.

---

## Mistake 6

Using binary search on an unsorted array.

---

## Mistake 7

Multiplying sequential loops.

Example:

```text
for n
for n
```

sequentially:

```text
n+n = Θ(n)
```

not:

```text
n²
```

---

# 82. GATE Array Question-Solving Workflow

For an array question:

### Step 1

Write:

```text
number of elements
```

### Step 2

Write:

```text
valid indices
```

### Step 3

If pointers appear:

```text
draw pointer → array element
```

### Step 4

Convert:

```c
*(a+i)
```

into:

```text
a[i]
```

### Step 5

For 2-D arrays:

```text
offset = row × columns + column
```

### Step 6

For complexity:

```text
count iterations
```

### Step 7

Check:

```text
array bounds
```

before calculating output.

---

# 83. Rapid Revision

```text
ARRAY

Contiguous memory

a[n]
    valid indices = 0 ... n-1

a[i]
    = *(a+i)

i[a]
    = a[i]

1-D address:
    Base + i×w

2-D row-major:
    Base + (i×columns+j)×w

3-D:
    Base + (i×Y×Z+j×Z+k)×w

C stores multidimensional arrays:
    Row-major

a[i]
    → Θ(1)

Linear Search:
    Θ(n)

Binary Search:
    Θ(log n)

Array insertion:
    Θ(n) worst case

Array deletion:
    Θ(n) worst case

Traversal:
    Θ(n)

sizeof(array):
    complete array size

sizeof(array parameter):
    pointer size

a++
    invalid

p++
    valid if p is a pointer

q-p
    element difference
```

---

# 84. Final GATE Checklist

Before considering Arrays complete:

* [ ] Array declaration
* [ ] Array initialization
* [ ] Zero-based indexing
* [ ] Contiguous memory
* [ ] Array-pointer relationship
* [ ] `a[i] == *(a+i)`
* [ ] `i[a] == a[i]`
* [ ] Pointer arithmetic
* [ ] Pointer difference
* [ ] 1-D address calculation
* [ ] 2-D address calculation
* [ ] Row-major order
* [ ] 3-D address calculation
* [ ] Multidimensional arrays
* [ ] Pointer to array
* [ ] Array of pointers
* [ ] `sizeof(array)`
* [ ] `sizeof(array parameter)`
* [ ] Character arrays
* [ ] String and `'\0'`
* [ ] Linear search
* [ ] Binary search
* [ ] Array insertion
* [ ] Array deletion
* [ ] Prefix sums
* [ ] Difference arrays
* [ ] Two-pointer technique
* [ ] Kadane's algorithm
* [ ] Sorting complexities
* [ ] Stable vs unstable sorting
* [ ] In-place sorting
* [ ] Array bounds
* [ ] Output tracing

---

# 85. PYQ Practice Order

For GATE Arrays, solve questions in this order:

```text
1. Basic indexing
       ↓
2. Array + pointer
       ↓
3. Pointer arithmetic
       ↓
4. sizeof
       ↓
5. Character arrays
       ↓
6. 2-D arrays
       ↓
7. Address calculation
       ↓
8. 3-D arrays
       ↓
9. Searching
       ↓
10. Sorting
       ↓
11. Prefix/suffix
       ↓
12. Complexity
       ↓
13. Mixed output questions
```

---

# 86. Final GATE Rule

Whenever you see an array question, immediately ask:

```text
1. What is the size of the array?

2. What are the valid indices?

3. What is the base address?

4. What is sizeof(element)?

5. Is a pointer involved?

6. Is the array 1-D or multidimensional?

7. If multidimensional, what is the number of columns?

8. Is the array sorted?

9. How many times does each loop execute?

10. Is any expression accessing outside the array?
```

If you answer these questions systematically, most GATE array questions become much easier.

```
```
