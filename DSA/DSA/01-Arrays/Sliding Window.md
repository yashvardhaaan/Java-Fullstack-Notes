# Sliding Window in Java

---

# What is Sliding Window?

Sliding Window is an optimization technique used to solve **subarray** or **substring** problems by maintaining a window of elements instead of recomputing everything repeatedly.

Instead of checking every possible subarray (O(n²)), we move the window efficiently to achieve **O(n)**.

---

# When Should You Think of Sliding Window?

Look for these keywords:

- Subarray
- Substring
- Contiguous
- Longest
- Shortest
- Maximum Sum
- Minimum Length
- At Most K
- Exactly K
- Consecutive

If the problem says **contiguous**, Sliding Window should be your first thought.

---

# Types of Sliding Window

## 1. Fixed Size Window

Window size never changes.

Examples

- Maximum Sum of Size K
- Average of K Elements
- Number of Distinct Elements in K Window

---

## 2. Variable Size Window

Window grows and shrinks.

Examples

- Longest Substring Without Repeating Characters
- Minimum Window Substring
- Minimum Size Subarray Sum

---

# Visualization

Window Size = 3

```
1 2 3 4 5 6

[1 2 3]

↓

[2 3 4]

↓

[3 4 5]

↓

[4 5 6]
```

---

# Why Sliding Window?

Brute Force

```
Every subarray

O(n²)
```

Sliding Window

```
One traversal

O(n)
```

---

# Fixed Window Template

```java
int left = 0;
int sum = 0;

for(int right = 0; right < arr.length; right++){

    sum += arr[right];

    if(right - left + 1 > k){
        sum -= arr[left];
        left++;
    }

    if(right - left + 1 == k){
        // Update answer
    }

}
```

---

# Variable Window Template

```java
int left = 0;

for(int right = 0; right < arr.length; right++){

    // Expand window

    while(condition){

        // Shrink window

        left++;

    }

    // Update answer

}
```

---

# Pattern 1

## Maximum Sum Subarray of Size K

Input

```
2 1 5 1 3 2

K = 3
```

Output

```
9
```

Subarray

```
5 1 3
```

---

### Brute Force

Check every subarray.

```
Time

O(n²)
```

---

### Sliding Window

```java
public static int maxSum(int[] arr,int k){

    int left = 0;
    int sum = 0;
    int max = Integer.MIN_VALUE;

    for(int right = 0; right < arr.length; right++){

        sum += arr[right];

        if(right - left + 1 > k){
            sum -= arr[left];
            left++;
        }

        if(right - left + 1 == k){
            max = Math.max(max,sum);
        }

    }

    return max;
}
```

---

### Dry Run

```
2 1 5 1 3 2

Window

2 1 5

Sum = 8

↓

1 5 1

Sum = 7

↓

5 1 3

Sum = 9

↓

1 3 2

Sum = 6

Answer = 9
```

---

Complexity

```
Time

O(n)

Space

O(1)
```

---

# Pattern 2

## Maximum Average Subarray I

LeetCode 643

Same template.

Only divide answer by K.

---

# Pattern 3

## Longest Substring Without Repeating Characters

LeetCode 3

Observation

Need unique characters.

Use

```
HashSet
```

Java

```java
public int lengthOfLongestSubstring(String s){

    HashSet<Character> set = new HashSet<>();

    int left = 0;

    int answer = 0;

    for(int right=0;right<s.length();right++){

        while(set.contains(s.charAt(right))){

            set.remove(s.charAt(left));

            left++;

        }

        set.add(s.charAt(right));

        answer = Math.max(answer,right-left+1);

    }

    return answer;

}
```

---

Dry Run

```
abcabcbb

abc

Length = 3

Next

a

Duplicate

Remove

a

Continue
```

---

Complexity

```
Time

O(n)

Space

O(26)
```

---

# Pattern 4

## Minimum Size Subarray Sum

LeetCode 209

Observation

Need

```
Shrink

Until

Sum < Target
```

Java

```java
public int minSubArrayLen(int target,int[] nums){

    int left = 0;

    int sum = 0;

    int answer = Integer.MAX_VALUE;

    for(int right=0;right<nums.length;right++){

        sum+=nums[right];

        while(sum>=target){

            answer=Math.min(answer,right-left+1);

            sum-=nums[left];

            left++;

        }

    }

    return answer==Integer.MAX_VALUE?0:answer;

}
```

