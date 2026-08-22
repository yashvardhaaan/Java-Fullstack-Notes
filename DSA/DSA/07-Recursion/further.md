# Recursion & Backtracking — Complete Guide in Java

Backtracking is one of the most important applications of recursion.

If recursion taught you:

> "Solve a smaller problem."

Backtracking adds:

> "Try a choice, explore it, and if it doesn't work, undo it and try another choice."

The core pattern is:

```text
Choose
   ↓
Explore
   ↓
Undo
```

This file brings together everything from:

```text
Recursion
   ↓
Permutations
   ↓
Combinations
   ↓
Subsets
   ↓
N-Queens
   ↓
Sudoku
   ↓
General Backtracking
```

---

# 1. What Is Backtracking?

Backtracking is a systematic way of exploring possible solutions.

You:

1. Make a choice.
2. Recursively explore the choice.
3. Check whether it can lead to a solution.
4. If it fails, undo the choice.
5. Try another choice.

In simple terms:

> **Backtracking = recursion + choices + undoing choices**

---

# 2. The Simplest Example

Suppose you need to find a path through a maze.

You reach a point where you have two options:

```text
        Current
        /     \
      Left   Right
```

Try left.

If left eventually reaches the destination:

```text
Done
```

If left reaches a dead end:

```text
Undo
 ↓
Go back
 ↓
Try right
```

That's backtracking.

---

# 3. Recursion vs Backtracking

These terms are related but not identical.

## Recursion

A function calls itself.

```java
solve(n - 1);
```

The main idea is:

```text
Problem
  ↓
Smaller problem
  ↓
Smaller problem
```

---

## Backtracking

Backtracking uses recursion to explore **different choices**.

```text
Choice 1
   ↓
Explore
   ↓
Undo

Choice 2
   ↓
Explore
   ↓
Undo
```

So:

```text
Recursion
   ↓
can be used for
   ↓
Backtracking
```

But not every recursive algorithm is backtracking.

For example:

```java
factorial(n)
```

is recursion, but not really backtracking.

---

# 4. The Universal Backtracking Pattern

This is the most important template in this entire file:

```java
void backtrack(State state) {

    if (isComplete(state)) {
        saveAnswer(state);
        return;
    }

    for (Choice choice : choices) {

        if (!isValid(choice, state)) {
            continue;
        }

        // Choose
        makeChoice(state, choice);

        // Explore
        backtrack(state);

        // Undo
        undoChoice(state, choice);
    }
}
```

The exact Java code changes from problem to problem.

The structure remains remarkably similar.

---

# 5. The Four Questions

Whenever you see a backtracking problem, ask:

### 1. What is my current state?

Examples:

```text
current list
board
row
index
position
remaining target
```

---

### 2. What are my choices?

Examples:

```text
take / skip
1–9
every column
every unused element
every available character
```

---

### 3. What makes a choice invalid?

Examples:

```text
duplicate
same column
same diagonal
sum exceeds target
number violates Sudoku rules
```

---

### 4. How do I undo my choice?

Examples:

```text
remove()
swap back
board[row][col] = '.'
visited[x] = false
```

If you can answer these four questions, you are usually very close to the solution.

---

# 6. The Backtracking State

The **state** is everything needed to describe where you currently are in the search.

For subsets:

```java
List<Integer> current
int index
```

For permutations:

```java
int[] nums
int index
```

For N-Queens:

```java
char[][] board
int row
```

For Sudoku:

```java
char[][] board
```

For a maze:

```text
row
column
visited
```

Understanding the state is one of the most important parts of solving backtracking problems.

---

# 7. Example — Subsets

For:

```text
[1,2,3]
```

the state might be:

```text
current = [1,3]
index = 2
```

This means:

> We have selected `1` and `3`, and we are currently processing the element at index `2`.

The choices are:

```text
Include
Exclude
```

---

# 8. Example — Permutations

For:

```text
[1,2,3]
```

suppose the current state is:

```text
[2,1,3]
```

and:

```text
index = 2
```

The state tells us:

> Positions before `index` have already been decided.

The choices are the elements that can be placed at the current position.

---

# 9. Example — N-Queens

State:

```text
row = 2
board = ...
```

The meaning is:

> Rows `0` and `1` already contain queens. I now need to place the queen in row `2`.

Choices:

```text
column 0
column 1
column 2
...
```

Constraints:

```text
column
diagonal
```

Undo:

```text
board[row][col] = '.';
```

---

# 10. Example — Sudoku

State:

```text
board
```

Choice:

```text
1 to 9
```

Constraint:

```text
row
column
box
```

Undo:

```text
board[row][col] = '.';
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

# 11. Backtracking Is a Search Tree

Every choice creates a branch.

Suppose there are two choices at every level:

```text
                 Start
                /     \
               A       B
              / \     / \
             C   D   E   F
```

Every path represents a possible sequence of decisions.

Backtracking explores these paths systematically.

---

# 12. Decision Tree

For subsets:

```text
                         []
                       /    \
                    take   skip
                     1       1
                    /         \
                  [1]          []
                 /   \        /  \
              take  skip   take  skip
                2     2      2     2
```

For N-Queens:

```text
                         Row 0
                    /      |      \
                  C0       C1      C2
                 /         |        \
              Row 1      Row 1     Row 1
```

For Sudoku:

```text
                       Empty cell
                   /      |      \
                  1       2       3
                  |       |       |
              Next cell Next cell Next cell
```

The exact branching differs.

The search-tree idea is the same.

---

# 13. Why Backtracking Can Be Exponential

Suppose every level has two choices:

```text
2 choices
```

and there are `n` levels.

Then the number of possible paths is approximately:

```text
2^n
```

For three choices at every level:

```text
3^n
```

For permutations:

```text
n!
```

So backtracking algorithms are often exponential.

---

# 14. Is Exponential Always Bad?

No.

Sometimes the problem itself has exponentially many answers.

For example, all subsets of `n` elements:

```text
2^n
```

subsets exist.

If you must output all of them, you cannot avoid generating them.

Therefore an exponential algorithm may be appropriate.

The important question is:

> **Can we prune enough of the search space to make the problem practical?**

---

# 15. What Is Pruning?

Pruning means:

> Stop exploring a branch as soon as you know it cannot produce a valid solution.

Example:

```text
Target = 10

Current sum = 13
```

If all future values are non-negative, then:

```text
13 > 10
```

means this branch can never work.

So:

```java
if (sum > target) {
    return;
}
```

This is pruning.

---

# 16. Without Pruning

Imagine:

```text
                    Start
                  /   |   \
                 A    B    C
                / \  / \  / \
               ... ... ... ...
```

You explore everything.

---

# 17. With Pruning

Suppose `B` immediately violates a constraint:

```text
                    Start
                  /   |   \
                 A    B    C
                /         \
              ...          ...
```

Branch `B` is removed immediately.

This saves a huge amount of work.

---

# 18. Backtracking = Search + Pruning

A useful mental model is:

```text
Backtracking
=
Systematic search
+
Early rejection of impossible branches
```

This is why backtracking is much better than blindly generating every possible configuration and checking them only at the end.

---

# 19. Example — Combination Sum

Suppose:

```text
candidates = [2,3,6,7]
target = 7
```

Current path:

```text
[2,2]
```

Current sum:

```text
4
```

We can continue.

But if:

```text
[2,2,6]
```

gives:

```text
10
```

then:

```text
10 > 7
```

So we immediately stop exploring that branch.

```text
Choose 6
   ↓
sum = 10
   ↓
invalid
   ↓
