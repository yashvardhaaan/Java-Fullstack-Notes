# Recursion — Subsets in Java

Subsets are one of the most important recursion and backtracking patterns.

They help you understand a very powerful idea:

> **At every element, you usually have two choices: take it or don't take it.**

Once you understand this properly, many problems become easier:

* Subsets
* Subsequences
* Combination Sum
* Partitioning
* Binary decision recursion
* Backtracking
* Dynamic Programming

---

# 1. What Is a Subset?

Suppose we have:

```text
[1, 2, 3]
```

A subset is any selection of these elements.

The subsets are:

```text
[]
[1]
[2]
[3]
[1,2]
[1,3]
[2,3]
[1,2,3]
```

Notice that the empty subset:

```text
[]
```

is also a valid subset.

---

# 2. How Many Subsets Exist?

For `n` elements, there are:

```text
2^n
```

subsets.

For example:

```text
n = 0 → 1 subset
n = 1 → 2 subsets
n = 2 → 4 subsets
n = 3 → 8 subsets
n = 4 → 16 subsets
n = 5 → 32 subsets
```

Why?

Because for every element we have exactly two choices:

```text
Take it
Don't take it
```

Therefore:

```text
2 × 2 × 2 × ... × 2
```

`n` times gives:

```text
2^n
```

---

# 3. The Most Important Idea

Consider:

```text
[1, 2, 3]
```

At `1`, we have two choices:

```text
Take 1
Don't take 1
```

If we take `1`:

```text
[1]
```

then for `2`:

```text
Take 2
Don't take 2
```

If we don't take `1`:

```text
[]
```

we still have:

```text
Take 2
Don't take 2
```

So every element creates two branches.

---

# 4. Decision Tree

For:

```text
[1, 2, 3]
```

the recursion tree looks like:

```text
                         []
                       /    \
                    take    skip
                     1        1
                    /          \
                  [1]           []
                 /   \         /  \
              take  skip    take  skip
               2      2       2      2
              /        \     /        \
           [1,2]       [1]  [2]        []
            /  \       / \   / \       / \
           3    -     3   - 3   -     3   -
```

The leaves become:

```text
[1,2,3]
[1,2]
[1,3]
[1]
[2,3]
[2]
[3]
[]
```

The order may differ depending on implementation.

The important thing is that every element is either:

```text
included
```

or:

```text
excluded
```

---

# 5. The Core Recursion Function

A useful mental model is:

```java
generate(index, current)
```

means:

> "I have already made decisions for elements before `index`. Now I need to decide what to do with `index`."

For example:

```text
index = 0
```

means:

```text
Decide about arr[0]
```

Then:

```text
index = 1
```

means:

```text
Decide about arr[1]
```

and so on.

---

# 6. Basic Recursive Solution

```java
import java.util.*;

public class Subsets {

    public static List<List<Integer>> subsets(int[] nums) {

        List<List<Integer>> result = new ArrayList<>();

        generate(
                nums,
                0,
                new ArrayList<>(),
                result
        );

        return result;
    }

    private static void generate(
            int[] nums,
            int index,
            List<Integer> current,
            List<List<Integer>> result) {

        // Base case
        if (index == nums.length) {
            result.add(new ArrayList<>(current));
            return;
        }

        // Choice 1: Include nums[index]
        current.add(nums[index]);

        generate(
                nums,
                index + 1,
                current,
                result
        );

        // Undo
        current.remove(current.size() - 1);

        // Choice 2: Exclude nums[index]
        generate(
                nums,
                index + 1,
                current,
                result
        );
    }
}
```

This is one of the most important recursion templates you should understand.

---

# 7. The Two Choices

The heart of the code is:

```java
current.add(nums[index]);

generate(nums, index + 1, current, result);

current.remove(current.size() - 1);

generate(nums, index + 1, current, result);
```

There are two branches.

### Branch 1

Include:

```text
nums[index]
```

### Branch 2

Don't include:

```text
nums[index]
```

So:

```text
                 element
                    |
             ┌──────┴──────┐
             ↓             ↓
           INCLUDE       EXCLUDE
```

This is called **binary decision recursion**.

---

# 8. Why Is the Base Case `index == nums.length`?

