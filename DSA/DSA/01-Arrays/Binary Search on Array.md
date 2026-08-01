# Binary Search in Java

---

# What is Binary Search?

Binary Search is a searching algorithm that works on a **sorted** array by repeatedly dividing the search space into half.

Instead of checking every element one by one, Binary Search eliminates half of the remaining elements after every comparison.

---

# Visualization

Target = 13

```
Index

0 1 2 3 4 5 6

Array

2 5 7 9 13 18 25

          ↑
        Mid
```

---

# Why Binary Search?

Linear Search

```
Time = O(n)
```

Binary Search

```
Time = O(log n)
```

Every iteration removes half of the elements.

Example

```
1024 Elements

↓

512

↓

256

↓

128

↓

64

↓

32

↓

16

↓

8

↓

4

↓

2

↓

1
```

Only **10 comparisons** are needed.

---

# When Should You Think of Binary Search?

Keywords

- Sorted Array
- Sorted List
- Search
- First Occurrence
- Last Occurrence
- Search Insert Position
- Minimum Value
- Maximum Value
- Answer lies in a range
- Monotonic Function

---

# Binary Search Prerequisite

Array must be

```
Sorted
```

Example

```
1 3 5 8 10
```

Not

```
8 2 5 10 1
```

---

# Standard Binary Search Template

```java
public static int binarySearch(int[] arr,int target){

    int left = 0;
    int right = arr.length - 1;

    while(left <= right){

        int mid = left + (right-left)/2;

        if(arr[mid] == target){

            return mid;

        }else if(arr[mid] < target){

            left = mid + 1;

        }else{

            right = mid - 1;

        }

    }

    return -1;

}
```

---

# Why

```java
int mid = left + (right-left)/2;
```

Instead of

```java
(left + right)/2
```

Because

```
left + right
```

can overflow for very large integers.

---

# Dry Run

Array

```
2 4 6 8 10 12 14
```

Target

```
10
```

Iteration 1

```
L=0

R=6

Mid=3

8

Target Larger

Move Left
```

Iteration 2

```
L=4

R=6

Mid=5

12

Target Smaller

Move Right
```

Iteration 3

```
L=4

R=4

Mid=4

10

Found
```

---

# Complexity

```
Time

O(log n)

Space

O(1)
```

---

# Pattern 1

## Search Insert Position

LeetCode 35

Input

```
1 3 5 6

Target = 2
```

Output

```
1
```

Java

```java
public int searchInsert(int[] nums,int target){

    int left=0;
    int right=nums.length-1;

    while(left<=right){

        int mid=left+(right-left)/2;

        if(nums[mid]==target)
            return mid;

        if(nums[mid]<target)
            left=mid+1;
        else
            right=mid-1;

    }

    return left;

}
```

---

# Pattern 2

## First Occurrence

Input

```
2 4 4 4 7 9
```

Target

```
4
```

Output

```
1
```

Template

```java
int answer = -1;

while(left<=right){

    int mid=left+(right-left)/2;

    if(arr[mid]==target){

        answer=mid;

        right=mid-1;

    }

    else if(arr[mid]<target){

        left=mid+1;

    }

    else{

        right=mid-1;

    }

}
```

---

# Pattern 3

## Last Occurrence

Difference

When target found

Move

```
Left

↓

No

↓

Move Right
```

```java
answer=mid;

left=mid+1;
```

---

# Pattern 4

## Count Occurrences

Formula

```
Last Index

-

First Index

+

1
```

---

# Pattern 5

## Find Peak Element

LeetCode 162

Observation

```
nums[mid]

>

nums[mid+1]

↓

Peak

On Left
```

Otherwise

```
Peak

On Right
```

---

# Pattern 6

## Rotated Sorted Array

LeetCode 33

Observation

One half is always sorted.

Steps

```
Find Sorted Half

↓

Target Inside?

↓

Yes

Search There

↓

No

Search Other Half
```

---

# Pattern 7

## Minimum in Rotated Sorted Array

