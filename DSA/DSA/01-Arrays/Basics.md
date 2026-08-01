# Arrays in Java

---

# What is an Array?

An array is a **fixed-size collection of elements of the same data type** stored in **contiguous memory locations**.

```text
Index

0    1    2    3    4

+----+----+----+----+----+
| 10 | 20 | 30 | 40 | 50 |
+----+----+----+----+----+
```

Every element can be accessed using its **index**.

---

# Why Arrays?

Arrays provide:

- Fast access using index
- Easy traversal
- Efficient memory usage
- Foundation for many DSA problems

Examples:

- Searching
- Sorting
- Sliding Window
- Prefix Sum
- Binary Search
- Dynamic Programming

---

# Declaration

```java
int[] arr;
```

or

```java
int arr[];
```

**Preferred**

```java
int[] arr;
```

---

# Initialization

## Method 1

```java
int[] arr = new int[5];
```

Output

```text
0 0 0 0 0
```

---

## Method 2

```java
int[] arr = {10,20,30,40,50};
```

---

## Method 3

```java
int[] arr = new int[]{1,2,3};
```

---

# Accessing Elements

```java
int[] arr = {10,20,30};

System.out.println(arr[0]);
System.out.println(arr[2]);
```

Output

```text
10
30
```

### Time Complexity

```text
O(1)
```

### Why?

Because Java calculates the address directly.

```text
Address = Base + (Index × Size)
```

---

# Updating Elements

```java
arr[1] = 100;
```

Before

```text
10 20 30
```

After

```text
10 100 30
```

Time Complexity

```text
O(1)
```

---

# Array Length

```java
System.out.println(arr.length);
```

Notice

Use

```java
arr.length
```

Not

```java
arr.length()
```

---

# Traversing an Array

## Using for loop

```java
for(int i=0;i<arr.length;i++){
    System.out.print(arr[i]+" ");
}
```

Output

```text
10 20 30 40 50
```

---

## Using Enhanced For Loop

```java
for(int num : arr){
    System.out.print(num+" ");
}
```

### Use when

- Reading elements
- Printing values

### Don't use when

- Modifying elements
- Needing indexes

---

# Taking Input

```java
Scanner sc = new Scanner(System.in);

int n = sc.nextInt();

int[] arr = new int[n];

for(int i=0;i<n;i++){
    arr[i] = sc.nextInt();
}
```

---

# Printing Arrays

## Method 1

```java
for(int num : arr){
    System.out.print(num+" ");
}
```

---

## Method 2

```java
System.out.println(Arrays.toString(arr));
```

Output

```text
[1, 2, 3, 4]
```

---

# Memory Representation

Suppose

```java
int[] arr = {5,10,15};
```

```text
Reference
   |
   V

+-----+-----+-----+
|  5  | 10  | 15  |
+-----+-----+-----+
```

The variable

```java
arr
```

stores a **reference** to the array, not the actual data.

---

# Passing Arrays to Methods

```java
public static void printArray(int[] arr){

    for(int num : arr){
        System.out.print(num + " ");
    }

}
```

Call

```java
printArray(arr);
```

---

# Returning Arrays

```java
public static int[] create(){

    return new int[]{1,2,3};

}
```

---

# Default Values

| Data Type | Default Value |
|-----------|---------------|
| int | 0 |
| long | 0 |
| double | 0.0 |
| boolean | false |
| char | '\u0000' |
| String | null |

---

# Time Complexities

| Operation | Complexity |
|-----------|------------|
| Access | O(1) |
| Update | O(1) |
| Search | O(n) |
| Insert | O(n) |
| Delete | O(n) |

---

# Common Mistakes

## ❌ Wrong

```java
arr.length()
```

✅ Correct

```java
arr.length
```

---

## ❌ Wrong

```java
arr[arr.length]
```

✅ Correct

```java
arr[arr.length-1]
```

---

## ❌ Wrong

```java
arr[-1]
```

Invalid index.

---

## ❌ Wrong

```java
int[] arr = new int[-5];
```

Throws

```text
NegativeArraySizeException
```

---

# Interview Questions

## Q1. Can array size be changed?

No.

Arrays are fixed-size.

Use

```java
ArrayList<Integer>
```

for dynamic resizing.

---

## Q2. Why is array access O(1)?

Because the address is calculated directly using the index.

---

## Q3. Array vs ArrayList

| Array | ArrayList |
|--------|-----------|
| Fixed size | Dynamic size |
| Faster | Slightly slower |
| Stores primitives | Stores Objects / Wrapper Classes |
| No built-in methods | Rich API |

---

# Solved Example 1

## Find Maximum Element

### Problem

Input

```text
2 8 1 9 4
```

Output

```text
9
```

### Approach

Keep track of the maximum element seen so far.

### Java Solution

```java
public static int findMax(int[] arr){

    int max = arr[0];

    for(int i=1;i<arr.length;i++){

        if(arr[i] > max){
            max = arr[i];
        }

    }

    return max;

}
```

### Dry Run

```text
Array = [2,8,1,9,4]

max = 2

8 > 2 ✔
max = 8

1 > 8 ✘

9 > 8 ✔
max = 9

4 > 9 ✘

Answer = 9
```

### Complexity

```text
Time  : O(n)
Space : O(1)
```

---

# Solved Example 2

## Reverse an Array

### Problem

Input

```text
1 2 3 4 5
```

Output

```text
5 4 3 2 1
```

### Pattern

Two Pointers

### Java Solution

```java
public static void reverse(int[] arr){

    int left = 0;
    int right = arr.length - 1;

    while(left < right){

        int temp = arr[left];
        arr[left] = arr[right];
        arr[right] = temp;

        left++;
        right--;
    }

}
```

### Dry Run

```text
Initial

[1,2,3,4,5]

left = 0
right = 4

Swap 1 and 5

[5,2,3,4,1]

left = 1
right = 3

Swap 2 and 4

[5,4,3,2,1]

left = 2
right = 2

Stop
```

### Complexity

```text
Time  : O(n)
Space : O(1)
```

---

# Pattern Recognition Checklist

Before solving an array problem, ask yourself:

- Is it asking for a single traversal?
- Does it involve both ends of the array?
- Is the array sorted?
- Is it asking about contiguous subarrays?
- Does it ask for range sums?
- Does it involve maximum/minimum subarray?
- Is there a need for two pointers?
- Can I solve it in one pass?
- Is there a brute-force solution that can be optimized?

---

# Summary

✔ Arrays store elements of the same type.

✔ Arrays have fixed size.

✔ Index starts from **0**.

✔ Access and update are **O(1)**.

✔ Search is **O(n)**.

✔ Arrays are the foundation of many interview patterns like:

- Traversal
- Two Pointers
- Sliding Window
- Prefix Sum
- Binary Search
- Kadane's Algorithm
- Matrix Problems