Suppose:

```text
nums = [1,2,3]
```

The indices are:

```text
0
1
2
```

When:

```text
index == 3
```

there are no elements left.

Therefore:

```text
index == nums.length
```

means:

> "I have made a decision about every element."

At that point:

```java
result.add(new ArrayList<>(current));
```

saves the current subset.

---

# 9. Complete Dry Run

Let's run:

```java
subsets(new int[]{1, 2, 3});
```

Start:

```text
current = []
index = 0
```

We are deciding about:

```text
1
```

---

## Choice 1 — Include 1

```text
current = [1]
```

Move to:

```text
index = 1
```

Now decide about:

```text
2
```

---

## Include 2

```text
current = [1,2]
```

Move to:

```text
index = 2
```

Decide about:

```text
3
```

---

## Include 3

```text
current = [1,2,3]
```

Move to:

```text
index = 3
```

Base case.

Save:

```text
[1,2,3]
```

---

## Backtrack

Remove `3`:

```text
[1,2]
```

Now choose the other branch:

```text
Don't include 3
```

Move to base case.

Save:

```text
[1,2]
```

---

## Backtrack Again

Return to:

```text
[1]
```

Now we need to make the other choice for `2`.

Don't include `2`.

```text
[1]
```

Then decide about `3`.

Include `3`:

```text
[1,3]
```

Save.

Then don't include `3`:

```text
[1]
```

Save.

So under the choice:

```text
Include 1
```

we get:

```text
[1,2,3]
[1,2]
[1,3]
[1]
```

---

# 10. Now Exclude 1

Eventually we backtrack all the way to:

```text
[]
```

We now choose:

```text
Don't include 1
```

So:

```text
current = []
```

Then we make the same decisions for `2` and `3`.

We get:

```text
[2,3]
[2]
[3]
[]
```

Therefore all eight subsets are generated.

---

# 11. The Full Tree

A cleaner representation:

```text
                            []
                         /      \
                      +1        skip 1
                      /            \
                    [1]             []
                  /    \          /    \
               +2      skip 2   +2     skip 2
               /          \      /        \
           [1,2]          [1]   [2]        []
           /   \          / \   / \       / \
         +3   skip      +3 skip +3 skip  +3 skip
         /       \       / \    / \       / \
     [1,2,3]   [1,2] [1,3] [1] [2,3] [2] [3] []
```

Every leaf is one subset.

---

# 12. Why Do We Need `remove()`?

This line:

```java
current.remove(current.size() - 1);
```

is the undo operation.

Suppose:

```text
current = [1,2]
```

We choose `3`:

```text
[1,2,3]
```

After exploring that branch, we need to return to:

```text
[1,2]
```

So:

```java
current.remove(current.size() - 1);
```

removes `3`.

Then we can explore:

```text
Don't include 3
```

This is backtracking.

---

# 13. Subsets Are a Special Backtracking Pattern

The general pattern is:

```text
Choose
  ↓
Explore
  ↓
Undo
  ↓
Explore another choice
```

For subsets:

```text
Choose → add element
Explore → recursive call
Undo → remove element
```

But subsets have a special structure:

```text
Every element has exactly two choices.
```

```text
Include
Exclude
```

So:

```text
Subsets
   ↓
Binary decision tree
   ↓
2 branches at every element
```

---

# 14. Another Approach — Using a Loop

There is another common way to generate subsets.

Instead of explicitly writing:

```text
include
exclude
```

we can use a loop.

```java
import java.util.*;

public class Subsets {

    public static List<List<Integer>> subsets(int[] nums) {

        List<List<Integer>> result = new ArrayList<>();

        backtrack(
                nums,
                0,
                new ArrayList<>(),
                result
        );

        return result;
    }

    private static void backtrack(
            int[] nums,
            int start,
            List<Integer> current,
            List<List<Integer>> result) {

        result.add(new ArrayList<>(current));

        for (int i = start; i < nums.length; i++) {

            current.add(nums[i]);

            backtrack(
                    nums,
                    i + 1,
                    current,
                    result
            );

            current.remove(current.size() - 1);
        }
    }
}
```

This version is also very important.

---

# 15. How Are the Two Approaches Different?

