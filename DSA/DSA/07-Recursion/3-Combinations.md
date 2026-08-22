# Recursion — Combinations in Java

Combinations are one of the most important recursion patterns.

They are closely related to:

* Subsets
* Subsequences
* Backtracking
* Permutations
* N-Queens
* Combination Sum

The key difference is:

> **In combinations, order does not matter.**

---

# 1. What Is a Combination?

Suppose we have:

```text
[1, 2, 3]
```

If we want to choose `2` elements, the combinations are:

```text
[1, 2]
[1, 3]
[2, 3]
```

We do **not** include:

```text
[2, 1]
[3, 1]
[3, 2]
```

because those represent the same selections.

For example:

```text
[1, 2] == [2, 1]
```

in combinations.

---

# 2. Permutation vs Combination

This is the first thing you should understand.

## Permutation

Order matters.

```text
[1, 2]
[2, 1]
```

are different.

---

## Combination

Order does not matter.

```text
[1, 2]
[2, 1]
```

represent the same selection.

Therefore:

```text
Permutation → arrangement
Combination → selection
```

A useful way to remember it:

```text
Permutation:
"Who goes where?"

Combination:
"Who do I choose?"
```

---

# 3. Example

Suppose:

```text
n = 4
k = 2
```

We have:

```text
1 2 3 4
```

We want to choose `2`.

The combinations are:

```text
[1, 2]
[1, 3]
[1, 4]
[2, 3]
[2, 4]
[3, 4]
```

There are:

```text
4C2 = 6
```

combinations.

---

# 4. The Important Difference From Permutations

In permutations, after choosing an element, we can still choose previously used positions because the order matters.

In combinations, once we move forward, we **never go backward**.

For example:

```text
[1, 2]
```

After choosing `1`, we can choose:

```text
2
3
4
```

But after choosing `2`, we do not go back and choose `1`.

Why?

Because:

```text
[1, 2]
```

and:

```text
[2, 1]
```

would be duplicates.

This leads to one of the most important recursion parameters:

```text
start
```

---

# 5. What Does `start` Mean?

Suppose our function is:

```java
combine(start, current)
```

The `start` variable means:

> "The next element I am allowed to choose from."

For example:

```text
[1, 2, 3, 4]
```

If:

```text
start = 2
```

then we can choose from:

```text
2
3
4
```

We cannot choose `1` again.

This automatically prevents duplicate combinations.

---

# 6. Basic Combination Problem

### Problem

Given:

```text
n
k
```

generate all combinations of `k` numbers from:

```text
1 ... n
```

Example:

```text
n = 4
k = 2
```

Output:

```text
[
 [1,2],
 [1,3],
 [1,4],
 [2,3],
 [2,4],
 [3,4]
]
```

---

# 7. Java Solution

```java
import java.util.*;

public class Combinations {

    public static List<List<Integer>> combine(int n, int k) {

        List<List<Integer>> result = new ArrayList<>();

        backtrack(
                1,
                n,
                k,
                new ArrayList<>(),
                result
        );

        return result;
    }

    private static void backtrack(
            int start,
            int n,
            int k,
            List<Integer> current,
            List<List<Integer>> result) {

        // Base case
        if (current.size() == k) {
            result.add(new ArrayList<>(current));
            return;
        }

        // Try every possible choice
        for (int i = start; i <= n; i++) {

            // Choose
            current.add(i);

            // Explore
            backtrack(
                    i + 1,
                    n,
                    k,
                    current,
                    result
            );

            // Undo
            current.remove(current.size() - 1);
        }
    }
}
```

The most important part is:

```java
current.add(i);

backtrack(i + 1, ...);

current.remove(current.size() - 1);
```

Again:

```text
Choose
  ↓
Explore
  ↓
Undo
```

---

# 8. Why `i + 1`?

This is one of the most important ideas in combinations.

Suppose we choose:

```text
1
```

Now we should only be allowed to choose:

```text
2
3
4
```

So the next recursive call starts at:

```text
2
```

Therefore:

```java
backtrack(i + 1, ...);
```

If we chose:

```text
2
```

the next call starts at:

```text
3
```

So:

```text
Choose 2
     ↓
Next choices:
3, 4
```

This prevents:

```text
[2, 1]
```

from ever being generated.

---

# 9. Recursion Tree

For:

```text
n = 4
k = 2
```

the tree looks approximately like:

```text
                         []
              /          |          | 
             1           2          3
          /  |  \       /  \        |
         2   3   4     3    4       4
         |   |   |     |    |       |
        12  13  14    23   24      34
```

The valid answers are:

```text
12
13
14
23
24
34
```

Notice:

```text
21
31
32
```

never appear.

That's because we always move forward.

---

# 10. Understanding the First Branch

Start with:

```text
[]
```

The loop is:

```text
i = 1
i = 2
i = 3
i = 4
```

Choose `1`:

```text
[1]
```

Now:

```text
start = 2
```

Possible choices:

```text
2
3
4
```

Choose `2`:

```text
[1, 2]
```

Now:

```text
current.size() == k
```

So we save:

