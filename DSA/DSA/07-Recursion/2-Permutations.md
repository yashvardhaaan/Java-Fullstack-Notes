# Recursion — Permutations in Java

Permutations are one of the most important applications of recursion.

They are also the point where recursion starts becoming **backtracking**.

Before solving permutations, make sure you understand:

* Base cases
* Recursive calls
* Call stack
* Arrays / strings
* The difference between work done **before** and **after** recursion

---

# 1. What Is a Permutation?

A permutation is an arrangement of elements where **order matters**.

For example:

```text
[1, 2, 3]
```

Its permutations are:

```text
123
132
213
231
312
321
```

There are:

```text
3! = 6
```

permutations.

---

# 2. Permutation vs Combination

This distinction is extremely important.

## Permutation

Order matters.

```text
ABC
ACB
```

These are different permutations.

---

## Combination

Order does not matter.

Choosing:

```text
A, B
```

is the same as:

```text
B, A
```

So:

```text
Permutation → order matters

Combination → order does not matter
```

---

# 3. How Many Permutations Exist?

For `n` distinct elements:

```text
n!
```

permutations exist.

For example:

```text
1 element → 1! = 1
2 elements → 2! = 2
3 elements → 3! = 6
4 elements → 4! = 24
5 elements → 5! = 120
```

Why?

For:

```text
[1, 2, 3]
```

we have:

```text
Position 1 → 3 choices
Position 2 → 2 choices
Position 3 → 1 choice
```

Therefore:

```text
3 × 2 × 1 = 6
```

---

# 4. The Main Recursion Idea

Suppose we have:

```text
[1, 2, 3]
```

We need to decide:

> Which element should go at the current position?

For the first position:

```text
1
2
3
```

are all possible choices.

If we choose `1`:

```text
1 _ _
```

Now the remaining choices are:

```text
2
3
```

Choose `2`:

```text
1 2 _
```

Then:

```text
1 2 3
```

We found one permutation.

Now we need to go back and try another choice:

```text
1 3 2
```

Then return further back:

```text
2 1 3
2 3 1
3 1 2
3 2 1
```

This **go → explore → undo → try another choice** pattern is the foundation of backtracking.

---

# 5. Visualizing the Recursion Tree

For:

```text
[1, 2, 3]
```

the recursion tree looks like:

```text
                         []
              /           |           \
             1            2            3
           /   \        /   \        /   \
         12    13      21    23      31    32
         |      |      |      |      |      |
        123    132    213    231    312    321
```

Every path from the root to a leaf is one permutation.

---

# 6. The Important Question

When solving permutations, ask:

> What does the current recursive function represent?

A very useful interpretation is:

```text
permute(index)
```

means:

> "I need to decide which element should be placed at `index`."

For example:

```text
permute(0)
```

means:

> Decide the element at position `0`.

Then:

```text
permute(1)
```

means:

> Position `0` is already decided. Now decide position `1`.

Then:

```text
permute(2)
```

means:

> Positions `0` and `1` are already decided. Now decide position `2`.

---

# 7. The Swap-Based Approach

One of the cleanest ways to generate permutations in Java is by using **swapping**.

Suppose:

```text
[1, 2, 3]
```

At index `0`, we can put:

```text
1
2
3
```

We achieve this by swapping.

---

# 8. Basic Java Code

```java
import java.util.*;

public class Permutations {

    public static void generate(int[] arr, int index) {

        // Base case
        if (index == arr.length) {
            System.out.println(Arrays.toString(arr));
            return;
        }

        // Try every possible element at current index
        for (int i = index; i < arr.length; i++) {

            // Choose
            swap(arr, index, i);

            // Explore
            generate(arr, index + 1);

            // Undo
            swap(arr, index, i);
        }
    }

    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }

    public static void main(String[] args) {

        int[] arr = {1, 2, 3};

        generate(arr, 0);
    }
}
```

---

# 9. Understand the Three Most Important Lines

These three lines are the heart of the algorithm:

```java
swap(arr, index, i);

generate(arr, index + 1);

swap(arr, index, i);
```

They represent:

```text
Choose
  ↓
Explore
  ↓
Undo
```