## Approach 1 — Include / Exclude

```java
include
recursive call
undo

exclude
recursive call
```

This directly represents the binary decision.

---

## Approach 2 — Loop

```java
for (...) {

    choose

    recursive call

    undo
}
```

This directly represents:

> "Choose the next available element."

Both generate subsets.

---

# 16. Which Approach Should You Learn First?

For understanding recursion:

**Learn Include/Exclude first.**

It makes the decision tree obvious:

```text
             element
              /    \
          include  exclude
```

Then learn the loop-based version.

The loop-based version becomes especially useful when you move into:

* Combinations
* Combination Sum
* Subsets
* String partitioning
* General backtracking

---

# 17. Subsets vs Combinations

This distinction should now be very clear.

Suppose:

```text
[1,2,3]
```

### Combinations of size 2

Only:

```text
[1,2]
[1,3]
[2,3]
```

---

### All subsets

```text
[]
[1]
[2]
[3]
[1,2]
[1,3]
[2,3]
[1,2,3]
```

So:

```text
Combination
→ usually fixed size

Subset
→ every possible size
```

---

# 18. Subsets vs Permutations

For:

```text
[1,2,3]
```

### Subsets

```text
[1]
[2]
[3]
[1,2]
[1,3]
[2,3]
[1,2,3]
[]
```

### Permutations

```text
[1,2,3]
[1,3,2]
[2,1,3]
[2,3,1]
[3,1,2]
[3,2,1]
```

The difference:

```text
Subset:
"Which elements do I take?"

Permutation:
"In what order do I arrange them?"
```

---

# 19. Subsets of a String

Suppose:

```text
"abc"
```

We can generate:

```text
""
"a"
"b"
"c"
"ab"
"ac"
"bc"
"abc"
```

The same include/exclude logic works.

```java
public static void generateSubsequences(
        String str,
        int index,
        String current) {

    if (index == str.length()) {
        System.out.println(current);
        return;
    }

    // Include current character
    generateSubsequences(
            str,
            index + 1,
            current + str.charAt(index)
    );

    // Exclude current character
    generateSubsequences(
            str,
            index + 1,
            current
    );
}
```

Call:

```java
generateSubsequences("abc", 0, "");
```

---

# 20. Subset vs Subsequence

These terms are often confused.

## Subset

Usually used with a collection/set.

Example:

```text
[1,2,3]
```

A subset can be:

```text
[1,3]
```

---

## Subsequence

Usually used with a sequence/string/array.

A subsequence maintains the original relative order.

For:

```text
"abc"
```

valid subsequences include:

```text
""
"a"
"b"
"c"
"ab"
"ac"
"bc"
"abc"
```

But:

```text
"ba"
```

is not a subsequence of `"abc"`.

Because `b` comes after `a` in the original string.

---

# 21. A Very Important Pattern

For subsequences:

```text
                     a
                   /   \
              include  exclude
                 /       \
                b         b
              /   \     /   \
             ... ...
```

At every position:

```text
Take it
Don't take it
```

This is why subsequence problems are often solved using recursion.

---

# 22. Complexity

There are:

```text
2^n
```

subsets.

Therefore, just generating all subsets requires:

```text
O(2^n)
```

recursive leaves.

If we copy each subset, each subset can contain up to `n` elements.

Therefore the total output-related work is:

```text
O(n × 2^n)
```

A useful interview answer is:

```text
Time: O(n × 2^n)
Space: O(n) recursion depth
Output space: O(n × 2^n)
```

The exact complexity discussion can depend on whether output storage and copying are counted separately.

---

# 23. Why Can't We Do Better Than `2^n`?

Because there are actually:

```text
2^n
```

different answers.

If the problem asks you to output every subset, you must produce all of them.

Therefore the algorithm cannot have less than:

```text
Ω(2^n)
```

output size in terms of number of subsets.

This is an important complexity insight:

> Sometimes an exponential algorithm is unavoidable because the output itself is exponential.

---

# 24. Subsets With Duplicate Elements

Consider:

```text
[1,2,2]
```

A naive subset algorithm can generate duplicate subsets.

For example:

```text
[2]
```

may appear more than once.

The expected unique subsets are:

```text
[]
[1]
[2]
[1,2]
[2,2]
[1,2,2]
```

To solve this properly, we usually:

1. Sort the array.
2. Skip duplicate choices at the same recursion level.

---

# 25. Unique Subsets

```java
import java.util.*;

public class UniqueSubsets {

    public static List<List<Integer>> subsetsWithDup(
            int[] nums) {

        Arrays.sort(nums);

        List<List<Integer>> result = new ArrayList<>();

        backtrack(
                nums,
                0,
                new ArrayList<>(),
                result
        );

        return result;
    }

    private static void backtrack(
            int[] nums,
            int start,
            List<Integer> current,
            List<List<Integer>> result) {

        result.add(new ArrayList<>(current));

        for (int i = start; i < nums.length; i++) {

            // Skip duplicate choices at this level
            if (i > start && nums[i] == nums[i - 1]) {
                continue;
            }

            current.add(nums[i]);

            backtrack(
                    nums,
                    i + 1,
                    current,
                    result
            );

            current.remove(current.size() - 1);
        }
    }
}
```

---

# 26. Understand This Duplicate Check

This line is extremely important:

```java
if (i > start && nums[i] == nums[i - 1]) {
    continue;
}
```

Suppose:

```text
[1,2,2]
```

At the same recursion level:

```text
i = 1 → choose 2
i = 2 → choose another 2
```

We don't want both branches because they start with the same value.

Therefore:

```text
Same value
+
Same recursion level
=
Skip duplicate
```

But notice that:

```text
[2,2]
```

must still be allowed.

That's why the check is about **the same recursion level**, not simply "never use duplicate values."

---

# 27. Recursion Level Matters

This is a very important backtracking concept.

Consider:

```text
[2,2]
```

We want:

```text
[2,2]
```

So duplicates are not always forbidden.

We only want to avoid duplicate **choices at the same level**.

Think:

```text
Level 0:
  choose first 2
  choose second 2 → duplicate branch → skip

Level 1:
  choose second 2 after choosing first 2
  → valid
```

This distinction becomes extremely important in:

* Subsets II
* Combination Sum II
* Permutations II

---

# 28. Iterative Way to Generate Subsets

Subsets can also be generated without recursion.

Start:

```text
[]
```

Add `1`:

```text
[]
[1]
```

Add `2` to every existing subset:

```text
[]
[1]
[2]
[1,2]
```

Add `3`:

```text
[]
[1]
[2]
[1,2]
[3]
[1,3]
[2,3]
[1,2,3]
```

This gives all subsets.

But recursion is important because it teaches the decision-tree approach that you will use heavily in backtracking.

---

# 29. Bitmask Connection

There is another powerful way to think about subsets.

Every element has:

```text
0 → don't take
1 → take
```

For:

```text
[1,2,3]
```

we can represent choices using three bits.

For example:

```text
000 → []
001 → [1]
010 → [2]
011 → [1,2]
100 → [3]
101 → [1,3]
110 → [2,3]
111 → [1,2,3]
```

There are:

```text
2^3 = 8
```

possible bit patterns.

This connects recursion with **bit manipulation**.

---

# 30. Recursion and Bitmasking

The recursive approach says:

```text
For every element:

Include
Exclude
```

The bitmask approach says:

```text
For every bit:

1 → Include
0 → Exclude
```

They represent the same fundamental idea in different ways.

This is useful because many coding problems have both:

```text
Backtracking solution
```

and:

```text
Bit manipulation solution
```

---

# 31. General Subset Template

For understanding:

```java
void generate(
        int[] nums,
        int index,
        List<Integer> current) {

    if (index == nums.length) {
        save(current);
        return;
    }

    // Include
    current.add(nums[index]);

    generate(nums, index + 1, current);

    // Undo
    current.remove(current.size() - 1);

    // Exclude
    generate(nums, index + 1, current);
}
```

Memorize the **structure**, not the exact syntax:

```text
              ELEMENT
              /     \
             /       \
        INCLUDE     EXCLUDE
           |            |
        recurse       recurse
           |
         undo
```

---

# 32. How to Recognize Subset Problems

Look for phrases like:

