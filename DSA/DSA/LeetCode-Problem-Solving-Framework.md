# 🧩 LeetCode Problem Solving Framework

> "The best programmers don't know every solution—they know how to discover the solution."

---

# The Complete Problem Solving Flow

```
Read Problem

↓

Understand Input & Output

↓

Read Constraints

↓

Identify Pattern

↓

Brute Force

↓

Optimize

↓

Write Algorithm

↓

Dry Run

↓

Write Java Code

↓

Test Edge Cases

↓

Analyze Complexity
```

---

# Step 1 - Read the Problem

Don't touch the keyboard.

Read the problem at least **2–3 times**.

Understand:

- What is given?
- What is required?
- What should be returned?
- Are duplicates allowed?
- Is the array sorted?

---

# Step 2 - Understand the Input

Example

```text
nums = [2,7,11,15]

target = 9
```

Input Type

```
Array
```

Output

```
Indices
```

Not

```
Values
```

---

# Step 3 - Read Constraints

Example

```text
1 <= n <= 100000
```

Think immediately

```
O(n²)

❌ Too Slow

Need

O(n)

or

O(n log n)
```

---

# Step 4 - Draw the Example

```
2 7 11 15

Target = 9
```

Draw

```
2

↓

Need

7

↓

Found
```

Visualization often reveals the solution.

---

# Step 5 - Solve Brute Force

Example

```java
for(int i=0;i<n;i++){

    for(int j=i+1;j<n;j++){

        if(nums[i]+nums[j]==target){

            return new int[]{i,j};

        }

    }

}
```

Complexity

```
Time

O(n²)

Space

O(1)
```

Never skip this step.

---

# Step 6 - Find the Bottleneck

Ask

```
Why is this slow?
```

Example

```
Repeated Searching

↓

Need Faster Lookup

↓

HashMap
```

---

# Step 7 - Recognize the Pattern

Common keywords

| Keyword | Pattern |
|----------|----------|
| Sorted | Binary Search |
| Pair | HashMap / Two Pointers |
| Contiguous | Sliding Window |
| Frequency | HashMap |
| Parentheses | Stack |
| Tree | DFS / BFS |
| Shortest Path | BFS |
| Top K | Heap |
| Choices | DP |
| Generate All | Backtracking |

---

# Step 8 - Write the Algorithm

Don't write Java first.

Example

```
Create HashMap

↓

Traverse Array

↓

Find Remaining Value

↓

Return Answer
```

If the algorithm is clear, coding becomes easy.

---

# Step 9 - Dry Run

Example

```
nums

2 7 11 15

Target

9
```

Iteration

```
Map

{}

↓

2

Store

↓

7

Need

2

Found
```

---

# Step 10 - Write Clean Java Code

Guidelines

- Use meaningful variable names
- Keep methods small
- Avoid unnecessary variables
- Handle edge cases

Good

```java
int left = 0;
int right = nums.length - 1;
```

Bad

```java
int a = 0;
int b = nums.length - 1;
```

---

# Step 11 - Test Edge Cases

Always test

```
Empty Array

Single Element

Duplicates

Negative Numbers

Already Sorted

Target Not Found

Maximum Values
```

---

# Step 12 - Analyze Complexity

Always answer

```
Time Complexity

Why?

Space Complexity

Why?
```

Example

```
Time

O(n)

Space

O(n)

Because HashMap stores every element.
```

---

# Universal Interview Flow

```
Read

↓

Understand

↓

Observe

↓

Brute Force

↓

Optimize

↓

Algorithm

↓

Dry Run

↓

Java

↓

Test

↓

Complexity
```

---

# Problem Solving Checklist

Before coding ask

- What is the input?
- What is the output?
- Are there constraints?
- Is the array sorted?
- Is it contiguous?
- Do I need fast lookup?
- Can I reuse previous computation?
- What is the brute-force solution?

---

# Pattern Recognition Flow

```
Problem

↓

Array?

↓

Sorted?

↓

Binary Search

↓

Need Pair?

↓

HashMap

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

Need Connected Components?

↓

DFS

↓

Need Top K?

↓

Heap

↓

Need Optimal Choice?

↓

DP

↓

Need All Possibilities?

↓

Backtracking
```

---

# Communication During Interviews

Instead of saying

> "I'll use a HashMap."

Say

> "The brute-force solution is O(n²). The bottleneck is repeatedly searching for the complement. A HashMap lets me perform lookups in O(1) average time, reducing the overall complexity to O(n)."

Interviewers evaluate your reasoning, not just your code.

---

# Common Mistakes

❌ Coding immediately

❌ Ignoring constraints

❌ Forgetting edge cases

❌ No dry run

❌ Wrong complexity explanation

❌ Choosing a pattern before understanding the problem

---

# Golden Rules

1. Understand before coding.
2. Write brute force first.
3. Optimize step by step.
4. Dry run before submitting.
5. Explain your reasoning clearly.
6. Always mention complexity.

---

# Example Walkthrough

Problem

```
Two Sum
```

Thinking Process

```
Input

↓

Array

↓

Need Pair

↓

Brute Force

O(n²)

↓

Repeated Lookup

↓

HashMap

↓

O(n)

↓

Dry Run

↓

Java Code

↓

Complexity
```

---

# Interview Checklist

Before pressing **Submit**

- ✅ Read the problem carefully
- ✅ Understood constraints
- ✅ Identified the pattern
- ✅ Wrote brute-force approach
- ✅ Optimized solution
- ✅ Dry run completed
- ✅ Edge cases tested
- ✅ Time complexity known
- ✅ Space complexity known

---

# Final Takeaway

Every new DSA problem can be solved using the same framework:

```
Understand

↓

Observe

↓

Brute Force

↓

Optimize

↓

Algorithm

↓

Dry Run

↓

Implement

↓

Test

↓

Analyze
```

Master this process, and you'll be able to solve unfamiliar interview questions with confidence instead of relying on memorized solutions.