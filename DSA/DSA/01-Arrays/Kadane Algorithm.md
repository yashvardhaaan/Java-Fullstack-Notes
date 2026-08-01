# Kadane's Algorithm in Java

> Find the **Maximum Sum Contiguous Subarray** in **O(n)** time.

---

# What is Kadane's Algorithm?

Kadane's Algorithm is an efficient algorithm used to find the **maximum sum of a contiguous subarray**.

Instead of checking every possible subarray (**O(n²)**), it solves the problem in **O(n)**.

---

# Problem Statement

Given an integer array, find the **maximum sum** of any contiguous subarray.

Example

```
Input

[-2,1,-3,4,-1,2,1,-5,4]

Output

6
```

Subarray

```
4 -1 2 1
```

---

# Brute Force Approach

Generate every possible subarray.

```java
int max = Integer.MIN_VALUE;

for(int i=0;i<n;i++){

    int sum = 0;

    for(int j=i;j<n;j++){

        sum += arr[j];

        max = Math.max(max,sum);

    }

}
```

Complexity

```
Time  : O(n²)

Space : O(1)
```

---

# Observation

Suppose

```
Current Sum = -5

Next Element = 8
```

Should we keep

```
-5 + 8 = 3
```

or

```
8
```

Answer

```
8
```

A negative sum only decreases the answer.

---

# Intuition

Whenever the current sum becomes negative,

Start a new subarray.

---

# Kadane's Algorithm

Algorithm

```
Take current element

↓

Add to Current Sum

↓

Update Maximum Sum

↓

If Current Sum < 0

↓

Reset Current Sum = 0
```

---

# Java Code

```java
public int maxSubArray(int[] nums){

    int currentSum = 0;

    int maxSum = Integer.MIN_VALUE;

    for(int num : nums){

        currentSum += num;

        maxSum = Math.max(maxSum,currentSum);

        if(currentSum < 0){

            currentSum = 0;

        }

    }

    return maxSum;

}
```

---

# Dry Run

Input

```
-2 1 -3 4 -1 2 1 -5 4
```

| Number | Current Sum | Max Sum |
|--------|------------|---------|
| -2 | -2 → 0 | -2 |
| 1 | 1 | 1 |
| -3 | -2 → 0 | 1 |
| 4 | 4 | 4 |
| -1 | 3 | 4 |
| 2 | 5 | 5 |
| 1 | 6 | 6 |
| -5 | 1 | 6 |
| 4 | 5 | 6 |

Answer

```
6
```

---

# Why Does It Work?

At every index we make a choice.

```
Continue Previous Subarray

OR

Start New Subarray
```

If previous sum is negative,

Starting new is always better.

---

# Complexity

```
Time

O(n)

Space

O(1)
```

---

# Pattern 1

## Maximum Subarray Sum

LeetCode 53

Use standard Kadane.

---

# Pattern 2

## Print Maximum Subarray

```java
public int[] maxSubArrayIndices(int[] nums){

    int start = 0;
    int end = 0;
    int tempStart = 0;

    int current = 0;
    int max = Integer.MIN_VALUE;

    for(int i=0;i<nums.length;i++){

        current += nums[i];

        if(current > max){

            max = current;
            start = tempStart;
            end = i;

        }

        if(current < 0){

            current = 0;
            tempStart = i + 1;

        }

    }

    return new int[]{start,end};

}
```

---

Example

```
Array

-2 1 -3 4 -1 2 1

Answer

4 -1 2 1
```

Indexes

```
3

↓

6
```

---

# Pattern 3

## Maximum Circular Subarray

LeetCode 918

Observation

Maximum Answer

```
Either

Normal Kadane

OR

Total Sum

-

Minimum Subarray
```

Formula

```
max(

NormalKadane,

TotalSum-MinKadane

)
```

---

# Pattern 4

## Maximum Product Subarray

LeetCode 152

Need

```
Maximum Product

Minimum Product
```

because multiplying by a negative number swaps them.

---

# Pattern 5

## Minimum Subarray Sum

Simply reverse Kadane.

```java
current = Math.min(num,current+num);

minimum = Math.min(minimum,current);
```

---

# Dynamic Programming View

Kadane is actually Dynamic Programming.

State

```
dp[i]

=

Maximum Sum

Ending At

i
```

Transition

```
dp[i]

=

max(

arr[i],

arr[i]+dp[i-1]

)
```

Space Optimized

↓

Kadane.

---

# Generic Template

```java
int current = 0;

int answer = Integer.MIN_VALUE;

for(int num : nums){

    current += num;

    answer = Math.max(answer,current);

    if(current < 0){

        current = 0;

    }

}
```

---

# Dry Run Template

```
Current Sum

↓

Add Current Number

↓

Update Maximum

↓

Negative?

↓

Reset
```

---

# Common Mistakes

## Mistake 1

Initializing

```java
int max = 0;
```

Wrong

Fails when all numbers are negative.

Correct

```java
int max = Integer.MIN_VALUE;
```

---

## Mistake 2

Updating answer after resetting.

Correct Order

```
Add

↓

Update Answer

↓

Reset
```

---

## Mistake 3

Resetting on zero.

Only reset when

```
Current Sum < 0
```

---

# Pattern Recognition

Think Kadane when the question says

- Maximum Sum
- Maximum Contiguous Subarray
- Largest Sum
- Continuous Segment
- Best Interval

---

# Interview Tips

Questions interviewers ask

- Why reset on negative?
- Why is Kadane O(n)?
- Can you print the subarray?
- Can you solve Circular Maximum Subarray?
- Can you solve Maximum Product Subarray?

---

# Practice Problems

## Easy

- LeetCode 53 – Maximum Subarray

## Medium

- LeetCode 918 – Maximum Sum Circular Subarray
- LeetCode 152 – Maximum Product Subarray
- LeetCode 1749 – Maximum Absolute Sum

## Hard

- LeetCode 689 – Maximum Sum of 3 Non-Overlapping Subarrays
- LeetCode 1191 – K-Concatenation Maximum Sum

---

# Decision Tree

```
Problem

↓

Maximum Sum?

↓

Contiguous?

↓

Yes

↓

Kadane

↓

Circular?

↓

Kadane + Minimum Subarray

↓

Product?

↓

Max Product DP
```

---

# Summary

✅ Kadane's Algorithm finds the maximum sum contiguous subarray in **O(n)**.

✅ Reset the running sum only when it becomes negative.

✅ Always initialize the answer with `Integer.MIN_VALUE`.

✅ Learn these variations:
- Maximum Subarray
- Print Maximum Subarray
- Circular Maximum Subarray
- Maximum Product Subarray
- Minimum Subarray

---

# Quick Revision

```
Brute Force

O(n²)

↓

Kadane

O(n)

Formula

current = current + num

answer = max(answer,current)

if(current < 0)

current = 0

Used For

• Maximum Sum
• Circular Maximum Sum
• Maximum Product
• DP Optimization
```