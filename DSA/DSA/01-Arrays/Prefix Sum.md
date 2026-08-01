# Prefix Sum in Java

---

# What is Prefix Sum?

A Prefix Sum array stores the cumulative sum of elements from the beginning of the array.

For every index `i`:

```
prefix[i] = arr[0] + arr[1] + ... + arr[i]
```

Instead of calculating sums repeatedly, we precompute them once.

---

# Why Prefix Sum?

Without Prefix Sum:

```
Range Sum

L = 2
R = 6

Need to iterate every time.

Time = O(n)
```

With Prefix Sum

```
Answer in O(1)
```

---

# Visualization

Array

```
Index

0 1 2 3 4

+---+---+---+---+---+
| 2 | 4 | 1 | 5 | 3 |
+---+---+---+---+---+
```

Prefix Array

```
2

2+4 = 6

6+1 = 7

7+5 = 12

12+3 = 15
```

Result

```
2 6 7 12 15
```

---

# Building Prefix Sum

## Java Code

```java
public static int[] prefixSum(int[] arr){

    int n = arr.length;

    int[] prefix = new int[n];

    prefix[0] = arr[0];

    for(int i = 1; i < n; i++){

        prefix[i] = prefix[i-1] + arr[i];

    }

    return prefix;

}
```

---

# Dry Run

Array

```
2 4 1 5 3
```

Iteration

```
prefix[0] = 2

prefix[1] = 6

prefix[2] = 7

prefix[3] = 12

prefix[4] = 15
```

---

# Complexity

```
Build

Time

O(n)

Space

O(n)
```

---

# Range Sum Query

Problem

Find sum from

```
L = 1

R = 3
```

Array

```
2 4 1 5 3
```

Answer

```
4 + 1 + 5

= 10
```

Formula

If

```
L == 0

Answer = prefix[R]
```

Otherwise

```
Answer = prefix[R] - prefix[L-1]
```

---

# Java Code

```java
public static int rangeSum(int[] prefix,int left,int right){

    if(left==0)
        return prefix[right];

    return prefix[right]-prefix[left-1];

}
```

---

# Dry Run

```
Prefix

2 6 7 12 15

L = 1

R = 3

12 - 2

10
```

---

# Pattern 1

## Running Sum

LeetCode 1480

Input

```
1 2 3 4
```

Output

```
1 3 6 10
```

Solution

```java
public int[] runningSum(int[] nums){

    for(int i=1;i<nums.length;i++){

        nums[i]+=nums[i-1];

    }

    return nums;

}
```

Complexity

```
Time O(n)

Space O(1)
```

---

# Pattern 2

## Find Pivot Index

LeetCode 724

Observation

```
Left Sum

==

Right Sum
```

Formula

```
Total Sum

-

Current

-

Left Sum
```

Java

```java
public int pivotIndex(int[] nums){

    int total = 0;

    for(int num:nums)
        total+=num;

    int left = 0;

    for(int i=0;i<nums.length;i++){

        if(left==total-left-nums[i])
            return i;

        left+=nums[i];

    }

    return -1;

}
```

---

# Pattern 3

## Subarray Sum Equals K

LeetCode 560

Observation

Need Prefix Sum + HashMap

Formula

```
Current Prefix

-

Previous Prefix

=

K
```

Need

```
prefix-k
```

Java

```java
public int subarraySum(int[] nums,int k){

    HashMap<Integer,Integer> map = new HashMap<>();

    map.put(0,1);

    int prefix = 0;

    int answer = 0;

    for(int num:nums){

        prefix+=num;

        if(map.containsKey(prefix-k)){

            answer+=map.get(prefix-k);

        }

        map.put(prefix,map.getOrDefault(prefix,0)+1);

    }

    return answer;

}
```

Complexity

```
Time

O(n)

Space

O(n)
```

---

# Pattern 4

## Continuous Subarray Sum

LeetCode 523

Idea

```
Prefix Sum

+

Modulo
```

Store

```
prefix % k
```

inside HashMap.

---

# Pattern 5

## Prefix XOR

Instead of Sum

Use

```
^

(XOR)
```

Formula

```
prefix[i]

=

prefix[i-1]

^

arr[i]
```

Useful in XOR problems.

---

# Pattern 6

## Difference Array

Instead of adding values individually

Store changes

```
+5

at L

-5

at R+1
```

Then compute Prefix Sum once.

Useful for

- Range Updates
- Flight Bookings
- Corporate Flight Bookings (LC 1109)

---

# Pattern 7

## 2D Prefix Sum

Matrix

```
1 2

3 4
```

Formula

```
prefix[i][j]

=

Top

+

Left

-

Diagonal

+

Current
```

Used in

- Matrix Sum Queries
- Image Processing

---

# Generic Template

## Build Prefix

```java
int[] prefix = new int[n];

prefix[0]=arr[0];

for(int i=1;i<n;i++){

    prefix[i]=prefix[i-1]+arr[i];

}
```

---

## Query

```java
if(left==0)

return prefix[right];

return prefix[right]-prefix[left-1];
```

---

# Dry Run Template

```
Array

2 4 1 5 3

↓

Prefix

2

6

7

12

15

↓

Query

L=1

R=3

12-2

10
```

---

# Pattern Recognition

Think Prefix Sum when the question says

- Range Sum
- Running Sum
- Continuous Subarray
- Count Subarrays
- Equal Sum
- Target Sum
- Prefix
- Cumulative Sum

---

# Common Mistakes

## Mistake 1

Wrong Formula

```
prefix[right]-prefix[left]
```

Correct

```
prefix[right]-prefix[left-1]
```

---

## Mistake 2

Forgetting

```
left==0
```

Special case.

---

## Mistake 3

Building Prefix incorrectly.

Always

```
prefix[0]=arr[0]
```

---

## Mistake 4

Not using HashMap for Subarray Sum problems.

---

# Complexity

| Operation | Time |
|------------|------|
| Build Prefix | O(n) |
| Query | O(1) |
| Running Sum | O(n) |
| Subarray Sum | O(n) |

Space

```
O(n)
```

---

# Interview Tips

Ask yourself

- Is the question asking for many range sum queries?
- Can cumulative information help?
- Is there a target sum?
- Can I convert repeated calculations into one preprocessing step?

If yes

Think

```
Prefix Sum
```

---

# Practice Problems

## Easy

- LeetCode 1480 – Running Sum of 1D Array
- LeetCode 303 – Range Sum Query
- LeetCode 724 – Find Pivot Index

## Medium

- LeetCode 560 – Subarray Sum Equals K
- LeetCode 525 – Contiguous Array
- LeetCode 523 – Continuous Subarray Sum
- LeetCode 930 – Binary Subarrays With Sum
- LeetCode 974 – Subarray Sums Divisible by K
- LeetCode 1248 – Count Number of Nice Subarrays
- LeetCode 1109 – Corporate Flight Bookings

## Hard

- LeetCode 1074 – Number of Submatrices That Sum to Target
- LeetCode 363 – Max Sum of Rectangle No Larger Than K

---

# Summary

✅ Prefix Sum preprocesses cumulative sums in **O(n)**.

✅ Every range sum query becomes **O(1)**.

✅ Combining **Prefix Sum + HashMap** solves many **Medium** and **Hard** interview problems.

✅ Learn these advanced variants:
- Prefix Sum
- Prefix XOR
- Difference Array
- 2D Prefix Sum
- Prefix Sum + HashMap