# 02 — Sorting

# 1. THEORY

## 1.1 What is Sorting?

**Sorting** means arranging elements according to a specified order.

Example:

```text
Unsorted:
[5, 2, 8, 1, 3]

Ascending:
[1, 2, 3, 5, 8]

Descending:
[8, 5, 3, 2, 1]
```

Sorting is one of the **highest-yield GATE Algorithms topics**.

The most important algorithms are:

* Bubble Sort
* Selection Sort
* Insertion Sort
* Merge Sort
* Quick Sort
* Heap Sort
* Counting Sort
* Radix Sort
* Bucket Sort

---

# 2. STABLE vs UNSTABLE SORTING ⭐⭐⭐

A sorting algorithm is **stable** if equal-valued elements maintain their original relative order.

Suppose:

```text
A = [(50,A), (30,B), (50,C)]
```

After stable sorting:

```text
[(30,B), (50,A), (50,C)]
```

`50-A` remains before `50-C`.

### Common stable algorithms

| Algorithm      | Stable? |
| -------------- | ------- |
| Bubble Sort    | ✅       |
| Insertion Sort | ✅       |
| Merge Sort     | ✅*      |
| Selection Sort | ❌       |
| Quick Sort     | ❌       |
| Heap Sort      | ❌       |

`*` Merge sort can be implemented stably.

### GATE Trick 🧠

Remember:

> **BIM = Bubble, Insertion, Merge → Stable**

But stability can depend on the exact implementation.

---

# 3. IN-PLACE SORTING ⭐⭐⭐

An algorithm is generally called **in-place** if it requires only `O(1)` auxiliary space, ignoring the input array itself.

### Usually in-place

```text
Bubble Sort
Selection Sort
Insertion Sort
Heap Sort
Quick Sort
```

### Usually NOT in-place

```text
Merge Sort
```

because standard merge sort requires an auxiliary array.

### Important Trap

Recursive Quick Sort uses stack space:

$$
O(\log n)
$$

on average/balanced partitions and

$$
O(n)
$$

in the worst case.

So when GATE asks about **auxiliary space**, implementation details matter.

---

# 4. BUBBLE SORT

Bubble Sort repeatedly compares adjacent elements and swaps them if they are in the wrong order.

Example:

```text
[5, 2, 4, 1]
```

First pass:

```text
5 2 → swap
2 5 4 → swap
2 4 5 1 → swap
```

Result:

```text
[2,4,1,5]
```

Largest element has "bubbled" to the end.

---

## Complexity

| Case    |  Time |
| ------- | ----: |
| Best    | O(n)* |
| Average | O(n²) |
| Worst   | O(n²) |
| Space   |  O(1) |

`*` Best case is `O(n)` if the implementation has a **swap flag** to detect an already sorted array.

### Properties

```text
Stable      → YES
In-place    → YES
Adaptive    → YES* 
```

---

# 5. SELECTION SORT

Selection Sort repeatedly finds the minimum element and places it at the correct position.

Example:

```text
[5, 2, 4, 1]
```

Find minimum:

```text
1
```

Swap with first:

```text
[1,2,4,5]
```

Then continue.

---

## Complexity

| Case    |  Time |
| ------- | ----: |
| Best    | O(n²) |
| Average | O(n²) |
| Worst   | O(n²) |
| Space   |  O(1) |

### Properties

```text
Stable   → Usually NO
In-place → YES
```

### Important GATE Trick ⭐

Selection Sort performs approximately:

$$
\frac{n(n-1)}{2}
$$

comparisons **regardless of whether the input is already sorted**.

Therefore:

```text
Best = Average = Worst = O(n²)
```

---

# 6. INSERTION SORT ⭐⭐⭐

Insertion Sort works similarly to arranging playing cards.

Example:

```text
[5, 2, 4, 1]
```

Take `2`:

```text
[2,5,4,1]
```

Take `4`:

```text
[2,4,5,1]
```

Take `1`:

```text
[1,2,4,5]
```

---

## Complexity

| Case    |  Time |
| ------- | ----: |
| Best    |  O(n) |
| Average | O(n²) |
| Worst   | O(n²) |
| Space   |  O(1) |

### Properties

```text
Stable      → YES
In-place    → YES
Adaptive    → YES
```

---

# 7. INSERTION SORT — GATE SPECIAL ⭐⭐⭐

If the array is **almost sorted**, insertion sort can be extremely efficient.

For example:

```text
[1,2,3,5,4,6,7]
```

Only a small number of inversions exist.

Insertion Sort's running time is:

$$
O(n + I)
$$

where `I` = number of inversions.

### Therefore:

```text
Few inversions → Fast
Many inversions → Slow
```

