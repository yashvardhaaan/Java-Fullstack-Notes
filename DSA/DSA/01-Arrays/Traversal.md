# Array Traversal in Java

---

# What is Traversal?

Traversal means **visiting every element of an array exactly once** to perform some operation.

Examples of operations:

- Print elements
- Find maximum
- Find minimum
- Calculate sum
- Count occurrences
- Replace values
- Search for an element

---

# Visualization

```text
Index

0    1    2    3    4

+----+----+----+----+----+
| 10 | 20 | 30 | 40 | 50 |
+----+----+----+----+----+

        ^
        i
```

The pointer `i` moves from left to right.

---

# Why Traversal is Important?

Almost every array problem starts with traversal.

Examples:

- Linear Search
- Maximum Element
- Frequency Count
- Two Sum (Brute Force)
- Prefix Sum
- Kadane's Algorithm
- Sliding Window

---

# Basic Traversal

```java
int[] arr = {10,20,30,40,50};

for(int i = 0; i < arr.length; i++){
    System.out.print(arr[i] + " ");
}
```

Output

```text
10 20 30 40 50
```

Time Complexity

```text
O(n)
```

Space Complexity

```text
O(1)
```

---

# Reverse Traversal

```java
for(int i = arr.length - 1; i >= 0; i--){
    System.out.print(arr[i] + " ");
}
```

Output

```text
50 40 30 20 10
```

---

# Enhanced For Loop

```java
for(int num : arr){
    System.out.print(num + " ");
}
```

Advantages

- Cleaner syntax
- Less code

Disadvantages

- No index
- Cannot modify array directly

---

# Traversal Pattern 1

## Find Sum

Problem

Find the sum of all elements.

Input

```text
1 2 3 4 5
```

Output

```text
15
```

Solution

```java
public static int sum(int[] arr){

    int total = 0;

    for(int num : arr){
        total += num;
    }

    return total;
}
```

Dry Run

```text
total = 0

1 -> 1

2 -> 3

3 -> 6

4 -> 10

5 -> 15
```

Complexity

```text
Time : O(n)

Space : O(1)
```

---

# Traversal Pattern 2

## Find Maximum

```java
public static int max(int[] arr){

    int max = arr[0];

    for(int i = 1; i < arr.length; i++){

        if(arr[i] > max){
            max = arr[i];
        }

    }

    return max;
}
```

Dry Run

```text
Array

3 7 2 10 5

max = 3

7 > 3

max = 7

2 > 7

No

10 > 7

max = 10

5 > 10

No
```

---

# Traversal Pattern 3

## Find Minimum

```java
public static int min(int[] arr){

    int min = arr[0];

    for(int i = 1; i < arr.length; i++){

        if(arr[i] < min){
            min = arr[i];
        }

    }

    return min;
}
```

---

# Traversal Pattern 4

## Count Even Numbers

Problem

Count even numbers.

Input

```text
2 7 6 5 10
```

Output

```text
3
```

Solution

```java
public static int countEven(int[] arr){

    int count = 0;

    for(int num : arr){

        if(num % 2 == 0){
            count++;
        }

    }

    return count;
}
```

---

# Traversal Pattern 5

## Linear Search

Problem

Find target element.

Input

```text
10 25 30 45 50

Target = 30
```

Output

```text
Found at index 2
```

Solution

```java
public static int linearSearch(int[] arr, int target){

    for(int i = 0; i < arr.length; i++){

        if(arr[i] == target){
            return i;
        }

    }

    return -1;
}
```

Dry Run

```text
Target = 30

10

No

25

No

30

Found
```

---

# Traversal Pattern 6

## Replace Negative Numbers

Input

```text
2 -5 4 -8 9
```

Output

```text
2 0 4 0 9
```

Solution

```java
public static void replaceNegative(int[] arr){

    for(int i = 0; i < arr.length; i++){

        if(arr[i] < 0){
            arr[i] = 0;
        }

    }

}
```

---

# Traversal Pattern 7

## Count Frequency of Target

Problem

Count occurrences of a number.

Input

```text
1 2 1 4 1

Target = 1
```

Output

```text
3
```

Solution

```java
public static int frequency(int[] arr, int target){

    int count = 0;

    for(int num : arr){

        if(num == target){
            count++;
        }

    }

    return count;
}
```

---

# Traversal Pattern 8

## Find Average

```java
public static double average(int[] arr){

    int sum = 0;

    for(int num : arr){
        sum += num;
    }

    return (double) sum / arr.length;
}
```

---

# Common Traversal Template

```java
for(int i = 0; i < arr.length; i++){

    // Read

    int current = arr[i];

    // Process

    // Update Answer

}
```

Remember

```text
Read

↓

Process

↓

Update Answer

↓

Move Next
```

---

# Dry Run Template

Suppose

```text
Array

3 5 8 2
```

```text
i = 0

current = 3

↓

Process

↓

Answer Updated

↓

i++

↓

current = 5

↓

Continue
```

---

# Common Mistakes

### Wrong

```java
for(int i=0;i<=arr.length;i++)
```

Correct

```java
for(int i=0;i<arr.length;i++)
```

---

### Wrong

```java
arr[arr.length]
```

Correct

```java
arr[arr.length-1]
```

---

### Wrong

```java
int max = 0;
```

Correct

```java
int max = arr[0];
```

Reason

Fails for arrays containing all negative numbers.

---

# Complexity

| Operation | Time |
|-----------|------|
| Traversal | O(n) |
| Search | O(n) |
| Sum | O(n) |
| Max | O(n) |
| Min | O(n) |
| Count | O(n) |

Space

```text
O(1)
```

---

# Interview Tips

Before writing code, ask yourself:

- What should I initialize?
- Do I need an index or only values?
- Can I solve it in one pass?
- What should be returned?
- Are there any edge cases?

---

# Edge Cases

Empty Array

```java
int[] arr = {};
```

Single Element

```java
int[] arr = {5};
```

All Negative

```java
-5 -2 -7
```

All Same

```java
3 3 3 3
```

Large Values

```java
Integer.MAX_VALUE
```

---

# Practice Problems

## Easy

- LeetCode 1920 – Build Array from Permutation
- LeetCode 1929 – Concatenation of Array
- LeetCode 1480 – Running Sum of 1D Array
- LeetCode 1295 – Find Numbers with Even Number of Digits
- LeetCode 485 – Max Consecutive Ones

## Medium

- LeetCode 442 – Find All Duplicates in an Array
- LeetCode 448 – Find All Numbers Disappeared in an Array

---

# Pattern Recognition Checklist

If the problem asks to:

- Print every element → Traversal
- Find maximum/minimum → Traversal
- Count occurrences → Traversal
- Calculate sum/average → Traversal
- Replace values → Traversal
- Search in an unsorted array → Traversal

Whenever you see **"process every element once"**, think **Linear Traversal (O(n))**.

---

# Summary

✅ Traversal means visiting every element exactly once.

✅ It is the foundation for almost every array algorithm.

✅ Mastering traversal makes learning Prefix Sum, Sliding Window, Two Pointers, and Kadane's Algorithm much easier.