backtrack
```

---

# 20. A General Pruning Question

Whenever you're writing backtracking, ask:

> **Can I prove that this branch cannot possibly produce a valid answer?**

If yes:

```java
return;
```

or:

```java
continue;
```

This is pruning.

---

# 21. `return` vs `continue`

This distinction matters.

## `continue`

Use when:

> This particular choice is invalid, but other choices at this level may work.

Example:

```java
for (int col = 0; col < n; col++) {

    if (!isSafe(...)) {
        continue;
    }

    ...
}
```

---

## `return`

Use when:

> The entire current branch can no longer work.

Example:

```java
if (sum > target) {
    return;
}
```

because deeper recursion won't fix an already-invalid state.

---

# 22. Choosing the Right Recursive Parameter

One of the hardest parts of recursion is deciding:

> What should the recursive function receive?

Common parameters include:

```text
index
start
row
column
remaining
current
board
visited
```

The parameter should represent information needed to continue the search.

---

# 23. `index`

Used when processing elements sequentially.

Examples:

```text
subsets
subsequences
array recursion
```

Example:

```java
backtrack(index + 1);
```

Meaning:

> Move to the next element.

---

# 24. `start`

Used when choosing from a remaining range without going backward.

Examples:

```text
combinations
combination sum
subsets with loop
```

Example:

```java
backtrack(i + 1);
```

Meaning:

> Future choices must come after the current choice.

---

# 25. `row`

Used for grid problems where one row is processed at a time.

Example:

```text
N-Queens
```

```java
backtrack(row + 1);
```

Meaning:

> Move to the next row.

---

# 26. `remaining`

Used when the problem has a target.

Example:

```text
Combination Sum
```

Instead of tracking:

```text
currentSum
```

you can track:

```text
remaining
```

For example:

```java
backtrack(
    candidates,
    remaining - candidates[i]
);
```

If:

```text
remaining == 0
```

you found a solution.

---

# 27. `current`

`current` represents the choices made so far.

Example:

```java
List<Integer> current
```

could contain:

```text
[2,3,5]
```

The recursive function extends or modifies this state.

Typical operations:

```java
current.add(x);
```

and:

```java
current.remove(current.size() - 1);
```

---

# 28. The Golden Rule for Mutable State

If you modify shared state before recursion:

```java
makeChange();
```

you usually need to undo it after recursion:

```java
undoChange();
```

Think:

```text
Modify
  ↓
Recurse
  ↓
Restore
```

Examples:

### List

```java
current.add(x);
backtrack(...);
current.remove(current.size() - 1);
```

### Board

```java
board[row][col] = 'Q';
backtrack(...);
board[row][col] = '.';
```

### Visited array

```java
visited[i] = true;
backtrack(...);
visited[i] = false;
```

### Swap

```java
swap(arr, i, j);
backtrack(...);
swap(arr, i, j);
```

---

# 29. Why Is Undo So Important?

Because recursive calls often modify the same object.

For example:

```java
List<Integer> current
```

is shared between recursive calls.

Suppose:

```text
[]
 ↓
[1]
 ↓
[1,2]
```

After exploring `[1,2]`, if you don't remove `2`, the next branch may incorrectly start with:

```text
[1,2]
```

instead of:

```text
[1]
```

So the search state becomes corrupted.

---

# 30. Backtracking State Must Be Correct

At every recursive call, the state should accurately represent:

> **Exactly the choices made on the current path.**

Not:

```text
choices from previous branches
```

Not:

```text
future choices
```

Only:

```text
current path
```

This is one of the most important debugging ideas in backtracking.

---

# 31. A Useful Invariant

An **invariant** is something that remains true throughout the algorithm.

For example, in N-Queens:

> Before calling `backtrack(row)`, all rows before `row` contain valid queen placements.

For subsets:

> `current` contains exactly the elements selected on the current recursion path.

For Sudoku:

> The board contains only valid placements made so far.

Thinking in terms of invariants makes recursive algorithms much easier to reason about.

---

# 32. Backtracking and State Restoration

Suppose:

```text
Path:
A → B → C
```

After exploring `C`, we return to:

```text
A → B
```

not:

```text
A → B → C
```

Therefore the state must be restored.

Visually:

```text
Choose C
   ↓
A → B → C
   ↓
Explore
   ↓
Return
   ↓
Undo C
   ↓
A → B
```

This is the essence of backtracking.

---

# 33. A Simple Java Example

Let's generate all binary strings of length `n`.

For every position, we have two choices:

```text
0
1
```

```java
import java.util.*;

public class BinaryStrings {

    public static void generate(
            int n,
            StringBuilder current,
            List<String> result) {

        if (current.length() == n) {
            result.add(current.toString());
            return;
        }

        // Choose 0
        current.append('0');

        generate(n, current, result);

        current.deleteCharAt(current.length() - 1);

        // Choose 1
        current.append('1');

        generate(n, current, result);

        current.deleteCharAt(current.length() - 1);
    }
}
```

For:

```text
n = 2
```

the output is:

```text
00
01
10
11
```

---

# 34. Why This Is Backtracking

At each position:

```text
Choose 0
Explore
Undo

