# Recursion — Practice Problems in Java

This file is for practicing recursion **after understanding the basics**.

The goal is not to memorize solutions. For every problem, ask:

1. What is changing in every recursive call?
2. What should be the base case?
3. What is the smallest version of the problem?
4. What should the current function do?
5. What should the recursive call handle?

---

# 1. Print Numbers from 1 to N

### Problem

Given `N`, print numbers from `1` to `N` using recursion.

### Example

```text
Input: 5

Output:
1 2 3 4 5
```

### Java

```java
public static void printIncreasing(int n) {
    if (n == 0) {
        return;
    }

    printIncreasing(n - 1);
    System.out.print(n + " ");
}
```

### Dry Run

For:

```java
printIncreasing(3);
```

The calls happen like this:

```text
printIncreasing(3)
    ↓
printIncreasing(2)
    ↓
printIncreasing(1)
    ↓
printIncreasing(0)
```

Now the calls return:

```text
printIncreasing(0) → return
printIncreasing(1) → print 1
printIncreasing(2) → print 2
printIncreasing(3) → print 3
```

Therefore:

```text
1 2 3
```

### Important Idea

The position of the `print` statement matters.

```java
printIncreasing(n - 1);
System.out.print(n);
```

prints during the **returning phase**.

---

# 2. Print Numbers from N to 1

### Problem

Print numbers from `N` down to `1`.

### Example

```text
Input: 5

Output:
5 4 3 2 1
```

### Java

```java
public static void printDecreasing(int n) {
    if (n == 0) {
        return;
    }

    System.out.print(n + " ");
    printDecreasing(n - 1);
}
```

### Key Difference

Here we print **before** making the recursive call.

```java
System.out.print(n);
printDecreasing(n - 1);
```

---

# 3. Print 1 to N Without a Loop

This is one of the simplest problems for understanding **before-call vs after-call**.

```java
public static void print1ToN(int n) {
    if (n == 0) {
        return;
    }

    print1ToN(n - 1);
    System.out.print(n + " ");
}
```

For:

```text
n = 4
```

Think:

```text
Go down:
4 → 3 → 2 → 1 → 0

Come back:
0 → 1 → 2 → 3 → 4
```

Output:

```text
1 2 3 4
```

---

# 4. Factorial of N

### Problem

Calculate:

```text
n!
```

Mathematically:

```text
5! = 5 × 4 × 3 × 2 × 1
```

And:

```text
0! = 1
```

### Recursive Formula

```text
factorial(n) = n × factorial(n - 1)
```

### Java

```java
public static int factorial(int n) {
    if (n == 0) {
        return 1;
    }

    return n * factorial(n - 1);
}
```

### Dry Run

```java
factorial(4)
```

becomes:

```text
4 × factorial(3)
    ↓
4 × 3 × factorial(2)
        ↓
4 × 3 × 2 × factorial(1)
            ↓
4 × 3 × 2 × 1 × factorial(0)
```

Base case:

```text
factorial(0) = 1
```

Returning:

```text
1
1 × 1 = 1
2 × 1 = 2
3 × 2 = 6
4 × 6 = 24
```

Answer:

```text
24
```

### Complexity

```text
Time:  O(n)
Space: O(n)
```

Space is `O(n)` because of the recursive call stack.

---

# 5. Sum of First N Numbers

### Problem

Calculate:

```text
1 + 2 + 3 + ... + n
```

### Recursive Formula

```text
sum(n) = n + sum(n - 1)
```

### Java

```java
public static int sum(int n) {
    if (n == 0) {
        return 0;
    }

    return n + sum(n - 1);
}
```

### Example

```java
sum(5)
```

```text
5 + sum(4)
    ↓
5 + 4 + sum(3)
        ↓
5 + 4 + 3 + sum(2)
            ↓
5 + 4 + 3 + 2 + sum(1)
                ↓
5 + 4 + 3 + 2 + 1 + sum(0)
```

Therefore:

```text
15
```

---

# 6. Sum of Digits

### Problem

Find the sum of digits of a number.

```text
Input: 1234

Output: 10
```

### Idea

Take the last digit:

```text
1234 % 10 = 4
```

Remove the last digit:

```text
1234 / 10 = 123
```

Then recursively process `123`.

### Java

```java
public static int digitSum(int n) {
    if (n == 0) {
        return 0;
    }

    return (n % 10) + digitSum(n / 10);
}
```

### Dry Run

```text
digitSum(1234)

4 + digitSum(123)

4 + 3 + digitSum(12)

4 + 3 + 2 + digitSum(1)

4 + 3 + 2 + 1 + digitSum(0)

= 10
```

### Pattern

This introduces an important recursion technique:

```java
n % 10
n / 10
```

---

# 7. Count Digits

### Problem

Count the number of digits in an integer.

```text
Input: 12345

Output: 5
```

### Java

```java
public static int countDigits(int n) {
    if (n == 0) {
        return 0;
    }

    return 1 + countDigits(n / 10);
}
```

For:

```text
12345
```

the recursive calls are:

```text
12345
1234
123
12
1
0
```

Therefore:

```text
5
```

### Note

For this simple version, `n = 0` is treated as having zero digits.

If you want `0` itself to count as one digit, handle it separately.

---

# 8. Power of a Number

### Problem

Calculate:

```text
x^n
```

### Recursive Formula

```text
x^n = x × x^(n-1)
```

### Java

```java
public static int power(int x, int n) {
    if (n == 0) {
        return 1;
    }

    return x * power(x, n - 1);
}
```

### Example

```java
power(2, 5)
```

```text
2 × power(2, 4)
    ↓
2 × 2 × power(2, 3)
        ↓
2 × 2 × 2 × power(2, 2)
            ↓
2 × 2 × 2 × 2 × power(2, 1)
                ↓
2 × 2 × 2 × 2 × 2 × power(2, 0)
```

Answer:

```text
32
```

### Complexity

```text
Time:  O(n)
Space: O(n)
```

Later, you should learn **fast exponentiation**, which reduces the time to `O(log n)`.

---

# 9. Fibonacci Number

### Problem

Find the `n`th Fibonacci number.

The sequence is:

```text
0 1 1 2 3 5 8 13 ...
```

The formula is:

```text
F(n) = F(n - 1) + F(n - 2)
```

### Base Cases

```text
F(0) = 0
F(1) = 1
```

### Java

```java
public static int fibonacci(int n) {
    if (n == 0 || n == 1) {
        return n;
    }

    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

### Recursion Tree

For:

```java
fibonacci(4)
```

you get:

```text
             fib(4)
            /      \
        fib(3)     fib(2)
        /   \       /  \
     fib(2) fib(1) fib(1) fib(0)
     /   \
 fib(1) fib(0)
```

Notice something important:

```text
fib(2)
```

is calculated more than once.

This is called **overlapping subproblems**.

### Complexity

Naive recursive Fibonacci:

```text
Time:  O(2^n)
Space: O(n)
```

Later, you will learn how **memoization** and **dynamic programming** solve this inefficiency.

---

# 10. Reverse a String

### Problem

Reverse a string using recursion.

```text
Input:
"hello"

Output:
"olleh"
```

One simple approach is to recursively process the remaining substring.

```java
public static String reverse(String s) {
    if (s.length() <= 1) {
        return s;
    }

    return reverse(s.substring(1)) + s.charAt(0);
}
```

### Dry Run

```text
reverse("abc")

reverse("bc") + 'a'

(reverse("c") + 'b') + 'a'

"c" + "b" + "a"

"cba"
```

### Important

This solution is useful for understanding recursion, but repeated `substring()` and string concatenation can make it inefficient.

Later, you should learn the **two-pointer recursive approach**.

---

# 11. Check if an Array is Sorted

### Problem

Determine whether an array is sorted in increasing order.

```text
[1, 2, 3, 4, 5] → true

[1, 3, 2, 4] → false
```

### Java

```java
public static boolean isSorted(int[] arr, int index) {
    if (index == arr.length - 1) {
        return true;
    }

    if (arr[index] > arr[index + 1]) {
        return false;
    }

    return isSorted(arr, index + 1);
}
```

Call:

```java
isSorted(arr, 0);
```

### Key Idea

We only compare:

```text
arr[index]
arr[index + 1]
```

Then let recursion handle the remaining array.

This is a very important recursive pattern:

```text
Solve the current part
+
Ask recursion to solve the remaining part
```

---

# 12. Find Maximum in an Array

### Problem

Find the maximum element recursively.

```text
Input:
[4, 7, 2, 9, 1]