This is the basic structure of backtracking.

---

# 10. Why Do We Swap?

Consider:

```text
[1, 2, 3]
```

At:

```text
index = 0
```

we want to try every element at position `0`.

### Choice 1

Swap index `0` with index `0`:

```text
[1, 2, 3]
```

Then recursively solve:

```text
index = 1
```

---

### Choice 2

Swap index `0` with index `1`:

```text
[2, 1, 3]
```

Now recursively solve:

```text
index = 1
```

---

### Choice 3

Swap index `0` with index `2`:

```text
[3, 2, 1]
```

Now recursively solve:

```text
index = 1
```

So swapping allows us to put every possible element at the current position.

---

# 11. Complete Dry Run

Let's understand:

```java
generate([1, 2, 3], 0);
```

---

## Step 1 — index = 0

Array:

```text
[1, 2, 3]
```

Loop:

```text
i = 0
i = 1
i = 2
```

---

## Choice 1 — i = 0

Swap:

```text
swap(0, 0)
```

Array remains:

```text
[1, 2, 3]
```

Call:

```text
generate(1)
```

---

## Step 2 — index = 1

Current array:

```text
[1, 2, 3]
```

Now we can choose:

```text
2
3
```

---

### Choose 2

Swap:

```text
swap(1, 1)
```

Array:

```text
[1, 2, 3]
```

Call:

```text
generate(2)
```

---

## Step 3 — index = 2

Only one element remains.

Swap:

```text
swap(2, 2)
```

Array:

```text
[1, 2, 3]
```

Call:

```text
generate(3)
```

---

# 12. Base Case

Now:

```text
index == arr.length
```

That means:

```text
index == 3
```

The entire array has been decided.

Therefore:

```java
System.out.println(Arrays.toString(arr));
```

prints:

```text
[1, 2, 3]
```

Then the function returns.

---

# 13. The Undo Step

This is extremely important.

After returning from:

```java
generate(arr, index + 1);
```

we execute:

```java
swap(arr, index, i);
```

Why?

Because we need to restore the array to its previous state.

This is called **backtracking**.

---

# 14. Why Is Undo Necessary?

Suppose we have:

```text
[1, 2, 3]
```

We choose:

```text
1
```

Then choose:

```text
2
```

We get:

```text
[1, 2, 3]
```

and eventually produce:

```text
123
```

Now we want:

```text
132
```

We need to return to:

```text
[1, 2, 3]
```

and change the second choice.

Without undoing the previous change, our next choice would be based on the wrong state.

Therefore:

```text
Choose
 ↓
Explore
 ↓
Undo
 ↓
Choose another
```

---

# 15. The Complete Tree With State

Think about the algorithm like this:

```text
                         []
                          |
               Choose 1, 2, or 3
                 /       |       \
                1        2        3
              /   \    /   \    /   \
             12   13  21   23  31   32
             |     |   |    |   |    |
            123   132 213  231 312  321
```

Each node represents the current state of the array.

---

# 16. The Call Stack

For:

```text
generate([1,2,3], 0)
```

one path might look like:

```text
generate([1,2,3], 0)
        ↓
generate([1,2,3], 1)
        ↓
generate([1,2,3], 2)
        ↓
generate([1,2,3], 3)
```

At:

```text
index = 3
```

we print the permutation.

Then:

```text
generate(3)
```

returns to:

```text
generate(2)
```

Then the loop at `index = 2` continues.

Eventually:

```text
generate(2)
```

returns to:

```text
generate(1)
```

and so on.

---

# 17. Why the Loop Starts at `index`

Notice:

```java
for (int i = index; i < arr.length; i++)
```

not:

```java
for (int i = 0; i < arr.length; i++)
```

Why?

Because positions before `index` are already fixed.

Example:

```text
[2, 1, 3]
```

If:

```text
index = 2
```

then:

```text
position 0 → already decided
position 1 → already decided
position 2 → needs to be decided
```

Therefore we only consider:

```text
i = 2
```

---

# 18. Another Way to Think About `index`

At every recursive level:

```text
index = position currently being filled
```

For:

```text
[1,2,3,4]
```

we have:

```text
index 0 → choose first position
index 1 → choose second position
index 2 → choose third position
index 3 → choose fourth position
index 4 → permutation complete
```

This interpretation is very important.

---

# 19. String Permutations

The same idea can be applied to strings.

For example:

```text
ABC
```

Expected:

```text
ABC
ACB
BAC
BCA
CBA
CAB
```

One simple approach is to convert the string into a character array.

```java
import java.util.*;

public class StringPermutations {

    public static void generate(char[] chars, int index) {

        if (index == chars.length) {
            System.out.println(new String(chars));
            return;
        }

        for (int i = index; i < chars.length; i++) {

            swap(chars, index, i);

            generate(chars, index + 1);

            swap(chars, index, i);
        }
    }

    private static void swap(char[] chars, int i, int j) {
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
    }

    public static void main(String[] args) {

        char[] chars = {'A', 'B', 'C'};

        generate(chars, 0);
    }
}
```

---

# 20. Storing the Permutations

Instead of printing each permutation, we often need to return them.

For example, on coding platforms:

```text
Input:
[1,2,3]

Output:
[
 [1,2,3],
 [1,3,2],
 [2,1,3],
 [2,3,1],
 [3,1,2],
 [3,2,1]
]
```

Java:

```java
import java.util.*;

public class Solution {

    public List<List<Integer>> permute(int[] nums) {

        List<List<Integer>> result = new ArrayList<>();

        generate(nums, 0, result);

        return result;
    }

    private void generate(
            int[] nums,
            int index,
            List<List<Integer>> result) {

        if (index == nums.length) {

            List<Integer> permutation = new ArrayList<>();

            for (int num : nums) {
                permutation.add(num);
            }

            result.add(permutation);

            return;
        }

        for (int i = index; i < nums.length; i++) {

            swap(nums, index, i);

            generate(nums, index + 1, result);

            swap(nums, index, i);
        }
    }

    private void swap(int[] nums, int i, int j) {

        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}
```

---

# 21. Why Do We Copy the Array?

This is a very important Java concept.

We do:

```java
List<Integer> permutation = new ArrayList<>();
```

and copy the elements.

We **cannot simply store the same mutable array reference** every time.

The array keeps changing because of:

```java
swap(...)
```

If we store the same reference repeatedly, the final result can contain repeated copies of the final state.

Therefore we store a snapshot:

```java
result.add(permutation);
```

---

# 22. Time Complexity

There are:

```text
n!
```

permutations.

For every permutation, we copy `n` elements.

Therefore:

```text
Time = O(n × n!)
```

for the version that stores each permutation.

The recursion tree itself has approximately:

```text
n!
```

leaves.

---

# 23. Space Complexity

Ignoring the output:

```text
Recursion stack = O(n)
```

because the maximum recursion depth is:

```text
n
```

But the output itself contains:

```text
n! permutations
```

and each permutation has `n` elements.

Therefore output space is:

```text
O(n × n!)
```

---

# 24. What If There Are Duplicate Elements?

Consider:

```text
[1, 1, 2]
```

If we use the basic swap algorithm, we can generate duplicate permutations.

For example:

```text
112
112
121
121
211
211
```

But the unique answer should be:

```text
112
121
211
```

So duplicate handling becomes important.

---

# 25. Handling Duplicates

A common approach is:

1. Sort the array.
2. At each recursion level, avoid choosing the same value more than once.

A different implementation uses a `Set` at each recursion level.

Example:

```java
Set<Integer> used = new HashSet<>();

for (int i = index; i < nums.length; i++) {

    if (used.contains(nums[i])) {
        continue;
    }

    used.add(nums[i]);

    swap(nums, index, i);

    generate(nums, index + 1);

    swap(nums, index, i);
}
```

The important idea is:

> At the same recursion level, don't make the same choice twice.

---

# 26. Recursion Level vs Loop

This distinction is critical.

Consider:

```java
for (int i = index; i < nums.length; i++) {
    swap(nums, index, i);
    generate(nums, index + 1);
    swap(nums, index, i);
}
```

The:

```java
for
```

represents the **choices available at the current level**.

The:

```java
generate(...)
```

moves to the **next level**.