Choose 1
Explore
Undo
```

The state is:

```text
current
```

The choices are:

```text
0
1
```

The base case is:

```text
current.length() == n
```

---

# 35. Using `StringBuilder`

Why use:

```java
StringBuilder
```

instead of:

```java
String
```

?

Because strings are immutable.

Repeatedly doing:

```java
current + "0"
```

creates new strings.

With `StringBuilder`:

```java
append()
deleteCharAt()
```

we can modify the same object and undo the modification.

This is a useful Java-specific backtracking technique.

---

# 36. Backtracking With `visited[]`

A common pattern is:

```java
boolean[] visited
```

Suppose:

```text
nums = [1,2,3]
```

and we want permutations.

At the beginning:

```text
visited = [false,false,false]
```

Choose `1`:

```text
visited[0] = true
```

Then recurse.

After returning:

```text
visited[0] = false
```

So:

```text
Choose
 ↓
visited = true
 ↓
Explore
 ↓
visited = false
```

This is another form of state restoration.

---

# 37. When Should You Use `visited[]`?

Use it when:

> You need to know which elements have already been used on the current path.

Typical problems:

```text
Permutations
Graph/maze traversal
Word search
Some scheduling problems
```

You don't always need it.

For combinations, a `start` index is often enough.

---

# 38. `start` vs `visited`

This is a very important distinction.

### `start`

Means:

> Only consider elements from this point onward.

Useful for:

```text
Combinations
Subsets
Combination Sum
```

---

### `visited`

Means:

> This particular element is already being used on the current path.

Useful for:

```text
Permutations
Path problems
Some graph problems
```

---

# 39. Example

Array:

```text
[1,2,3]
```

Combination:

```text
[1,3]
```

After choosing `1`, we move forward:

```text
start = 1
```

We don't need to remember that `1` is used.

For permutations:

```text
[1,3,2]
```

the next position might need to consider any element not currently used.

Therefore:

```text
visited[]
```

is useful.

---

# 40. Backtracking With Constraints

Many problems can be expressed as:

```text
Choose
   ↓
Is choice valid?
   ↓
No → reject
   ↓
Yes
   ↓
Apply choice
   ↓
Recurse
   ↓
Undo
```

Examples:

| Problem      | Choice          | Constraint                     |
| ------------ | --------------- | ------------------------------ |
| Subsets      | Include/exclude | Usually none                   |
| Permutations | Unused element  | Can't reuse                    |
| Combinations | Next element    | No backward choice             |
| N-Queens     | Column          | Column/diagonal                |
| Sudoku       | Number 1–9      | Row/column/box                 |
| Maze         | Direction       | Don't revisit / stay in bounds |
| Word Search  | Neighbor        | Character must match           |

---

# 41. Maze Example

Suppose:

```text
S . .
# . #
. . E
```

You can move:

```text
up
down
left
right
```

At every cell, try each direction.

Before moving:

```text
Is the cell valid?
```

Check:

```text
inside board?
not blocked?
not already visited?
```

Then:

```text
mark visited
move
recurse
unmark visited
```

Again:

```text
Choose
Explore
Undo
```

---

# 42. Word Search Example

Suppose the board contains letters and we need to find:

```text
"CAT"
```

At a matching `C`, we try neighboring cells for `A`.

Then from `A`, neighboring cells for `T`.

If a path fails:

```text
unmark current cell
```

and try another direction.

This is backtracking on a grid.

---

# 43. General Grid Backtracking Pattern

```java
void dfs(int row, int col) {

    if (outsideBoard) {
        return;
    }

    if (invalid) {
        return;
    }

    markVisited();

    for (direction : directions) {
        dfs(nextRow, nextCol);
    }

    unmarkVisited();
}
```

The important part is:

```java
markVisited();
...
unmarkVisited();
```

Without the undo, another path may incorrectly think the cell is permanently unavailable.

---

# 44. Backtracking vs DFS

These are often confused.

DFS means:

> Explore as deeply as possible before going to another branch.

Backtracking means:

> Explore a choice, and undo the choice when returning to try another possibility.

They often appear together.

For example:

```text
DFS + state modification + undo
```

is a common backtracking implementation.

But DFS by itself does not necessarily involve backtracking.

---

# 45. Backtracking vs Dynamic Programming

Another common confusion.

### Backtracking

Usually asks:

> What are all possible choices/solutions?

It explores a search space.

---

### Dynamic Programming

Usually asks:

> Can I reuse results from overlapping subproblems?

It stores previously computed results.

Example:

```text
Fibonacci
```

Naive recursion repeatedly computes:

```text
fib(3)
fib(2)
...
```

Memoization stores the answers.

---

# 46. Backtracking and Memoization Can Combine

Some problems have both:

```text
choices
+
overlapping states
```

In such cases, you may use:

```text
Backtracking
+
Memoization
```

to avoid solving the same state repeatedly.

This is a more advanced topic.

---

# 47. How to Debug Backtracking

Backtracking bugs are usually state bugs.

When your output is wrong, inspect these things.

### 1. Is the choice made correctly?

```java
makeChoice();
```

### 2. Is recursion receiving the correct state?

```java
backtrack(nextState);
```

### 3. Is the choice undone?

```java
undoChoice();
```

### 4. Is the base case correct?

```java
if (complete)
```

### 5. Are invalid branches being pruned correctly?

```java
if (!valid)
```

---

# 48. Debugging With Print Statements

For learning, temporarily print:

```java
System.out.println(current);
```

before recursion.

Then:

```java
System.out.println("Backtracking: " + current);
```

after undoing.

For example:

```text
Choose: [1]
Choose: [1,2]
Choose: [1,2,3]
Backtrack: [1,2]
Choose: [1,3]
Backtrack: [1]
```

This lets you see the recursion tree.

---

# 49. Debugging the Call Stack

If you are confused about recursion, write:

```text
Level 0
  ↓
