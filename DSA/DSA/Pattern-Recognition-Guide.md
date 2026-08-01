# 🎯 DSA Pattern Recognition Guide

> "The hardest part of DSA is not coding.
> It is recognizing which pattern to use."

---

# How to Identify a Pattern

Whenever you read a problem, don't think about code first.

Ask these questions:

```
What is the input?

↓

What is the output?

↓

What are the constraints?

↓

What keywords are present?

↓

Which pattern matches?
```

---

# Decision Tree

```
Problem

↓

Array / String ?

↓

YES

↓

Is it Sorted?

↓

YES

↓

Binary Search

↓

NO

↓

Need Pair?

↓

YES

↓

HashMap

or

Two Pointers

↓

Need Contiguous?

↓

YES

↓

Sliding Window

↓

Need Range Sum?

↓

Prefix Sum

↓

Need Frequency?

↓

HashMap

↓

Need Maximum / Minimum?

↓

Greedy

or

DP
```

---

# Pattern 1

## Traversal

Keywords

- Print
- Count
- Sum
- Maximum
- Minimum

Example

```
Find Maximum

Find Average

Count Even Numbers

Linear Search
```

Complexity

```
O(n)
```

---

# Pattern 2

## Two Pointers

Keywords

- Pair
- Reverse
- Palindrome
- Sorted Array
- Remove Duplicates

Questions

```
Two Sum II

Reverse Array

Move Zeroes

Container With Most Water
```

---

# Pattern 3

## Sliding Window

Keywords

- Contiguous
- Subarray
- Substring
- Longest
- Smallest
- At Most K
- Exactly K

Questions

```
Longest Substring

Maximum Sum Subarray

Minimum Window

Maximum Average
```

---

# Pattern 4

## Prefix Sum

Keywords

- Range Sum
- Running Sum
- Continuous Sum
- Prefix
- Subarray Sum

Questions

```
Running Sum

Subarray Sum = K

Pivot Index
```

---

# Pattern 5

## Binary Search

Keywords

- Sorted
- Search
- Minimum
- Maximum
- Answer in Range

Questions

```
Search Insert

Peak Element

Rotated Array

Koko Eating Bananas
```

---

# Pattern 6

## HashMap

Keywords

- Frequency
- Count
- Pair
- Lookup
- Duplicate

Questions

```
Two Sum

Anagram

Top K Frequent

Subarray Sum
```

---

# Pattern 7

## Stack

Keywords

- Parentheses
- Next Greater
- Previous Greater
- Expression
- Undo

Questions

```
Valid Parentheses

Daily Temperatures

Largest Rectangle

Stock Span
```

---

# Pattern 8

## Queue / BFS

Keywords

- Level
- Minimum Steps
- Shortest Path
- Nearest

Questions

```
Rotten Oranges

Binary Tree Level Order

01 Matrix
```

---

# Pattern 9

## DFS

Keywords

- Connected
- Island
- Component
- Explore

Questions

```
Number of Islands

Flood Fill

Clone Graph
```

---

# Pattern 10

## Heap

Keywords

- Top K
- Largest
- Smallest
- Priority

Questions

```
Top K Frequent

Merge K Lists

Kth Largest
```

---

# Pattern 11

## Greedy

Keywords

- Minimum Operations
- Maximum Profit
- Earliest
- Interval

Questions

```
Jump Game

Gas Station

Assign Cookies
```

---

# Pattern 12

## Dynamic Programming

Keywords

- Choices
- Maximum
- Minimum
- Count Ways
- Optimal

Questions

```
House Robber

Coin Change

Longest Increasing Subsequence

Climbing Stairs
```

---

# Pattern 13

## Backtracking

Keywords

- Generate
- All Possible
- Permutations
- Combinations

Questions

```
Subsets

Permutations

N Queens

Word Search
```

---

# Pattern 14

## Graph

Keywords

- Network
- Cities
- Roads
- Connections

Questions

```
Course Schedule

Clone Graph

Network Delay Time
```

---

# Pattern 15

## Tree

Keywords

- Parent
- Child
- Root
- Height

Questions

```
Maximum Depth

Diameter

Lowest Common Ancestor
```

---

# Master Decision Flow

```
Read Problem

↓

Array?

↓

Need Pair?

↓

HashMap

↓

Sorted?

↓

Binary Search

↓

Contiguous?

↓

Sliding Window

↓

Range Sum?

↓

Prefix Sum

↓

Need Frequency?

↓

HashMap

↓

Need Next Greater?

↓

Stack

↓

Need Shortest Path?

↓

BFS

↓

Need Explore?

↓

DFS

↓

Need Top K?

↓

Heap

↓

Need Choices?

↓

DP

↓

Need All Answers?

↓

Backtracking
```

---

# Complexity Cheat Sheet

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
| Heap | O(n log k) |
| DP | Depends on States |

---

# Interview Questions to Ask Yourself

Before coding, ask:

1. Is the data sorted?
2. Is it asking for a pair?
3. Is it contiguous?
4. Is it a range query?
5. Do I need fast lookup?
6. Do I need the next greater/smaller element?
7. Is it asking for the shortest path?
8. Do I need to visit every node?
9. Is it asking for Top K?
10. Are there overlapping subproblems?
11. Do I need all possible answers?

The answers to these questions usually reveal the correct pattern.

---

# Pattern Recognition Checklist

✅ Sorted → Binary Search

✅ Pair / Lookup → HashMap

✅ Contiguous → Sliding Window

✅ Range Sum → Prefix Sum

✅ Frequency → HashMap

✅ Parentheses → Stack

✅ Level Order / Shortest Path → BFS

✅ Connected Components → DFS

✅ Top K → Heap

✅ Maximum / Minimum with Choices → DP

✅ Generate All Possibilities → Backtracking

---

# Golden Rule

Don't memorize solutions.

Memorize **patterns**.

```
Question

↓

Pattern

↓

Template

↓

Dry Run

↓

Java Code
```

The best interviewers are not looking for memorized code—they are looking for your ability to identify the right pattern quickly.