So:

```text
Loop
 ↓
Different choices at current level

Recursive call
 ↓
Move deeper
```

This pattern appears everywhere in backtracking.

---

# 27. The Universal Backtracking Pattern

You should memorize the **concept**, not the exact code.

```java
void backtrack(state) {

    if (baseCase) {
        saveAnswer();
        return;
    }

    for (choice : choices) {

        // Choose
        makeChoice(choice);

        // Explore
        backtrack(nextState);

        // Undo
        undoChoice(choice);
    }
}
```

For permutations:

```text
Choose → swap
Explore → recursive call
Undo → swap back
```

For subsets:

```text
Choose → add element
Explore → recursive call
Undo → remove element
```

For N-Queens:

```text
Choose → place queen
Explore → recursive call
Undo → remove queen
```

For Sudoku:

```text
Choose → place number
Explore → recursive call
Undo → remove number
```

The underlying idea is the same.

---

# 28. Common Mistakes

## Mistake 1 — Forgetting the Undo

Wrong:

```java
swap(nums, index, i);

generate(nums, index + 1);

// Missing undo
```

Correct:

```java
swap(nums, index, i);

generate(nums, index + 1);

swap(nums, index, i);
```

---

## Mistake 2 — Wrong Base Case

Wrong:

```java
if (index == nums.length - 1)
```

This can be confusing because the final position has not necessarily been processed.

A clean version is:

```java
if (index == nums.length)
```

meaning:

> Every position has been decided.

---

## Mistake 3 — Not Understanding What `index` Means

Don't think:

> "`index` is just some variable."

Think:

> "`index` tells me which position I am currently filling."

---

## Mistake 4 — Modifying the Array Without Restoring It

Remember:

```text
Modify
 ↓
Recursive call
 ↓
Restore
```

The recursive call may completely change the array.

The parent call needs its original state back before trying the next choice.

---

# 29. Permutation Problem-Solving Template

When you see:

> Generate all arrangements of the elements.

Think:

```text
Permutation
   ↓
Order matters
   ↓
Every position needs a choice
   ↓
Recursion
   ↓
Try every possible choice
   ↓
Backtrack
```

Then think:

```java
for (int i = index; i < n; i++) {

    swap(...);

    recursiveCall(...);

    swap(...);
}
```

---

# 30. Practice Problems

Solve these without looking at the solution.

### Beginner

* [ ] Generate all permutations of `[1, 2, 3]`
* [ ] Generate permutations of a string `"ABC"`
* [ ] Count the number of permutations
* [ ] Generate permutations of `[1, 2, 3, 4]`

### Intermediate

* [ ] Return permutations instead of printing them
* [ ] Generate unique permutations
* [ ] Generate permutations containing duplicate elements
* [ ] Find the kth permutation sequence

### LeetCode-style

* [ ] Permutations
* [ ] Permutations II
* [ ] Next Permutation
* [ ] K-th Permutation

---

# 31. What You Should Understand Before Moving On

You should be able to explain this code without memorizing it:

```java
for (int i = index; i < nums.length; i++) {

    swap(nums, index, i);

    generate(nums, index + 1);

    swap(nums, index, i);
}
```

Explain it as:

```text
for every possible choice at this position:

    make the choice

    recursively solve the remaining positions

    undo the choice
```

If you understand that sentence, you understand the core of permutation recursion.

---

# 32. The Mental Model

Remember this:

```text
                    PERMUTATION
                         |
                Which element
                goes here?
                         |
              ┌──────────┼──────────┐
              ↓          ↓          ↓
             1           2          3
             |           |          |
          decide      decide     decide
          next        next       next
             |           |          |
           ...         ...        ...
             |
           complete
             |
          SAVE ANSWER
             |
          BACKTRACK
             |
       TRY NEXT CHOICE
```

The most important sequence is:

```text
        CHOOSE
           ↓
        EXPLORE
           ↓
          UNDO
           ↓
      NEXT CHOICE
```

This is the bridge between **recursion** and **backtracking**.

Once this pattern becomes comfortable, the next topics—**combinations and subsets**—will be much easier because they use the same recursion tree but with different rules for making choices.