Level 1
  ↓
Level 2
  ↓
Level 3
```

Then track the state at each level.

For example:

```text
Level 0 → []
Level 1 → [1]
Level 2 → [1,2]
Level 3 → [1,2,3]
```

When returning:

```text
Level 3 returns
Level 2 restores [1,2]
Level 2 tries another choice
```

This makes backtracking much easier to visualize.

---

# 50. A Backtracking Checklist

When solving a new problem, go through this checklist:

```text
[ ] What is the state?

[ ] What is the decision point?

[ ] What choices are available?

[ ] What is the base case?

[ ] What makes a choice invalid?

[ ] What changes after making a choice?

[ ] What should recursion receive?

[ ] What must be undone?

[ ] Can I prune invalid branches early?

[ ] Am I looking for one answer or all answers?

[ ] Do I need visited[]?

[ ] Do I need start/index?

[ ] Do I need to copy current before saving?
```

This checklist is extremely useful for LeetCode.

---

# 51. One Solution vs All Solutions

This affects the entire implementation.

## Find one solution

Return immediately when found:

```java
if (backtrack()) {
    return true;
}
```

Examples:

```text
Sudoku
Maze path
Some word search problems
```

---

## Find all solutions

Save every valid state:

```java
if (complete) {
    result.add(new ArrayList<>(current));
    return;
}
```

Examples:

```text
Subsets
Permutations
Combinations
N-Queens
```

---

# 52. Returning an Answer vs Modifying a Result List

Two common styles exist.

### Style 1 — Return directly

```java
boolean solve(board)
```

Useful when finding one solution.

---

### Style 2 — Pass result list

```java
void backtrack(current, result)
```

Useful when collecting all solutions.

Neither is universally better.

Choose based on the problem.

---

# 53. Avoiding Duplicate Solutions

Duplicate handling is a major backtracking topic.

Suppose:

```text
[1,2,2]
```

If you blindly choose each element, you may produce duplicate results.

Common strategies:

### Sort first

```java
Arrays.sort(nums);
```

### Skip duplicates at the same level

```java
if (i > start && nums[i] == nums[i - 1]) {
    continue;
}
```

### Use a set

```java
Set<Integer> used = new HashSet<>();
```

The correct technique depends on the problem.

---

# 54. Same Level vs Different Level

This is one of the most difficult ideas for beginners.

Suppose:

```text
[1,2,2]
```

At the same recursion level:

```text
choose first 2
choose second 2
```

could produce duplicate branches.

So skip one.

But at a deeper level:

```text
choose 2
    ↓