---

# Pattern 5

## Longest Repeating Character Replacement

LeetCode 424

Observation

Keep track of

```
Maximum Frequency
```

Shrink if

```
Window Size

-

Maximum Frequency

>

K
```

---

# Pattern 6

## Max Consecutive Ones III

LeetCode 1004

Observation

Count

```
Zeros
```

Shrink while

```
Zeros > K
```

---

# Pattern 7

## Fruits Into Baskets

LeetCode 904

Observation

Maintain

```
HashMap

Size <= 2
```

---

# Pattern 8

## Minimum Window Substring

LeetCode 76

One of the hardest Sliding Window problems.

Need

```
Frequency Map

+

Matched Count

+

Shrink Window
```

---

# Generic Fixed Window

```java
left = 0

Expand

↓

Window Size == K

↓

Update Answer

↓

Remove Left

↓

Continue
```

---

# Generic Variable Window

```java
Expand

↓

Condition True

↓

Shrink

↓

Update Answer

↓

Continue
```

---

# Dry Run Template

```
Array

2 1 5 1 3

L

R

↓

Expand

↓

Window

↓

Condition

↓

Shrink

↓

Answer
```

---

# Pattern Recognition

If the question contains

- Contiguous
- Longest
- Smallest
- Maximum
- Minimum
- Subarray
- Substring
- Exactly K
- At Most K

Think

```
Sliding Window
```

---

# Common Mistakes

## Mistake 1

Updating answer before shrinking.

Wrong order.

---

## Mistake 2

Forgetting to remove left element.

---

## Mistake 3

Wrong window size.

```
right-left+1
```

NOT

```
right-left
```

---

## Mistake 4

Using Sliding Window when negative numbers are involved.

Variable Sliding Window usually works only when expanding the window cannot decrease the sum (e.g., all positive numbers). For arrays with negative numbers, consider Prefix Sum or other techniques.

---

# Complexity

| Pattern | Time | Space |
|----------|------|-------|
| Fixed Window | O(n) | O(1) |
| Variable Window | O(n) | O(1) |
| HashSet Window | O(n) | O(n) |
| HashMap Window | O(n) | O(n) |

---

# Interview Tips

Ask yourself

- Is the array contiguous?
- Is the question asking for the longest or shortest subarray/substring?
- Is there a fixed window size?
- Can I expand and shrink the window?

If yes

Think

```
Sliding Window
```

---

# Practice Problems

## Easy

- LeetCode 643 – Maximum Average Subarray I
- LeetCode 1456 – Maximum Number of Vowels in a Substring
- LeetCode 2379 – Minimum Recolors to Get K Consecutive Black Blocks

## Medium

- LeetCode 3 – Longest Substring Without Repeating Characters
- LeetCode 209 – Minimum Size Subarray Sum
- LeetCode 424 – Longest Repeating Character Replacement
- LeetCode 904 – Fruits Into Baskets
- LeetCode 1004 – Max Consecutive Ones III
- LeetCode 1493 – Longest Subarray of 1's After Deleting One Element
- LeetCode 567 – Permutation in String

## Hard

- LeetCode 76 – Minimum Window Substring
- LeetCode 30 – Substring with Concatenation of All Words

---

# Sliding Window Decision Tree

```
Problem

↓

Contiguous?

↓

Yes

↓

Fixed Size?

↓

Yes

↓

Fixed Sliding Window

↓

No

↓

Longest / Smallest?

↓

Yes

↓

Variable Sliding Window

↓

Need Frequency?

↓

HashMap / HashSet

↓

Need Target Sum?

↓

Sliding Window (positive numbers)
or Prefix Sum (if negatives exist)
```

---

# Summary

✅ Sliding Window optimizes many **O(n²)** subarray and substring problems to **O(n)**.

✅ Use a **Fixed Window** when the window size is known.

✅ Use a **Variable Window** when the window size changes based on a condition.

✅ Master the following interview patterns:
- Fixed Window
- Variable Window
- HashSet Window
- HashMap Window
- Frequency Count Window
- Minimum Window
- Longest Window