```text
[1, 2]
```

Then:

```text
current.remove(...)
```

restores:

```text
[1]
```

Now try `3`:

```text
[1, 3]
```

Then:

```text
[1, 4]
```

After all choices under `1` are finished, we return to:

```text
[]
```

and try:

```text
2
```

This gives:

```text
[2, 3]
[2, 4]
```

And so on.

---

# 11. The `current` List

This variable:

```java
List<Integer> current
```

represents:

> The combination currently being constructed.

For example:

```text
current = []
```

Then:

```text
current = [1]
```

Then:

```text
current = [1, 3]
```

Once its size becomes `k`, we have a complete combination.

---

# 12. Why Do We Remove the Last Element?

After:

```java
current.add(i);
```

we recursively explore all possibilities that begin with that choice.

When recursion returns, we need to undo that choice:

```java
current.remove(current.size() - 1);
```

Example:

```text
[]
 ↓
[1]
 ↓
[1,2]
```

`[1,2]` is complete.

Return.

Remove `2`:

```text
[1]
```

Try:

```text
3
```

Now:

```text
[1,3]
```

Return.

Remove `3`:

```text
[1]
```

Try:

```text
4
```

Now:

```text
[1,4]
```

This is backtracking.

---

# 13. Why Copy the List?

Notice:

```java
result.add(new ArrayList<>(current));
```

not:

```java
result.add(current);
```

Why?

Because `current` is constantly changing.

For example:

```text
current = [1,2]
```

Then later:

```text
current = [1,3]
```

Then:

```text
current = [1,4]
```

If we store the same mutable list reference, all entries can end up referring to the same changing object.

Therefore:

```java
new ArrayList<>(current)
```

creates a snapshot.

---

# 14. Combination Formula

The number of combinations of choosing `k` elements from `n` elements is:

```text
nCk = n! / (k! × (n-k)!)
```

For:

```text
n = 4
k = 2
```

we get:

```text
4C2
= 4! / (2! × 2!)
= 24 / 4
= 6
```

Exactly six combinations.

---

# 15. Another Example

Suppose:

```text
n = 5
k = 3
```

Numbers:

```text
1 2 3 4 5
```

Combinations:

```text
[1,2,3]
[1,2,4]
[1,2,5]
[1,3,4]
[1,3,5]
[1,4,5]
[2,3,4]
[2,3,5]
[2,4,5]
[3,4,5]
```

Total:

```text
5C3 = 10
```

---

# 16. Combination Sum

Now we can use the same idea for a more interesting problem.

Suppose:

```text
candidates = [2,3,6,7]
target = 7
```

Find combinations whose sum equals `7`.

Answer:

```text
[2,2,3]
[7]
```

Here the same number can potentially be used multiple times.

This changes the recursive call.

Instead of:

```java
backtrack(i + 1, ...)
```

we may use:

```java
backtrack(i, ...)
```

because we are allowed to choose the same candidate again.

---

# 17. Basic Combination Sum

```java
import java.util.*;

public class CombinationSum {

    public static List<List<Integer>> combinationSum(
            int[] candidates,
            int target) {

        List<List<Integer>> result = new ArrayList<>();

        backtrack(
                candidates,
                target,
                0,
                new ArrayList<>(),
                result
        );

        return result;
    }

    private static void backtrack(
            int[] candidates,
            int target,
            int start,
            List<Integer> current,
            List<List<Integer>> result) {

        // Valid combination
        if (target == 0) {
            result.add(new ArrayList<>(current));
            return;
        }

        // Target exceeded
        if (target < 0) {
            return;
        }

        for (int i = start; i < candidates.length; i++) {

            current.add(candidates[i]);

            // i, not i + 1
            backtrack(
                    candidates,
                    target - candidates[i],
                    i,
                    current,
                    result
            );

            current.remove(current.size() - 1);
        }
    }
}
```

---

# 18. Why `i` Instead of `i + 1`?

This is a very important distinction.

If:

```text
[2,3,6,7]
```

and we choose:

```text
2
```

we are allowed to choose `2` again.

Therefore:

```java
backtrack(..., i, ...)
```

means:

```text
2 → 2 → 2 → ...
```

If we used:

```java
i + 1
```

we would not be able to reuse `2`.

So:

```text
i + 1 → don't reuse current element

i → current element can be reused
```

---

# 19. Combination Sum Example

Target:

```text
7
```

Start:

```text
[]
```

Choose `2`:

```text
[2]
```

Remaining target:

```text
5
```

Choose `2` again:

```text
[2,2]
```

Remaining:

```text
3
```

Choose `3`:

```text
[2,2,3]
```

Remaining:

```text
0
```

We found an answer.

Then backtrack:

```text
[2,2,3]
       ↑ remove 3
```

becomes:

```text
[2,2]
```

Try other choices.

Eventually:

```text
[7]
```

is also found.

---

# 20. Three Different `start` Behaviors

This is worth memorizing.

## Case 1 — Use Each Element Once

```java
backtrack(i + 1);
```

Meaning:

```text
Choose current element
→ move forward
→ cannot choose it again
```

---