choose another 2
```

may be completely valid.

Therefore:

> **Duplicate values are not necessarily forbidden. Duplicate choices at the same level may be forbidden.**

This is critical in:

```text
Subsets II
Combination Sum II
Permutations II
```

---

# 55. Backtracking Complexity

Backtracking complexity depends on:

```text
number of choices
×
recursion depth
×
work per node
```

For example:

### Subsets

```text
2^n
```

states.

### Permutations

```text
n!
```

leaves.

### N-Queens

Approximately:

```text
O(n!)
```

search space before considering pruning.

### Sudoku

Exponential worst-case search.

The exact complexity varies heavily with pruning and constraints.

---

# 56. How to Make Backtracking Faster

There are several important techniques.

## 1. Pruning

Reject impossible states early.

```java
if (invalid) {
    return;
}
```

---

## 2. Better Choice Ordering

Try the most constrained choice first.

Example:

```text
Sudoku → cell with fewest candidates
```

---

## 3. Maintain State

Use:

```text
boolean[]
HashSet
bitmask
```

instead of repeatedly scanning.

---

## 4. Avoid Unnecessary Copies

Don't copy `current` during every recursive call.

Copy only when saving a final answer.

---

## 5. Sort the Input

Sorting can make duplicate handling and pruning easier.

---

# 57. Bitmask Optimization

For problems with a small fixed set of choices, bitmasks can be extremely useful.

For example, numbers:

```text
1–9
```

can be represented using bits.

A mask can tell us which numbers are already used.

For example:

```text
000001011
```

could represent some used values.

Then checking availability becomes a bit operation.

This is an advanced optimization.

First understand normal boolean arrays.

---

# 58. A Practical Learning Order

You should learn backtracking in this order:

```text
1. Subsets
      ↓
2. Combinations
      ↓
3. Permutations
      ↓
4. Combination Sum
      ↓
5. N-Queens
      ↓
6. Sudoku
      ↓
7. Maze
      ↓
8. Word Search
      ↓
9. Advanced constraint problems
```

This progression gradually increases the number of constraints.

---

# 59. Your Core Templates

## Template 1 — Include / Exclude

```java
void solve(int index) {

    if (index == n) {
        save();
        return;
    }

    // Include
    current.add(arr[index]);

    solve(index + 1);

    current.remove(current.size() - 1);

    // Exclude
    solve(index + 1);
}
```

Use for:

```text
Subsets
Subsequences
Binary choices
```

---

# 60. Template 2 — Loop-Based Backtracking

```java
void backtrack(int start) {

    if (complete()) {
        save();
        return;
    }

    for (int i = start; i < n; i++) {

        if (!valid(i)) {
            continue;
        }

        current.add(arr[i]);

        backtrack(i + 1);

        current.remove(current.size() - 1);
    }
}
```

Use for:

```text
Combinations
Subsets
Combination Sum
```

---

# 61. Template 3 — Permutations

```java
void backtrack() {

    if (complete()) {
        save();
        return;
    }

    for (int i = 0; i < n; i++) {

        if (visited[i]) {
            continue;
        }

        visited[i] = true;
        current.add(arr[i]);

        backtrack();

        current.remove(current.size() - 1);
        visited[i] = false;
    }
}
```

Use when:

> Any unused element can be selected next.

---

# 62. Template 4 — Grid Backtracking

```java
boolean solve(int row, int col) {

    if (complete()) {
        return true;
    }

    if (invalid(row, col)) {
        return false;
    }

    mark(row, col);

    for (direction : directions) {

        if (solve(nextRow, nextCol)) {
            return true;
        }
    }

    unmark(row, col);

    return false;
}
```

Use for:

```text
Maze
Word Search
Grid paths
```

---

# 63. Template 5 — Constraint Backtracking

```java
boolean backtrack(state) {

    if (complete(state)) {
        return true;
    }

    for (Choice choice : choices(state)) {

        if (!valid(state, choice)) {
            continue;
        }

        apply(state, choice);

        if (backtrack(state)) {
            return true;
        }

        undo(state, choice);
    }

    return false;
}
```

This is the most general form.

---

# 64. The Most Important Pattern

Forget all the templates for a moment.

Remember this:

```text
                CURRENT STATE
                      |
                  Make Choice
                      |
                 Is it valid?
                 /         \
               No          Yes
               |             |
             Reject        Apply
                             |
                           Recurse
                             |
                      Did it succeed?
                       /          \
                     Yes           No
                      |             |
                     Done         Undo
                                    |
                              Try next choice