Output:
9
```

### Java

```java
public static int findMax(int[] arr, int index) {
    if (index == arr.length - 1) {
        return arr[index];
    }

    int maxOfRest = findMax(arr, index + 1);

    return Math.max(arr[index], maxOfRest);
}
```

### Thinking

Don't think:

> "How do I find the maximum of the entire array?"

Think:

> "If recursion gives me the maximum of the rest of the array, how can I determine the maximum including my current element?"

That gives:

```java
Math.max(arr[index], maxOfRest);
```

This is a fundamental recursion mindset.

---

# 13. Linear Search Using Recursion

### Problem

Find whether a target exists in an array.

```text
Input:
arr = [4, 8, 2, 9, 5]
target = 9

Output:
true
```

### Java

```java
public static boolean search(int[] arr, int index, int target) {
    if (index == arr.length) {
        return false;
    }

    if (arr[index] == target) {
        return true;
    }

    return search(arr, index + 1, target);
}
```

### Structure

```text
Check current element
        ↓
Found?
  ↓ yes → return true
  ↓ no
Move to next index
        ↓
Recursive call
```

---

# 14. Count Occurrences of an Element

### Problem

Count how many times a target occurs.

```text
Input:
[2, 4, 2, 2, 7]
target = 2

Output:
3
```

### Java

```java
public static int countOccurrences(
        int[] arr,
        int index,
        int target) {

    if (index == arr.length) {
        return 0;
    }

    int count = countOccurrences(arr, index + 1, target);

    if (arr[index] == target) {
        count++;
    }

    return count;
}
```

---

# 15. Recursive Binary Search

Once you understand recursion on arrays, learn binary search recursively.

### Java

```java
public static int binarySearch(
        int[] arr,
        int left,
        int right,
        int target) {

    if (left > right) {
        return -1;
    }

    int mid = left + (right - left) / 2;

    if (arr[mid] == target) {
        return mid;
    }

    if (target < arr[mid]) {
        return binarySearch(arr, left, mid - 1, target);
    }

    return binarySearch(arr, mid + 1, right, target);
}
```

### Key Idea

Every call reduces the search space:

```text
Entire array
      ↓
Left half OR right half
      ↓
Smaller half
      ↓
Smaller half
```

### Complexity

```text
Time:  O(log n)
Space: O(log n)
```

---

# 16. The Most Important Recursion Pattern

When solving recursion problems, try to write this structure first:

```java
public static ReturnType solve(parameters) {

    // 1. Base case
    if (condition) {
        return answer;
    }

    // 2. Do something with current state

    // 3. Recursive call
    ReturnType result = solve(smallerProblem);

    // 4. Combine current work + recursive result

    return result;
}
```

Not every recursion problem has exactly this structure, but it is an excellent starting template.

---

# 17. Before vs After Recursive Call

This is one of the **most important concepts** to understand.

## Work Before Recursion

```java
System.out.println(n);
solve(n - 1);
```

Output:

```text
n
n-1
n-2
...
```

The work happens while going **down the recursion**.

---

## Work After Recursion

```java
solve(n - 1);
System.out.println(n);
```

Output:

```text
1
2
3
...
n
```

The work happens while coming **back up the recursion**.

---

# 18. Recursion Has Two Phases

Always visualize recursion as:

```text
                CALLING
                  ↓
        ┌──────────────────┐
        │ solve(n)         │
        │      ↓           │
        │ solve(n-1)       │
        │      ↓           │
        │ solve(n-2)       │
        │      ↓           │
        │   BASE CASE      │
        └──────────────────┘
                  ↓
               RETURNING
                  ↑
        solve(n-2) returns
                  ↑
        solve(n-1) returns
                  ↑
        solve(n) returns