## Case 2 — Reuse Current Element

```java
backtrack(i);
```

Meaning:

```text
Choose current element
→ stay at same index
→ can choose it again
```

---

## Case 3 — Allow Any Element Again

Sometimes the problem allows completely unrestricted choices.

Then you may start from:

```text
0
```

again.

The exact recursion depends on the problem's rules.

---

# 21. Combination vs Subset

These concepts are related but not identical.

### Combination

Usually asks:

> Choose exactly `k` elements.

Example:

```text
n = 4
k = 2
```

Only:

```text
12
13
14
23
24
34
```

---

### Subset

Usually asks:

> Generate every possible selection.

For:

```text
[1,2,3]
```

we have:

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
Combination → often fixed size

Subset → every possible size
```

---

# 22. Combination Tree Pattern

The general pattern is:

```text
backtrack(start, current)

        |
        |--- choose i
        |
        |--- current.add(i)
        |
        |--- backtrack(i + 1, ...)
        |
        |--- current.remove(...)
```

The crucial difference from permutations is:

```text
Permutation:
    choose any unused element

Combination:
    choose only from the remaining forward range
```

---

# 23. Why Combinations Don't Need `visited[]`

In permutation problems, one common approach is:

```java
boolean[] visited;
```

because we need to know which elements have already been used.

For combinations, we can avoid that by using:

```java
start
```

Example:

```text
start = 2
```

means:

```text
1 has already been considered
2,3,4 are available
```

We simply never go backward.

Therefore no `visited[]` is needed for the basic combination problem.

---

# 24. Common Mistakes

## Mistake 1 — Starting Every Recursion From 0

Wrong:

```java
backtrack(0, ...);
```

inside every recursive call.

This can produce:

```text
[1,2]
[2,1]
```

and therefore duplicate combinations.

Correct:

```java
backtrack(i + 1, ...);
```

---

## Mistake 2 — Forgetting to Backtrack

Wrong:

```java
current.add(i);

backtrack(...);
```

Correct:

```java
current.add(i);

backtrack(...);

current.remove(current.size() - 1);
```

---

## Mistake 3 — Using `i + 1` When Reuse Is Allowed

For Combination Sum, if repetition is allowed:

```java
backtrack(i, ...);
```

not:

```java
backtrack(i + 1, ...);
```

---

## Mistake 4 — Saving the Same List

Wrong:

```java
result.add(current);
```

Usually use:

```java
result.add(new ArrayList<>(current));
```

---

# 25. A General Combination Template

When solving a combination problem, start with:

```java
void backtrack(
        int start,
        List<Integer> current) {

    if (isComplete(current)) {
        saveAnswer(current);
        return;
    }

    for (int i = start; i < n; i++) {

        // Choose
        current.add(i);

        // Explore
        backtrack(i + 1, current);

        // Undo
        current.remove(current.size() - 1);
    }
}
```

Then modify it according to the problem.

---

# 26. How to Recognize Combination Problems

Words that often indicate combinations:

```text
choose
select
pick
k elements
group
subset of size k
all possible selections
```

For example:

> "Find all ways to choose 3 numbers from an array."

Think:

```text
Combination
```

---

# 27. Combination Problem Checklist

Before coding, ask:

```text
1. Does order matter?
```

If yes:

```text
Permutation
```

If no:

```text
Combination
```

Then ask:

```text
2. Can I reuse an element?
```

If no:

```java
i + 1
```

If yes:

```java
i
```

Then ask:

```text
3. What is the stopping condition?
```

Examples:

```text
current.size() == k

target == 0

start == n
```

---

# 28. Practice Problems

Solve these in order.

## Beginner

* [ ] Choose `k` numbers from `1` to `n`
* [ ] Generate all combinations of an array
* [ ] Generate combinations of fixed size
* [ ] Count combinations

## Intermediate

* [ ] Combination Sum
* [ ] Combination Sum II
* [ ] Combination Sum III
* [ ] Letter combinations of a phone number

## Important

* [ ] Generate all subsets
* [ ] Generate unique subsets
* [ ] Generate all subsequences
* [ ] Partition a string into combinations

---

# 29. The Most Important Mental Model

Don't memorize:

```java
backtrack(i + 1, ...)
```

Instead understand **why** it is `i + 1`.

Think:

```text
I chose i.
        ↓
I don't want to choose anything before i again.
        ↓
So I start from i + 1.
```

For reusable elements:

```text
I chose i.
        ↓
I am allowed to choose i again.
        ↓
So I start from i.
```

That's the real concept.

---

# 30. The Big Picture

You now have three important recursion patterns:

```text
                    RECURSION
                        |
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
       Basic        Permutation    Combination
                        |             |
                     Order          Selection
                     matters        matters?
                        |             |
                    swap-based     start-based
                        |             |
                     choose       choose
                     explore      explore
                     undo         undo
```

And the next major concept is:

```text
Combination
     ↓
Subsets
```

The difference is simple:

```text
Combination → choose a specific number of elements

Subset → choose any number of elements
```

Once you understand that distinction, `Subsets.md` becomes much easier.