```

If you can translate a problem into this diagram, you can usually build the recursion.

---

# 65. Interview Approach

When an interviewer gives you a backtracking problem, don't immediately start coding.

First say something like:

> "I'll model this as a search tree. At each level, I'll enumerate the available choices. For each valid choice, I'll modify the current state, recursively solve the remaining problem, and restore the state afterward."

Then explain:

1. State
2. Choices
3. Constraints
4. Base case
5. Backtracking step
6. Complexity

This shows that you understand the algorithm rather than memorizing code.

---

# 66. Example Interview Explanation — N-Queens

A concise explanation:

> "I'll place one queen per row. For each row, I'll try every column. A position is valid if there is no queen in the same column or either diagonal. After placing a queen, I'll recursively process the next row. If the recursive call fails, I'll remove the queen and try the next column."

That's a strong interview explanation.

---

# 67. Example Interview Explanation — Sudoku

> "I'll find an empty cell and try digits from 1 to 9. If a digit satisfies the row, column, and box constraints, I'll place it and recursively solve the remaining board. If that choice eventually leads to a dead end, I'll restore the cell and try the next digit. If there are no empty cells left, the puzzle is solved."

Again:

```text
Choose
Check
Explore
Undo
```

---

# 68. How to Know When Backtracking Is Appropriate

Ask:

### Question 1

Are there multiple possible choices?

If no:

```text
Probably ordinary recursion.
```

If yes:

```text
Maybe backtracking.
```

### Question 2

Do choices affect future possibilities?

If yes:

```text
Backtracking is likely.
```

### Question 3

Can an invalid partial solution be detected early?

If yes:

```text
Backtracking + pruning is likely.
```

### Question 4

Do you need one or all valid configurations?

If yes:

```text
Strong backtracking signal.
```

---

# 69. Backtracking Problem Recognition

When you see:

```text
Generate all...
Find all possible...
Place...
Arrange...
Choose...
Partition...
Solve...
Return all valid...
```

don't automatically use backtracking.

Instead ask:

```text
Can I represent the problem as:

Choice
  ↓
Constraint
  ↓
Recursive exploration
  ↓
Undo
```

If yes, backtracking is a strong candidate.

---

# 70. Your Recursion Mental Model

At this point, you should stop thinking:

> "Recursion means a function calls itself."

That's technically correct but not enough.

Instead think:

> **A recursive function represents one level of a decision process.**

For example:

```text
Subsets:
"What do I do with this element?"

Permutations:
"Which element goes in this position?"

Combinations:
"Which element should I choose next?"

N-Queens:
"Where should I put the queen in this row?"

Sudoku:
"What number should I put in this cell?"
```

That's a much stronger understanding.

---

# 71. The Difference Between Going Down and Coming Back

This is another important concept.

When recursion goes down:

```text
Choose
 ↓
Choose
 ↓
Choose
 ↓
Base case
```

you're building a solution.

When recursion comes back:

```text
Base case
 ↑
Undo
 ↑
Try next choice
```

you're exploring alternatives.

So backtracking happens largely during the **returning phase**.

---

# 72. Example

Suppose:

```text
[]
```

Choose `1`:

```text
[1]
```

Choose `2`:

```text
[1,2]
```

Choose `3`:

```text
[1,2,3]
```

Reach base case.

Now return:

```text
[1,2,3]
     ↓
remove 3
     ↓
[1,2]
```

Then try another choice.

So:

```text
Going down → build
Coming back → undo
```

This mental model is extremely useful.

---

# 73. Common Beginner Mistakes

## 1. Writing Code Before Defining the State

Don't start with:

```java
void solve(...)
```

until you know what the parameters mean.

---

## 2. No Clear Base Case

Every recursive search needs a clear stopping condition.

---

## 3. Forgetting Undo

This is probably the most common backtracking bug.

---

## 4. Undoing the Wrong State

If you add:

```java
current.add(x);
```

you should remove that same choice after recursion.

---

## 5. Modifying Shared State Without Understanding It

Know whether your recursion is working with:

```text
same object
```

or:

```text
new copy
```

---

## 6. Missing Pruning Opportunities

If you already know a branch cannot work, stop exploring it.

---

## 7. Confusing `return` and `continue`

Remember:

```text
continue → reject this choice