```

This becomes extremely important in:

* Permutations
* Combinations
* Subsets
* Backtracking
* N-Queens
* Sudoku
* Tree recursion
* Dynamic Programming

---

# 19. Common Mistakes

## Mistake 1 — No Base Case

Wrong:

```java
public static void fun(int n) {
    System.out.println(n);
    fun(n - 1);
}
```

This eventually causes:

```text
StackOverflowError
```

---

## Mistake 2 — Problem Does Not Get Smaller

Wrong:

```java
fun(n);
```

inside:

```java
fun(n)
```

The state never changes.

Usually you need something like:

```java
fun(n - 1);
```

or:

```java
fun(index + 1);
```

---

## Mistake 3 — Wrong Base Case

Always ask:

> What is the smallest valid input?

Examples:

```text
factorial → n == 0
sum       → n == 0
array     → index == arr.length
binary search → left > right
```

---

## Mistake 4 — Forgetting the Return Value

Wrong:

```java
public static int sum(int n) {
    if (n == 0) {
        return 0;
    }

    sum(n - 1);
}
```

The recursive result is lost.

Correct:

```java
return n + sum(n - 1);
```

---

# 20. How to Approach Any Recursion Problem

Use this checklist.

### Step 1 — Identify the changing variable

Examples:

```text
n
index
left/right
remaining characters
remaining choices
```

---

### Step 2 — Find the smallest problem

Ask:

> When can I answer immediately?

That becomes your base case.

---

### Step 3 — Reduce the problem

Examples:

```java
n - 1
index + 1
right - 1
left + 1
```

---

### Step 4 — Trust the recursive call

This is extremely important.

Don't mentally solve every recursive call.

For example:

```java
int maxOfRest = findMax(arr, index + 1);
```

Think:

> "I trust this function to give me the maximum of the remaining array."

Then solve only the current problem.

---

### Step 5 — Combine the answer

For example:

```java
return Math.max(arr[index], maxOfRest);
```

---

# 21. Practice Order

Solve these yourself in this order:

### Level 1 — Basic

* [ ] Print `N` to `1`
* [ ] Print `1` to `N`
* [ ] Factorial
* [ ] Sum of first `N` numbers
* [ ] Power
* [ ] Fibonacci

### Level 2 — Numbers

* [ ] Count digits
* [ ] Sum of digits
* [ ] Product of digits
* [ ] Reverse a number
* [ ] Check palindrome number

### Level 3 — Strings

* [ ] Reverse a string
* [ ] Check palindrome string
* [ ] Count a character
* [ ] Remove a character
* [ ] Replace a character

### Level 4 — Arrays

* [ ] Check if array is sorted
* [ ] Find maximum
* [ ] Find minimum
* [ ] Linear search
* [ ] Count occurrences
* [ ] Find first occurrence
* [ ] Find last occurrence

### Level 5 — Important

* [ ] Recursive binary search
* [ ] Fast exponentiation
* [ ] Tower of Hanoi
* [ ] Generate all subsequences

The last category starts preparing you for:

```text
Subsets
   ↓
Combinations
   ↓
Permutations
   ↓
Backtracking
```

---

# 22. The One Rule to Remember

When recursion feels confusing, don't try to understand **all recursive calls simultaneously**.

Instead ask:

```text
What is my current problem?
        ↓
What is the smallest problem?
        ↓
What should I do now?
        ↓
What smaller problem can recursion solve?
        ↓
How do I use its answer?
```

The most important mental model is:

> **Recursion = solve one small part + trust recursion to solve the remaining part.**

Once this becomes natural, backtracking becomes much easier.

---

# 23. What You Should Be Able to Do Before Moving On

Before studying `Permutations.md`, you should be comfortable writing these without looking at the solution:

```java
factorial(n)

sum(n)

power(x, n)

fibonacci(n)

digitSum(n)

isSorted(arr, index)

findMax(arr, index)

search(arr, index, target)

binarySearch(arr, left, right, target)
```

More importantly, you should be able to explain:

```text
1. What is the base case?
2. What changes in every call?
3. Where does the recursion stop?
4. What happens while going down?
5. What happens while coming back?
6. What is stored in the call stack?
7. Why does the recursive result give the correct answer?
```

If you can answer those questions, you are ready for the next stage:

```text
Recursion
   ↓
Subsets
   ↓
Combinations
   ↓
Permutations
   ↓
Backtracking
```