This is a very important GATE concept.

---

# 8. MERGE SORT ⭐⭐⭐⭐⭐

Merge Sort follows:

> **Divide → Sort → Merge**

Example:

```text
[8,3,2,9,7,1,5,4]
```

Divide:

```text
[8,3,2,9] [7,1,5,4]
```

Again:

```text
[8,3] [2,9] [7,1] [5,4]
```

Eventually:

```text
[8] [3] [2] [9] [7] [1] [5] [4]
```

Then merge sorted parts.

---

## Recurrence

$$
T(n)=2T(n/2)+O(n)
$$

Using Master Theorem:

$$
\boxed{T(n)=O(n\log n)}
$$

---

## Complexity

| Case            |       Time |
| --------------- | ---------: |
| Best            | O(n log n) |
| Average         | O(n log n) |
| Worst           | O(n log n) |
| Auxiliary Space |       O(n) |

### Properties

```text
Stable       → YES*
In-place     → Usually NO
Predictable  → YES
```

---

# 9. QUICK SORT ⭐⭐⭐⭐⭐

Quick Sort uses:

> **Choose pivot → Partition → Recursively sort**

Example:

```text
[7,2,1,6,8,5,3,4]
```

Choose pivot:

```text
4
```

Partition:

```text
[2,1,3] 4 [7,6,8,5]
```

Then recursively sort both sides.

---

# 10. Quick Sort Complexity

### Best Case

Pivot divides array approximately equally:

$$
T(n)=2T(n/2)+O(n)
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

### Average Case

$$
\boxed{O(n\log n)}
$$

### Worst Case

Pivot becomes the smallest/largest element every time:

```text
n
n-1
n-2
...
1
```

Therefore:

$$
T(n)=T(n-1)+O(n)
$$

$$
\boxed{O(n^2)}
$$

---

# 11. Quick Sort — Best vs Worst ⭐⭐⭐

### Best

```text
              pivot
             /     \
           n/2      n/2
```

Height:

$$
O(\log n)
$$

Work per level:

$$
O(n)
$$

Therefore:

$$
O(n\log n)
$$

### Worst

```text
pivot
 |
 n-1
 |
 n-2
 |
 n-3
```

Height:

$$
O(n)
$$

Work:

$$
O(n)
$$

Therefore:

$$
O(n^2)
$$

---

# 12. RANDOMIZED QUICK SORT

To reduce the probability of consistently getting bad pivots, choose the pivot randomly.

Expected complexity:

$$
\boxed{O(n\log n)}
$$

Worst case is still:

$$
\boxed{O(n^2)}
$$

### GATE Trap

Randomized Quick Sort does **not eliminate** the worst case.

It makes the worst case unlikely.

---

# 13. HEAP SORT ⭐⭐⭐⭐

Heap Sort uses a **binary heap**.

For ascending sorting:

```text
Build Max Heap
↓
Remove maximum repeatedly
↓
Place maximum at the end
```

### Complexity

| Case    |           Time |
| ------- | -------------: |
| Best    |     O(n log n) |
| Average |     O(n log n) |
| Worst   |     O(n log n) |
| Space   | O(1) auxiliary |

### Properties

```text
Stable   → NO
In-place → YES
```

---

# 14. BUILD HEAP COMPLEXITY ⭐⭐⭐⭐⭐

A common GATE question:

> What is the complexity of building a heap from `n` elements?

Answer:

$$
\boxed{O(n)}
$$

NOT:

$$
O(n\log n)
$$

when using the standard **bottom-up heap construction**.

### Why?

Most nodes are near the leaves and require very little movement.

Total work:

$$
O(n)
$$

### GATE Trap 🔥

```text
Insert n elements one-by-one → O(n log n)

Bottom-up BUILD-HEAP → O(n)
```

---

# 15. COUNTING SORT

Counting Sort is **not comparison-based**.

Suppose:

```text
[2,5,3,0,2,3,0,3]
```

Count occurrences:

```text
0 → 2
1 → 0
2 → 2
3 → 3
4 → 0
5 → 1
```

Then construct sorted output.

---

## Complexity

If:

* `n` = number of elements
* `k` = range of values

Then:

$$
\boxed{O(n+k)}
$$

Space:

$$
O(n+k)
$$

depending on the implementation.

### Important

Counting Sort is useful when:

$$
k
$$

is not excessively larger than:

$$
n
$$

---

# 16. RADIX SORT

Radix Sort sorts numbers digit by digit.

Example:

```text
329
457
657
839
436
720
355
```

Sort by:

```text
Units
↓
Tens
↓
Hundreds
```

Usually uses a **stable sorting algorithm** such as Counting Sort for each digit.

---

## Complexity

