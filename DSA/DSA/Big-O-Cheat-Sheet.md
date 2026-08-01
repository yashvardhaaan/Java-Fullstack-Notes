# 📌 Big-O Cheat Sheet

> A one-page revision guide for coding interviews.

---

# What is Big-O?

Big-O describes how the running time or memory usage of an algorithm grows as the input size increases.

It does **not** measure actual execution time.

---

# Time Complexity Order

```
Fastest

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

Slowest
```

---

# Big-O Examples

| Complexity | Example |
|------------|---------|
| O(1) | Array Access |
| O(log n) | Binary Search |
| O(n) | Linear Search |
| O(n log n) | Merge Sort |
| O(n²) | Bubble Sort |
| O(n³) | Floyd Warshall |
| O(2ⁿ) | Backtracking |
| O(n!) | Permutations |

---

# Array Complexities

| Operation | Time |
|------------|------|
| Access | O(1) |
| Update | O(1) |
| Search | O(n) |
| Insert | O(n) |
| Delete | O(n) |

---

# String Complexities

| Operation | Time |
|------------|------|
| charAt() | O(1) |
| length() | O(1) |
| substring() | O(n) |
| Concatenation (+) | O(n) |
| StringBuilder.append() | O(1)* |

---

# ArrayList

| Operation | Time |
|------------|------|
| get() | O(1) |
| set() | O(1) |
| add() (end) | O(1)* |
| add(index) | O(n) |
| remove(end) | O(1) |
| remove(index) | O(n) |
| contains() | O(n) |

---

# LinkedList

| Operation | Time |
|------------|------|
| addFirst() | O(1) |
| addLast() | O(1) |
| removeFirst() | O(1) |
| removeLast() | O(1) |
| get(index) | O(n) |

---

# HashMap

| Operation | Average | Worst |
|------------|---------|-------|
| put() | O(1) | O(n) |
| get() | O(1) | O(n) |
| remove() | O(1) | O(n) |
| containsKey() | O(1) | O(n) |

---

# HashSet

| Operation | Average |
|------------|---------|
| add() | O(1) |
| remove() | O(1) |
| contains() | O(1) |

---

# TreeMap

| Operation | Time |
|------------|------|
| put() | O(log n) |
| get() | O(log n) |
| remove() | O(log n) |

---

# TreeSet

| Operation | Time |
|------------|------|
| add() | O(log n) |
| remove() | O(log n) |
| contains() | O(log n) |

---

# Queue

| Operation | Time |
|------------|------|
| offer() | O(1) |
| poll() | O(1) |
| peek() | O(1) |

---

# Stack

| Operation | Time |
|------------|------|
| push() | O(1) |
| pop() | O(1) |
| peek() | O(1) |

---

# Priority Queue (Heap)

| Operation | Time |
|------------|------|
| add() | O(log n) |
| poll() | O(log n) |
| peek() | O(1) |

---

# Sorting Algorithms

| Algorithm | Best | Average | Worst | Space |
|------------|------|---------|--------|-------|
| Bubble | O(n) | O(n²) | O(n²) | O(1) |
| Selection | O(n²) | O(n²) | O(n²) | O(1) |
| Insertion | O(n) | O(n²) | O(n²) | O(1) |
| Merge | O(n log n) | O(n log n) | O(n log n) | O(n) |
| Quick | O(n log n) | O(n log n) | O(n²) | O(log n) |
| Heap | O(n log n) | O(n log n) | O(n log n) | O(1) |

---

# Searching

| Algorithm | Time |
|------------|------|
| Linear Search | O(n) |
| Binary Search | O(log n) |

---

# Tree Traversal

| Traversal | Time |
|------------|------|
| Preorder | O(n) |
| Inorder | O(n) |
| Postorder | O(n) |
| Level Order | O(n) |

---

# BST Operations

| Operation | Average | Worst |
|------------|---------|-------|
| Search | O(log n) | O(n) |
| Insert | O(log n) | O(n) |
| Delete | O(log n) | O(n) |

---

# Heap

| Operation | Time |
|------------|------|
| Insert | O(log n) |
| Delete | O(log n) |
| Peek | O(1) |

---

# Graph

| Algorithm | Time |
|------------|------|
| DFS | O(V + E) |
| BFS | O(V + E) |
| Dijkstra | O((V+E) log V) |
| Topological Sort | O(V + E) |
| Union Find | O(α(n)) |

---

# Dynamic Programming

| Pattern | Time |
|----------|------|
| 1D DP | O(n) |
| 2D DP | O(n²) |
| Knapsack | O(nW) |
| LIS (Binary Search) | O(n log n) |

---

# Backtracking

| Problem | Time |
|----------|------|
| Subsets | O(2ⁿ) |
| Permutations | O(n!) |
| N Queens | Exponential |

---

# Common DSA Patterns

| Pattern | Time |
|----------|------|
| Traversal | O(n) |
| Two Pointers | O(n) |
| Sliding Window | O(n) |
| Prefix Sum | O(n) |
| Binary Search | O(log n) |
| HashMap | O(n) |
| Stack | O(n) |
| Queue | O(n) |
| DFS | O(V+E) |
| BFS | O(V+E) |

---

# Java Utility Methods

| Method | Time |
|----------|------|
| Arrays.sort(int[]) | O(n log n) |
| Arrays.binarySearch() | O(log n) |
| Collections.sort() | O(n log n) |
| Arrays.fill() | O(n) |
| Arrays.equals() | O(n) |

---

# Space Complexity Examples

| Example | Space |
|----------|--------|
| Few Variables | O(1) |
| Extra Array | O(n) |
| Matrix | O(n²) |
| Recursion Stack | O(n) |
| HashMap | O(n) |
| Queue | O(n) |

---

# Interview Complexity Targets

| Input Size | Preferred Complexity |
|-------------|----------------------|
| n ≤ 100 | O(n³) may work |
| n ≤ 1,000 | O(n²) |
| n ≤ 100,000 | O(n log n) or O(n) |
| n ≥ 1,000,000 | O(n) or O(log n) |

---

# Pattern Recognition by Complexity

```
O(1)

↓

Array Access

HashMap Lookup

Stack

Queue

------------------

O(log n)

↓

Binary Search

Balanced BST

------------------

O(n)

↓

Traversal

Sliding Window

Two Pointers

HashMap

DFS

BFS

------------------

O(n log n)

↓

Merge Sort

Quick Sort

Heap

------------------

O(n²)

↓

Nested Loops

Bubble Sort

Selection Sort

------------------

O(2ⁿ)

↓

Backtracking

Subsets

------------------

O(n!)

↓

Permutations
```

---

# Interview Questions

Q. Why is Binary Search O(log n)?

→ Because every iteration removes half of the search space.

---

Q. Why is HashMap O(1)?

→ Average-case hashing allows direct bucket lookup.

---

Q. Why is Merge Sort O(n log n)?

→ The array is divided into log n levels, and each level processes n elements.

---

Q. Why is Bubble Sort O(n²)?

→ Every element may be compared with every other element.

---

# Revision Checklist

✅ O(1) → Array Access

✅ O(log n) → Binary Search

✅ O(n) → Traversal

✅ O(n log n) → Merge Sort

✅ O(n²) → Nested Loops

✅ O(V+E) → DFS/BFS

✅ O(2ⁿ) → Backtracking

✅ O(n!) → Permutations

---

# Golden Rule

Always aim for:

```
O(n)

or

O(n log n)
```

for large inputs unless the problem constraints clearly allow a slower solution.