LeetCode 153

Observation

Compare

```
nums[mid]

with

nums[right]
```

---

# Pattern 8

## Binary Search on Answer

One of the most important interview patterns.

Examples

- Koko Eating Bananas
- Capacity to Ship Packages
- Split Array Largest Sum
- Minimize Maximum Distance
- Aggressive Cows

Observation

We are **not searching an array.**

We are searching the

```
Answer
```

---

Example

Koko

Search

```
Speed

1

↓

2

↓

3

↓

...

↓

Max Pile
```

Each speed

↓

Check

```
Possible?

Yes

No
```

Binary Search.

---

# Binary Search on Answer Template

```java
while(left<=right){

    int mid=left+(right-left)/2;

    if(isPossible(mid)){

        answer=mid;

        right=mid-1;

    }

    else{

        left=mid+1;

    }

}
```

---

# Pattern Recognition

If problem asks

- Minimum Possible
- Maximum Possible
- Smallest Value
- Largest Value
- Capacity
- Speed
- Distance
- Time
- Answer in Range

Think

```
Binary Search on Answer
```

---

# Common Mistakes

## Mistake 1

Wrong Loop

```java
while(left<right)
```

Standard search

Needs

```java
while(left<=right)
```

---

## Mistake 2

Wrong Mid

```java
(left+right)/2
```

Use

```java
left+(right-left)/2
```

---

## Mistake 3

Binary Search on Unsorted Array

Not allowed.

---

## Mistake 4

Updating Wrong Pointer

Always verify

```
Target

>

Mid

↓

Move Left Pointer

Target

<

Mid

↓

Move Right Pointer
```

---

# Binary Search Templates

## Template 1

Exact Search

```java
while(left<=right)
```

---

## Template 2

First Position

```java
answer=mid;

right=mid-1;
```

---

## Template 3

Last Position

```java
answer=mid;

left=mid+1;
```

---

## Template 4

Binary Search on Answer

```java
if(isPossible(mid))

right=mid-1;

else

left=mid+1;
```

---

# Complexity

| Operation | Time |
|------------|------|
| Search | O(log n) |
| First Occurrence | O(log n) |
| Last Occurrence | O(log n) |
| Insert Position | O(log n) |
| Peak Element | O(log n) |
| Rotated Search | O(log n) |

Space

```
O(1)
```

---

# Interview Tips

Always ask

- Is the array sorted?
- Can half of the search space be discarded?
- Is the answer monotonic?
- Am I searching data or the answer itself?

---

# Practice Problems

## Easy

- LeetCode 35 – Search Insert Position
- LeetCode 704 – Binary Search
- LeetCode 69 – Sqrt(x)

## Medium

- LeetCode 33 – Search in Rotated Sorted Array
- LeetCode 34 – Find First and Last Position
- LeetCode 162 – Find Peak Element
- LeetCode 153 – Find Minimum in Rotated Sorted Array
- LeetCode 74 – Search a 2D Matrix
- LeetCode 875 – Koko Eating Bananas
- LeetCode 1011 – Capacity To Ship Packages Within D Days
- LeetCode 1283 – Find the Smallest Divisor Given a Threshold

## Hard

- LeetCode 410 – Split Array Largest Sum
- LeetCode 1231 – Divide Chocolate

---

# Binary Search Decision Tree

```
Problem

↓

Sorted?

↓

Yes

↓

Need Search?

↓

Binary Search

↓

Duplicates?

↓

First / Last Occurrence

↓

Rotated?

↓

Rotated Binary Search

↓

Answer in Range?

↓

Binary Search on Answer
```

---

# Summary

✅ Binary Search works only on **sorted or monotonic data**.

✅ It reduces the search space by half in every iteration.

✅ Learn these four templates:
- Exact Search
- First Occurrence
- Last Occurrence
- Binary Search on Answer

✅ Master these interview patterns:
- Search
- Rotated Array
- Peak Element
- Lower/Upper Bound
- Binary Search on Answer