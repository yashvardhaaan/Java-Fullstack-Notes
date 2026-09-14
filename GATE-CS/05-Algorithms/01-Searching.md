# 01 — Searching

## 1. THEORY

### 1.1 What is Searching?

**Searching** is the process of finding a particular element/key in a collection of elements.

Common searching techniques important for **GATE CSE**:

1. Linear Search
2. Binary Search
3. Hash-based Search
4. Search in sorted arrays
5. Search in special data structures

---

# 2. Linear Search

Given an array:

```text
A = [10, 25, 7, 40, 15]
```

To find `40`, check elements one by one:

```text
10 → 25 → 7 → 40
```

### Algorithm

```text
for i = 0 to n-1
    if A[i] == key
        return i
return -1
```

### Complexity

| Case    | Time |
| ------- | ---: |
| Best    | O(1) |
| Average | O(n) |
| Worst   | O(n) |
| Space   | O(1) |

### GATE Point

If the array is **unsorted**, linear search is the basic guaranteed search technique.

---

# 3. Binary Search ⭐⭐⭐

Binary Search works only when the search space is **sorted** and we can access its middle efficiently.

Example:

```text
A = [10, 20, 30, 40, 50, 60, 70]

Search = 60
```

First middle:

```text
10 20 30 40 50 60 70
         ↑
        mid
```

Since `60 > 40`, search the right half.

```text
50 60 70
   ↑
```

Found.

---

## 3.1 Binary Search Algorithm

```text
low = 0
high = n-1

while low <= high:

    mid = low + (high-low)/2

    if A[mid] == key
        return mid

    else if key < A[mid]
        high = mid - 1

    else
        low = mid + 1

return -1
```

---

## 3.2 Complexity

Each comparison approximately halves the search space:

```text
n
n/2
n/4
n/8
...
1
```

Therefore:

$$
n/2^k = 1
$$

$$
2^k=n
$$

$$
k=\log_2 n
$$

Hence:

### Time

```text
Best Case   = O(1)
Average     = O(log n)
Worst Case  = O(log n)
```

### Space

Iterative:

```text
O(1)
```

Recursive:

```text
O(log n)
```

because of recursion stack.

---

# 4. Number of Comparisons in Binary Search ⭐⭐⭐

This is extremely important for GATE.

For `n` elements, the maximum number of comparisons is approximately:

$$
\boxed{\lfloor \log_2 n \rfloor + 1}
$$

depending on what is counted as a comparison.

### Example

For:

```text
n = 15
```

$$
\log_2 15 \approx 3.9
$$

Maximum successful comparisons:

$$
\boxed{4}
$$

because the binary-search decision tree can have:

```text
1
2
4
8
```

levels.

---

# 5. Binary Search Decision Tree

For `n` elements:

```text
             middle
           /        \
       left          right
      /   \          /   \
     ...  ...       ...  ...
```

A binary search tree of height `h` can distinguish approximately:

$$
2^h
$$

possibilities.

Therefore:

$$
h = \Theta(\log n)
$$

---

# 6. Recursive Binary Search

```text
binarySearch(A, low, high, key)

if low > high
    return -1

mid = low + (high-low)/2

if A[mid] == key
    return mid

if key < A[mid]
    return binarySearch(A, low, mid-1, key)

return binarySearch(A, mid+1, high, key)
```

### Important

Each recursive call reduces the problem size by half:

$$
T(n)=T(n/2)+O(1)
$$

Using Master Theorem:

$$
\boxed{T(n)=O(\log n)}
$$

---

# 7. Binary Search Variations ⭐⭐⭐

GATE frequently asks variations rather than simply "what is binary search?"

## 7.1 First Occurrence

Given:

```text
[2, 2, 2, 4, 4, 7, 9]
```

Find first occurrence of `4`.

Answer:

```text
index = 3
```

When `A[mid] == key`, **do not stop**.

Instead:

```text
answer = mid
high = mid - 1
```

---

## 7.2 Last Occurrence

When:

```text
A[mid] == key
```

continue toward the right:

```text
answer = mid
low = mid + 1
```

---

# 8. Lower Bound

Lower bound of `x` = first position where:

$$
A[i] \ge x
$$

Example:

```text
A = [1, 2, 4, 4, 7, 9]

x = 4
```

Lower bound:

```text
index = 2
```

because:

```text
A[2] = 4
```

is the first element `>= 4`.

---

# 9. Upper Bound

Upper bound of `x` = first position where:

$$
A[i] > x
$$

Example:

```text
A = [1, 2, 4, 4, 7, 9]

x = 4
```

Upper bound:

```text
index = 4
```

because:

```text
A[4] = 7
```

is the first element `> 4`.

---

# 10. Searching in Rotated Sorted Array ⭐⭐

Example:

```text
[40, 50, 60, 10, 20, 30]
```

This is a rotated sorted array.

A modified binary search can be used.

At every step, **at least one half is sorted**.

Example:

```text
40 50 60 | 10 20 30
```

Left half is sorted.

We determine whether the target belongs to that sorted half.

---

# 11. Searching in an Unsorted Array

If the array is:

```text
[7, 2, 9, 1, 5]
```

Binary search cannot directly be applied.

Why?

Because there is no guarantee that:

```text
A[mid] < key
```

means the key is on the right.

### Trick

**Binary Search requires a monotonic/sorted search space.**

---

# 12. Searching in Linked List

Binary search is generally **not efficient** on a linked list.

Why?

To reach the middle element, we need to traverse the list.

Finding middle:

```text
O(n)
```

Therefore repeatedly finding middle does not give normal:

```text
O(log n)
```

binary-search performance.

### GATE Trap ⭐

> "Binary search always takes O(log n)."

❌ False.

It requires efficient random access to the middle.

---