return → abandon this entire branch
```

---

# 74. Practice Strategy

Don't solve 50 random backtracking problems.

Master patterns.

### Pattern 1 — Binary Choice

Solve:

```text
Subsets
Subsequences
Binary strings
```

---

### Pattern 2 — Choose From Remaining

Solve:

```text
Combinations
Subsets II
Combination Sum
```

---

### Pattern 3 — Arrange Elements

Solve:

```text
Permutations
Permutations II
```

---

### Pattern 4 — Constraint Placement

Solve:

```text
N-Queens
Sudoku
Graph Coloring
```

---

### Pattern 5 — Grid Search

Solve:

```text
Maze
Word Search
Rat in a Maze
```

Once you recognize the pattern, new problems become much easier.

---

# 75. Recommended Practice Set

## Beginner

* [ ] Generate binary strings
* [ ] Subsets
* [ ] Subsequences
* [ ] Combinations
* [ ] Permutations

## Intermediate

* [ ] Combination Sum
* [ ] Combination Sum II
* [ ] Subsets II
* [ ] Permutations II
* [ ] Letter Combinations of a Phone Number

## Advanced

* [ ] N-Queens
* [ ] Sudoku Solver
* [ ] Word Search
* [ ] Palindrome Partitioning
* [ ] Graph Coloring
* [ ] Rat in a Maze

---

# 76. What You Should Be Able to Explain Now

You should be able to answer these questions without looking at notes:

### Recursion

> What is the base case?

### Backtracking

> What is the choice?

### State

> What represents the current path?

### Constraint

> When is a choice invalid?

### Recursion

> What smaller state should I explore?

### Undo

> What must I restore after returning?

### Pruning

> Which branches can I reject early?

### Output

> Am I finding one solution or all solutions?

If you can answer these, you understand the core of backtracking.

---

# 77. Final Cheat Sheet

```text
RECURSION
    |
    |-- Base case
    |
    |-- Recursive case
    |
    |-- Smaller problem
    |
    |-- Call stack
    |
    ↓
BACKTRACKING
    |
    |-- State
    |
    |-- Choices
    |
    |-- Constraints
    |
    |-- Choose
    |
    |-- Explore
    |
    |-- Undo
    |
    |-- Prune
    |
    ↓
COMMON PATTERNS
    |
    |-- Include / Exclude
    |-- Start Index
    |-- Visited Array
    |-- Grid DFS
    |-- Constraint Search
    |
    ↓
PROBLEMS
    |
    |-- Subsets
    |-- Combinations
    |-- Permutations
    |-- Combination Sum
    |-- N-Queens
    |-- Sudoku
    |-- Word Search
```

---

# 78. The One Formula to Remember

When you see a backtracking problem, think:

```text
                    BACKTRACK
                        |
                 What is my state?
                        ↓
                 What are my choices?
                        ↓
                 Is the choice valid?
                    /        \
                  No          Yes
                  |             |
                Skip          Choose
                                ↓
                             Recurse
                                ↓
                              Undo
                                |
                                ↓
                         Try next choice
```

And in Java:

```java
for (Choice choice : choices) {

    if (!isValid(choice)) {
        continue;
    }

    makeChoice(choice);

    backtrack(nextState);

    undoChoice(choice);
}
```

That is the pattern behind a huge number of recursive search problems.

---

# 79. Final Understanding

Your recursion journey should now be:

```text
                    RECURSION
                        |
              Understand the call stack
                        |
                        ↓
               Simple Recursion
                        |
                        ↓
              Recursive Problems
                        |
                        ↓
                 Decision Trees
                        |
                        ↓
                  Subsets
                        |
                        ↓
                Combinations
                        |
                        ↓
                Permutations
                        |
                        ↓
                BACKTRACKING
                        |
              ┌─────────┼─────────┐
              ↓         ↓         ↓
          N-Queens    Sudoku    Word Search
```

The most important transition is:

```text
Recursion
   ↓
"Call myself on a smaller problem"

Backtracking
   ↓
"Try a choice, recursively explore it,
 undo it, and try another choice."
```

Once this becomes natural, you don't need to memorize a separate algorithm for every backtracking problem.

Instead, you identify:

```text
STATE
CHOICES
CONSTRAINTS
BASE CASE
RECURSIVE CALL
UNDO
PRUNING
```

and build the solution around those seven pieces.

---

# 80. Final Backtracking Checklist

Before submitting a backtracking solution, verify:

* [ ] I know exactly what the recursive function represents.
* [ ] I know what every parameter means.
* [ ] I have a correct base case.
* [ ] I know all possible choices.
* [ ] Invalid choices are rejected.
* [ ] I make the choice before recursion.
* [ ] I recursively explore the new state.
* [ ] I undo the choice after recursion.
* [ ] I don't accidentally keep state from another branch.
* [ ] I copy mutable state when saving an answer.
* [ ] I handle duplicates if required.
* [ ] I prune impossible branches early.
* [ ] I know whether I need one answer or all answers.
* [ ] I can explain the time and space complexity.

If you can consistently go through this checklist, you have moved beyond simply **knowing recursion syntax** and have developed the actual problem-solving framework needed for recursion and backtracking in Java.
