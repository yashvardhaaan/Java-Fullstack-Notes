# Sorting Algorithms in Java

---

# What is Sorting?

Sorting is the process of arranging data in a specific order.

Usually:

- Ascending
- Descending

Example

Input

```
5 2 8 1 4
```

Output

```
1 2 4 5 8
```

---

# Why is Sorting Important?

Sorting makes many algorithms efficient.

Examples

- Binary Search
- Two Pointers
- Merge Intervals
- Remove Duplicates
- Searching
- Closest Pair Problems

---

# Types of Sorting

```
Sorting

│

├── Comparison Based
│   ├── Bubble Sort
│   ├── Selection Sort
│   ├── Insertion Sort
│   ├── Merge Sort
│   ├── Quick Sort
│   └── Heap Sort
│
└── Non Comparison
    ├── Counting Sort
    ├── Radix Sort
    └── Bucket Sort
```

---

# Bubble Sort

## Idea

Repeatedly swap adjacent elements if they are in the wrong order.

---

### Example

```
5 1 4 2

Pass 1

5 1

Swap

1 5 4 2

↓

5 4

Swap

1 4 5 2

↓

5 2

Swap

1 4 2 5
```

---

### Java

```java
public static void bubbleSort(int[] arr){

    int n = arr.length;

    for(int i=0;i<n-1;i++){

        boolean swapped = false;

        for(int j=0;j<n-i-1;j++){

            if(arr[j] > arr[j+1]){

                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;

                swapped = true;

            }

        }

        if(!swapped)
            break;

    }

}
```

---

### Complexity

| Best | Average | Worst | Space |
|------|---------|--------|-------|
| O(n) | O(n²) | O(n²) | O(1) |

Stable ✅

In-place ✅

---

# Selection Sort

## Idea

Find the minimum element.

Place it at the correct position.

---

Example

```
5 2 8 1

↓

Minimum

1

↓

Swap

1 2 8 5
```

---

### Java

```java
public static void selectionSort(int[] arr){

    for(int i=0;i<arr.length-1;i++){

        int min=i;

        for(int j=i+1;j<arr.length;j++){

            if(arr[j]<arr[min])
                min=j;

        }

        int temp=arr[min];
        arr[min]=arr[i];
        arr[i]=temp;

    }

}
```

---

Complexity

| Best | Average | Worst | Space |
|------|---------|--------|-------|
| O(n²) | O(n²) | O(n²) | O(1) |

Stable ❌

---

# Insertion Sort

## Idea

Assume left side is already sorted.

Insert current element into the correct position.

---

Visualization

```
5 2 4 6

↓

Sorted

5

↓

Insert

2

↓

2 5
```

---

Java

```java
public static void insertionSort(int[] arr){

    for(int i=1;i<arr.length;i++){

        int key=arr[i];

        int j=i-1;

        while(j>=0 && arr[j]>key){

            arr[j+1]=arr[j];

            j--;

        }

        arr[j+1]=key;

    }

}
```

---

Complexity

| Best | Average | Worst | Space |
|------|---------|--------|-------|
| O(n) | O(n²) | O(n²) | O(1) |

Stable ✅

---

# Merge Sort

## Divide and Conquer

```
8 4 2 6

↓

8 4

2 6

↓

8

4

2

6

↓

Merge

↓

2 4 6 8
```

---

Java

```java
public static void mergeSort(int[] arr,int left,int right){

    if(left>=right)
        return;

    int mid=(left+right)/2;

    mergeSort(arr,left,mid);

    mergeSort(arr,mid+1,right);

    merge(arr,left,mid,right);

}
```

---

Complexity

| Best | Average | Worst | Space |
|------|---------|--------|-------|
| O(n log n) | O(n log n) | O(n log n) | O(n) |

Stable ✅

---

# Quick Sort

## Divide Around Pivot

```
7 2 1 8 6 3

↓

Pivot

3

↓

2 1

3

7 8 6
```

---

Java

```java
public static void quickSort(int[] arr,int low,int high){

    if(low<high){

        int pivot=partition(arr,low,high);

        quickSort(arr,low,pivot-1);

        quickSort(arr,pivot+1,high);

    }

}
```

---

Complexity

| Best | Average | Worst | Space |
|------|---------|--------|-------|
| O(n log n) | O(n log n) | O(n²) | O(log n) |

Stable ❌

---

# Heap Sort

Idea

1. Build Max Heap
2. Remove largest
3. Heapify again

Time

```
O(n log n)
```

---

# Counting Sort

Works only when numbers are in a limited range.

Example

```
2 1 2 3 1

↓

Count

↓

1 1 2 2 3
```

Complexity

```
O(n+k)
```

---

# Radix Sort

Sort digit by digit.

Example

```
329

457

657

839

436

720

355
```

Sort

Units

↓

Tens

↓

Hundreds

---

# Java Built-in Sorting

## Arrays.sort()

```java
Arrays.sort(arr);
```

Ascending

---

Descending

```java
Integer[] arr={5,2,8};

Arrays.sort(arr,Collections.reverseOrder());
```

---

Collections.sort()

```java
Collections.sort(list);
```

---

Custom Comparator

```java
Collections.sort(list,(a,b)->a-b);
```

Descending

```java
Collections.sort(list,(a,b)->b-a);
```

---

# Stable vs Unstable

Stable

```
Bubble

Insertion

Merge

Counting
```

Unstable

```
Selection

Quick

Heap
```

---

# In-place vs Out-of-place

In-place

```
Bubble

Selection

Insertion

Quick

Heap
```

Out-of-place

```
Merge

Counting
```

---

# Comparison Table

| Algorithm | Best | Average | Worst | Stable | In-place |
|------------|------|---------|--------|---------|----------|
| Bubble | O(n) | O(n²) | O(n²) | ✅ | ✅ |
| Selection | O(n²) | O(n²) | O(n²) | ❌ | ✅ |
| Insertion | O(n) | O(n²) | O(n²) | ✅ | ✅ |
| Merge | O(n log n) | O(n log n) | O(n log n) | ✅ | ❌ |
| Quick | O(n log n) | O(n log n) | O(n²) | ❌ | ✅ |
| Heap | O(n log n) | O(n log n) | O(n log n) | ❌ | ✅ |

---

# Which Sort Should I Use?

| Situation | Algorithm |
|------------|-----------|
| Small Arrays | Insertion Sort |
| Nearly Sorted | Insertion Sort |
| General Purpose | Merge Sort |
| Fast Average | Quick Sort |
| Guaranteed O(n log n) | Merge / Heap |
| Small Range Integers | Counting Sort |

---

# Interview Tips

Questions interviewers ask:

- Why is Merge Sort stable?
- Why can Quick Sort become O(n²)?
- Difference between Merge Sort and Quick Sort?
- Why does Java use Dual Pivot Quick Sort for primitive arrays?
- Why is Arrays.sort() different for objects?

---

# Practice Problems

Easy

- LeetCode 912 – Sort an Array
- LeetCode 75 – Sort Colors
- LeetCode 88 – Merge Sorted Array

Medium

- LeetCode 56 – Merge Intervals
- LeetCode 179 – Largest Number
- LeetCode 215 – Kth Largest Element

Hard

- LeetCode 493 – Reverse Pairs
- LeetCode 315 – Count of Smaller Numbers After Self

---

# Summary

✅ Learn Bubble, Selection, Insertion for fundamentals.

✅ Learn Merge Sort and Quick Sort thoroughly for interviews.

✅ Understand stability, in-place sorting, and complexity.

✅ Use `Arrays.sort()` in Java unless the interviewer asks you to implement the algorithm manually.