# 13. Searching Complexity Comparison

| Technique     | Requirement            | Best |  Average |    Worst |
| ------------- | ---------------------- | ---: | -------: | -------: |
| Linear Search | None                   | O(1) |     O(n) |     O(n) |
| Binary Search | Sorted + random access | O(1) | O(log n) | O(log n) |
| Hash Search   | Hash table             | O(1) |     O(1) |     O(n) |

---

# 14. GATE TRICKS 🧠

### Trick 1

```text
Sorted array → think Binary Search
```

But only if random access is available.

---

### Trick 2

```text
Unsorted array → Linear Search
```

unless additional data structures/preprocessing are allowed.

---

### Trick 3

If array size is:

```text
n = 1024
```

then:

$$
\log_2 1024 = 10
$$

So binary search needs approximately:

```text
10–11 comparisons
```

depending on the exact comparison convention.

---

### Trick 4

If:

```text
n = 1,000,000
```

then:

$$
\log_2(10^6)\approx19.93
$$

So only around:

```text
20 comparisons
```

are needed.

This is a favorite conceptual GATE idea.

---

### Trick 5 ⭐

If binary search takes `k` steps:

$$
n \le 2^k
$$

So if:

```text
k = 20
```

the searchable size is roughly:

$$
2^{20}=1,048,576
$$

---

### Trick 6

Recursive binary search:

```text
Time  = O(log n)
Space = O(log n)
```

Iterative binary search:

```text
Time  = O(log n)
Space = O(1)
```

---

# 15. PYQ-STYLE GATE QUESTIONS

## PYQ 1 — Binary Search Comparisons

Suppose a sorted array contains `1023` elements. What is the maximum number of elements that need to be examined using binary search?

### Solution

$$
1023 < 1024 = 2^{10}
$$

Therefore approximately:

$$
\log_2 1023 \approx 10
$$

Maximum successful search depth:

$$
\boxed{10}
$$

### GATE Concept

Whenever the number is close to a power of 2, immediately calculate:

```text
2^10 = 1024
2^20 ≈ 10^6
2^30 ≈ 10^9
```

---

# 16. PYQ-STYLE QUESTION 2 — Linked List

Which statement is correct?

A. Binary search on a linked list always takes O(log n).

B. Binary search cannot be implemented on a linked list.

C. Binary search does not necessarily achieve O(log n) time on a linked list.

D. Linear search on a linked list takes O(log n).

### Answer

$$
\boxed{C}
$$

### Explanation

Binary search conceptually requires repeatedly accessing the middle.

In an array:

```text
A[mid]
```

is:

$$
O(1)
$$

In a linked list, reaching the middle requires traversal.

Therefore the normal `O(log n)` binary-search complexity is not obtained.

---

# 17. PYQ-STYLE QUESTION 3 — Recurrence

Consider:

$$
T(n)=T(n/2)+1
$$

What is the complexity?

### Solution

Expand:

$$
T(n)=T(n/2)+1
$$

$$
=T(n/4)+2
$$

$$
=T(n/8)+3
$$

After `k` steps:

$$
n/2^k=1
$$

Therefore:

$$
k=\log_2 n
$$

Hence:

$$
\boxed{T(n)=O(\log n)}
$$

### GATE Connection

This recurrence represents **binary search**.

---

# 18. PYQ-STYLE QUESTION 4 — First Occurrence

Given:

```text
A = [1, 2, 2, 2, 4, 5]
```

Using modified binary search, what should be done when:

```text
A[mid] == 2
```

while searching for the **first occurrence**?

### Answer

Store the current position and search left:

```text
answer = mid
high = mid - 1
```

### Key idea

```text
First occurrence → move LEFT
Last occurrence  → move RIGHT
```

---

# 19. EXAM QUICK REVISION ⚡

```text
LINEAR SEARCH
↓
Unsorted data
↓
O(n)
```

```text
BINARY SEARCH
↓
Sorted + random access
↓
O(log n)
```

```text
RECURSIVE BINARY SEARCH
↓
Time  = O(log n)
Space = O(log n)
```

```text
ITERATIVE BINARY SEARCH
↓
Time  = O(log n)
Space = O(1)
```

```text
FIRST OCCURRENCE
↓
Move LEFT
```

```text
LAST OCCURRENCE
↓
Move RIGHT
```

```text
LOWER BOUND
↓
First A[i] >= x
```

```text
UPPER BOUND
↓
First A[i] > x
```

### 🔥 Most Important GATE Topics

1. Binary-search comparison count
2. Binary search recurrence
3. Recursive vs iterative space
4. Binary search on linked lists
5. First/last occurrence
6. Lower/upper bound
7. Sorted vs unsorted search
8. Rotated sorted array
9. Worst/average/best-case complexity
10. `log₂` estimation

---

## 20. One-Page GATE Cheat Sheet

| Concept                    | Remember                      |
| -------------------------- | ----------------------------- |
| Linear Search              | O(n)                          |
| Binary Search              | O(log n)                      |
| Binary Search prerequisite | Sorted/monotonic search space |
| Array middle access        | O(1)                          |
| Linked-list middle access  | O(n)                          |
| Iterative BS space         | O(1)                          |
| Recursive BS space         | O(log n)                      |
| First occurrence           | Go left                       |
| Last occurrence            | Go right                      |
| Lower bound                | First `>= x`                  |
| Upper bound                | First `> x`                   |
| `2^10`                     | 1024                          |
| `2^20`                     | ≈ 1 million                   |
| `2^30`                     | ≈ 1 billion                   |
| BS recurrence              | `T(n)=T(n/2)+O(1)`            |
| Recurrence result          | O(log n)                      |

**Next file:** `02-Sorting.md` — with **GATE theory + sorting comparison table + tricks + PYQs with step-by-step explanations**.