```text
all possible subsets
all possible selections
choose or don't choose
all subsequences
all possible groups
every possible combination of elements
```

A very strong clue is:

> **For each element, I have two choices.**

If that is true, think:

```text
Include / Exclude recursion
```

---

# 33. Common Mistakes

## Mistake 1 — Forgetting the Empty Subset

The empty subset is valid:

```text
[]
```

So don't forget it.

---

## Mistake 2 — Not Undoing the Choice

Wrong:

```java
current.add(nums[index]);

generate(...);

// Missing remove
```

Correct:

```java
current.add(nums[index]);

generate(...);

current.remove(current.size() - 1);
```

---

## Mistake 3 — Wrong Base Case

The clean base case is:

```java
if (index == nums.length)
```

because every element has been processed.

---

## Mistake 4 — Confusing Subsets and Permutations

Remember:

```text
Subset:
[1,2]
```

does not create:

```text
[2,1]
```

Permutation does.

---

## Mistake 5 — Saving the Mutable List Directly

Use:

```java
new ArrayList<>(current)
```

when saving the answer.

---

# 34. Practice Problems

Solve these in order.

### Level 1

* [ ] Generate all subsets of `[1,2,3]`
* [ ] Count the number of subsets
* [ ] Generate subsets of a string
* [ ] Generate all subsequences
* [ ] Check whether a subsequence exists

### Level 2

* [ ] Subsets II
* [ ] Subsequence with a given sum
* [ ] Count subsequences with a given sum
* [ ] Generate subsequences whose sum equals `k`

### Level 3

* [ ] Combination Sum
* [ ] Combination Sum II
* [ ] Letter Combinations of a Phone Number
* [ ] Partition Equal Subset Sum

---

# 35. The Three Core Patterns So Far

You now have three important patterns.

## Pattern 1 — Simple Recursion

```text
Solve smaller problem
        ↓
Use its result
```

Example:

```text
factorial
sum
binary search
```

---

## Pattern 2 — Permutation

```text
Choose any available element
        ↓
Explore
        ↓
Undo
```

Order matters.

---

## Pattern 3 — Subset

```text
Include
   OR
Exclude
```

Every element creates two possibilities.

---

# 36. The Bigger Picture

You can now see the progression:

```text
                         RECURSION
                             |
             ┌───────────────┼───────────────┐
             ↓               ↓               ↓
         Basic          Permutation       Subset
                             |               |
                       Order matters     Include/Exclude
                             |               |
                           Swap          2 choices
                             |               |
                             └───────┬───────┘
                                     ↓
                                BACKTRACKING
                                     |
                      ┌──────────────┼──────────────┐
                      ↓              ↓              ↓
                 Combinations     N-Queens       Sudoku
```

---

# 37. What You Must Understand Before N-Queens

Before moving to `N Queens.md`, make sure you can explain these without memorizing code:

### Question 1

Why does a subset problem have `2^n` answers?

### Question 2

Why do we have two recursive calls?

```java
generate(index + 1);
generate(index + 1);
```

### Question 3

What does `current` represent?

### Question 4

Why do we remove the last element?

```java
current.remove(current.size() - 1);
```

### Question 5

Why do combinations use `start`?

### Question 6

Why do permutations need to consider different elements for each position?

### Question 7

What does this represent?

```text
Choose → Explore → Undo
```

If these concepts are clear, you have the foundation required for serious backtracking.

---

# 38. Final Mental Model

When you see:

> "Generate all possible subsets."

Immediately think:

```text
                  Current element
                         |
                 ┌───────┴───────┐
                 ↓               ↓
              INCLUDE         EXCLUDE
                 |               |
             recurse         recurse
                 |
               undo
```

When you see:

> "Choose `k` elements."

Think:

```text
Combination
     ↓
start index
     ↓
choose
     ↓
i + 1
     ↓
undo
```

When you see:

> "Arrange all elements."

Think:

```text
Permutation
     ↓
try every element
     ↓
swap
     ↓
recurse
     ↓
swap back
```

These three mental models are the foundation for the next stage:

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
   ↓
N-Queens
   ↓
Sudoku
```

The next topic, **N-Queens**, combines everything you've learned so far: recursion, choices, constraints, backtracking, and undoing decisions.
