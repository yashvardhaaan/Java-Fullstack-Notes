# 🧠 How to Approach Any DSA Problem

> "Don't jump into coding. Think first."

---

# Step 1 : Read the Problem Carefully

Read the question **2–3 times**.

Understand:

- What is the input?
- What is the output?
- What exactly is being asked?

Example

```
Input

nums = [2,7,11,15]
target = 9

Output

[0,1]
```

---

# Step 2 : Understand the Constraints

Look at constraints first.

Example

```
1 <= n <= 10^5
```

Immediately ask:

```
Can O(n²) work?
```

No.

Need

```
O(n log n)

or

O(n)
```

---

# Step 3 : Identify Input Type

Ask

```
Is it

Array?

String?

Linked List?

Tree?

Graph?

Matrix?
```

Knowing the input already removes many possibilities.

---

# Step 4 : Find Keywords

Look for keywords.

| Keyword | Pattern |
|----------|----------|
| Sorted | Binary Search |
| Contiguous | Sliding Window |
| Pair | Two Pointers / HashMap |
| Frequency | HashMap |
| Top K | Heap |
| Shortest Path | BFS / Dijkstra |
| Connected | Graph |
| Parentheses | Stack |
| Recursive Structure | Recursion |
| Maximum / Minimum | DP / Greedy |

---

# Step 5 : Draw the Example

Example

```
nums = [2,7,11,15]

Target = 9
```

Draw

```
2

7

11

15
```

Visualize before coding.

---

# Step 6 : Solve Brute Force First

Never jump directly to the optimized solution.

Example

Two Sum

Brute Force

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
O(n²)
```

---

# Step 7 : Ask

How can I avoid repeated work?

Questions

- Can I store previous answers?
- Can I sort?
- Can I use HashMap?
- Can I use Prefix Sum?
- Can I use Sliding Window?
- Can I use Binary Search?

---

# Step 8 : Identify the Pattern

Example

```
Need Fast Lookup

↓

HashMap
```

```
Sorted Array

↓

Binary Search
```

```
Contiguous

↓

Sliding Window
```

```
Pair

↓

Two Pointers
```

---

# Step 9 : Write Algorithm

Before Java.

Example

```
1.

Create HashMap

↓

2.

Traverse Array

↓

3.

Find Remaining Value

↓

4.

Return Answer
```

---

# Step 10 : Dry Run

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

# Step 11 : Write Java Code

Only now.

Write clean code.

- Meaningful variable names
- Proper indentation
- Edge cases

---

# Step 12 : Test Edge Cases

Always test.

```
Empty Array

Single Element

Duplicates

Negative Numbers

Large Values

Sorted Input

Unsorted Input
```

---

# Step 13 : Analyze Complexity

Always write

```
Time Complexity

Space Complexity
```

Example

```
Time

O(n)

Space

O(n)
```

---

# Universal Problem Solving Flow

```
Read Problem

↓

Understand Input

↓

Check Constraints

↓

Identify Pattern

↓

Brute Force

↓

Optimization

↓

Algorithm

↓

Dry Run

↓

Java Code

↓

Test

↓

Complexity
```

---

# Pattern Recognition Cheat Sheet

| If Question Says... | Think... |
|----------------------|----------|
| Sorted | Binary Search |
| Pair Sum | HashMap / Two Pointers |
| Contiguous | Sliding Window |
| Range Sum | Prefix Sum |
| Frequency | HashMap |
| Parentheses | Stack |
| Shortest Path | BFS |
| Connected Components | DFS |
| K Largest | Heap |
| Choices at Every Step | Backtracking |
| Maximum Profit | Greedy / DP |
| Minimum Operations | BFS / DP |

---

# Common Mistakes

❌ Jumping directly into coding.

❌ Ignoring constraints.

❌ Forgetting edge cases.

❌ Not writing brute force first.

❌ Not recognizing the pattern.

❌ Not dry running the code.

---

# Interview Checklist

Before submitting, ask yourself:

- ✔ Did I understand the problem?
- ✔ Is there a simpler brute-force solution?
- ✔ Can I optimize it?
- ✔ Which DSA pattern fits?
- ✔ Did I test edge cases?
- ✔ What is the time complexity?
- ✔ What is the space complexity?

---

# Golden Rule

> **Think → Plan → Dry Run → Code → Test**

Never follow:

```
Read

↓

Code Immediately

↓

Debug for 30 Minutes
```

Always follow:

```
Read

↓

Think

↓

Plan

↓

Code

↓

Test
```

---

# Final Takeaway

Every DSA problem can usually be solved by following this process:

```
Understand

↓

Observe

↓

Brute Force

↓

Optimize

↓

Implement

↓

Verify

↓

Analyze
```

Master the process, and you'll solve new problems much faster than by memorizing solutions.