For:

* `n` numbers
* `d` digits
* base/range `k`

$$
\boxed{O(d(n+k))}
$$

---

# 17. COMPARISON-BASED SORTING LOWER BOUND ⭐⭐⭐⭐⭐

This is extremely important for GATE.

For any **comparison-based sorting algorithm**:

$$
\boxed{\Omega(n\log n)}
$$

in the worst case.

Why?

There are:

$$
n!
$$

possible permutations.

A comparison gives at most two outcomes.

Therefore a decision tree needs at least:

$$
\log_2(n!)
$$

comparisons.

Using:

$$
\log(n!)=\Theta(n\log n)
$$

we get:

$$
\boxed{\Omega(n\log n)}
$$

---

# 18. Why Counting Sort Can Beat O(n log n)

The lower bound:

$$
\Omega(n\log n)
$$

applies to **comparison-based sorting**.

Counting Sort does not compare elements.

Therefore it can achieve:

$$
O(n+k)
$$

which can be approximately:

$$
O(n)
$$

when `k = O(n)`.

### GATE Trick 🧠

> "No sorting algorithm can run faster than O(n log n)."

❌ False.

Correct:

> No **comparison-based** sorting algorithm can have worst-case complexity better than Ω(n log n).

---

# 19. SORTING ALGORITHM MASTER TABLE ⭐⭐⭐⭐⭐

| Algorithm |       Best |    Average |      Worst |      Space | Stable |
| --------- | ---------: | ---------: | ---------: | ---------: | ------ |
| Bubble    |       O(n) |      O(n²) |      O(n²) |       O(1) | ✅      |
| Selection |      O(n²) |      O(n²) |      O(n²) |       O(1) | ❌      |
| Insertion |       O(n) |      O(n²) |      O(n²) |       O(1) | ✅      |
| Merge     | O(n log n) | O(n log n) | O(n log n) |       O(n) | ✅*     |
| Quick     | O(n log n) | O(n log n) |      O(n²) | O(log n)** | ❌      |
| Heap      | O(n log n) | O(n log n) | O(n log n) |       O(1) | ❌      |
| Counting  |     O(n+k) |     O(n+k) |     O(n+k) |     O(n+k) | ✅*     |
| Radix     |  O(d(n+k)) |  O(d(n+k)) |  O(d(n+k)) |     O(n+k) | ✅*     |

`*` depends on implementation.

`**` average recursion stack; worst case can be `O(n)`.

---

# 20. GATE TRICKS 🧠🔥

## Trick 1 — Already Sorted Array

If input is:

```text
[1,2,3,4,5,6,7]
```

Think:

```text
Insertion → O(n)
Bubble with flag → O(n)
Selection → O(n²)
Merge → O(n log n)
Heap → O(n log n)
```

---

## Trick 2 — Reverse Sorted Array

For insertion sort:

```text
[5,4,3,2,1]
```

Maximum number of inversions:

$$
\frac{n(n-1)}{2}
$$

Therefore insertion sort takes:

$$
O(n^2)
$$

---

## Trick 3 — Minimum Number of Comparisons

Comparison-based sorting:

$$
\boxed{\Omega(n\log n)}
$$

---

## Trick 4 — Guaranteed O(n log n)

Among common comparison sorts:

```text
Merge Sort → O(n log n)
Heap Sort  → O(n log n)
```

in the worst case.

Quick Sort:

```text
Worst → O(n²)
```

---

## Trick 5 — Stable + In-place

A common combination:

```text
Insertion Sort
Bubble Sort
```

are both stable and in-place.

Standard Merge Sort:

```text
Stable but not in-place
```

---

## Trick 6 — Build Heap

```text
BUILD-HEAP → O(n)
HEAPSORT   → O(n log n)
```

Never confuse these.

---

# 21. PYQ-STYLE QUESTIONS

## PYQ 1 — Sorting Lower Bound

What is the minimum asymptotic number of comparisons required by any comparison-based sorting algorithm in the worst case?

### Answer

$$
\boxed{\Omega(n\log n)}
$$

### Explanation

There are `n!` possible orderings.

The decision tree must have at least `n!` leaves.

Therefore:

$$
2^h\ge n!
$$

Taking log:

$$
h\ge\log_2(n!)
$$

Using Stirling's approximation:

$$
\log(n!)=\Theta(n\log n)
$$

Therefore:

$$
\boxed{\Omega(n\log n)}
$$

---

# 22. PYQ-STYLE QUESTION 2 — Nearly Sorted Array

An array contains `n` elements and only `k` inversions, where `k << n²`.

Which sorting algorithm can exploit this property efficiently?

### Answer

$$
\boxed{\text{Insertion Sort}}
$$

Its complexity can be expressed as:

$$
\boxed{O(n+k)}
$$

where `k` is the number of inversions.

### GATE Concept

**Nearly sorted → Insertion Sort**

---

# 23. PYQ-STYLE QUESTION 3 — Build Heap

What is the complexity of constructing a binary heap from `n` arbitrary elements using bottom-up heap construction?

### Answer

$$
\boxed{O(n)}
$$

### Explanation

Although a single heapify operation can cost:

$$
O(\log n)
$$

most nodes are near the leaves and have small heights.

Total:

$$
\boxed{O(n)}
$$

---

# 24. PYQ-STYLE QUESTION 4 — Quick Sort

Quick Sort always chooses the smallest element as the pivot.

What is its worst-case complexity?

### Answer

$$
\boxed{O(n^2)}
$$

Because partitions become:

```text
0 + (n-1)
0 + (n-2)
0 + (n-3)
...
```

Recurrence:

$$
T(n)=T(n-1)+O(n)
$$

Therefore:

$$
T(n)=O(n^2)
$$

---

# 25. PYQ-STYLE QUESTION 5 — Stability

Which of the following are normally stable?

```text
A. Heap Sort
B. Quick Sort
C. Insertion Sort
D. Selection Sort
```

### Answer

$$
\boxed{C}
$$

Insertion Sort is stable when equal elements are not unnecessarily swapped.

---

# 26. PYQ-STYLE QUESTION 6 — Already Sorted

An array is already sorted. Which algorithm can sort it in `O(n)` time under its standard optimized implementation?

### Answer

```text
Insertion Sort
```

and optimized Bubble Sort can also achieve `O(n)`.

### Important

Selection Sort does **not** become `O(n)`.

It still performs:

$$
\frac{n(n-1)}2
$$

comparisons.

---

# 27. PYQ-STYLE QUESTION 7 — Non-comparison Sorting

Which sorting technique can have linear time complexity under suitable assumptions?

```text
A. Merge Sort
B. Heap Sort
C. Counting Sort
D. Quick Sort
```

### Answer

$$
\boxed{C}
$$

Counting Sort:

$$
O(n+k)
$$

If:

$$
k=O(n)
$$

then:

$$
O(n+k)=O(n)
$$

---

# 28. EXAM QUICK REVISION ⚡

```text
BUBBLE
→ Stable
→ In-place
→ Best O(n), optimized
→ Worst O(n²)
```

```text
SELECTION
→ In-place
→ Usually unstable
→ Always O(n²)
```

```text
INSERTION
→ Stable
→ In-place
→ Best O(n)
→ Excellent for nearly sorted data
```

```text
MERGE
→ Stable
→ O(n log n)
→ O(n) auxiliary space
```

```text
QUICK
→ Average O(n log n)
→ Worst O(n²)
→ Usually in-place
→ Unstable
```

```text
HEAP
→ O(n log n) worst
→ In-place
→ Unstable
→ Build Heap = O(n)
```

```text
COUNTING
→ Non-comparison
→ O(n+k)
```

```text
RADIX
→ Non-comparison
→ Stable subroutine required
→ O(d(n+k))
```

---

# 29. 🔥 GATE MOST IMPORTANT FACTS

| Question Pattern                  | Immediate Answer       |
| --------------------------------- | ---------------------- |
| Comparison sorting lower bound    | Ω(n log n)             |
| Build heap                        | O(n)                   |
| Heap sort worst case              | O(n log n)             |
| Quick sort worst case             | O(n²)                  |
| Quick sort average                | O(n log n)             |
| Merge sort worst                  | O(n log n)             |
| Nearly sorted array               | Insertion Sort         |
| Stable common sort                | Insertion/Merge/Bubble |
| Always O(n²)                      | Selection Sort         |
| Non-comparison linear possibility | Counting Sort          |
| First-choice for external sorting | Merge Sort             |
| Reverse sorted + insertion        | O(n²)                  |
| `n!` decision-tree argument       | Ω(n log n)             |

### 🧠 GATE Memory Formula

$$
\boxed{\text{Comparison Sort} \Rightarrow \Omega(n\log n)}
$$

$$
\boxed{\text{Build Heap} \Rightarrow O(n)}
$$

$$
\boxed{\text{HeapSort} \Rightarrow O(n\log n)}
$$

$$
\boxed{\text{QuickSort} \Rightarrow O(n\log n)\ average,\ O(n^2)\ worst}
$$

$$
\boxed{\text{Insertion + nearly sorted} \Rightarrow O(n+\text{inversions})}
$$

**Next: `03-Hashing.md` — GATE theory + collision techniques + load factor + probing + tricks + PYQs with explanations.**
