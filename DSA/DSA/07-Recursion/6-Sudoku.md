# Recursion & Backtracking — Sudoku Solver in Java

Sudoku is one of the best problems for understanding **real backtracking**.

By now you have seen:

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
```

Sudoku takes the same idea one step further:

```text
Choose
   ↓
Check constraints
   ↓
Explore
   ↓
Dead end?
   ↓
Undo
   ↓
Try another choice
```

The goal of this file is not just to give you a Sudoku solution.

The goal is to make you understand **why the recursion works**.

---

# 1. What Is Sudoku?

A standard Sudoku board has:

```text
9 × 9
```

cells.

Some cells already contain numbers.

The remaining cells are empty.

Your job is to fill every empty cell with numbers:

```text
1 to 9
```

such that:

1. Every row contains `1–9` without repetition.
2. Every column contains `1–9` without repetition.
3. Every `3 × 3` box contains `1–9` without repetition.

---

# 2. Example Board

A Sudoku board may look like:

```text
5 3 . | . 7 . | . . .
6 . . | 1 9 5 | . . .
. 9 8 | . . . | . 6 .
------+-------+------
8 . . | . 6 . | . . 3
4 . . | 8 . 3 | . . 1
7 . . | . 2 . | . . 6
------+-------+------
. 6 . | . . . | 2 8 .
. . . | 4 1 9 | . . 5
. . . | . 8 . | . 7 9
```

`.` represents an empty cell.

The solver must fill all `.` cells.

---

# 3. Why Is Sudoku a Backtracking Problem?

Suppose we find an empty cell:

```text
row = 0
col = 2
```

We try:

```text
1
```

If `1` is valid:

```text
place 1
```

Then move to the next empty cell.

Maybe later we discover:

```text
No number can be placed here.
```

That means our previous choice was wrong.

So we:

```text
remove 1
```

and try:

```text
2
```

Then:

```text
Choose
   ↓
Explore
   ↓
Dead end
   ↓
Undo
   ↓
Try another choice
```

This is exactly backtracking.

---

# 4. The Most Important Mental Model

Don't think:

> "How do I solve the entire Sudoku?"

Think:

> "How do I fill one empty cell correctly?"

Then let recursion solve the remaining empty cells.

This is the same idea you used in N-Queens.

For N-Queens:

```text
solve(row)
```

means:

> Place a queen in this row.

For Sudoku:

```text
solve()
```

means:

> Find an empty cell and fill it.

---

# 5. The Recursive Structure

The basic Sudoku solver is:

```text
Find empty cell
      ↓
Try 1
      ↓
Is 1 valid?
   /       \
 No        Yes
 |          |
Skip       Place
             ↓
        Solve remaining
             ↓
          Success?
         /       \
       No        Yes
       |          |
      Undo       Done
       |
    Try 2
```

This is the heart of Sudoku recursion.

---

# 6. Basic Java Solution

```java
public class SudokuSolver {

    public static boolean solve(char[][] board) {

        // Find an empty cell
        for (int row = 0; row < 9; row++) {

            for (int col = 0; col < 9; col++) {

                if (board[row][col] == '.') {

                    // Try numbers 1 to 9
                    for (char num = '1'; num <= '9'; num++) {

                        if (isValid(board, row, col, num)) {

                            // Choose
                            board[row][col] = num;

                            // Explore
                            if (solve(board)) {
                                return true;
                            }

                            // Undo
                            board[row][col] = '.';
                        }
                    }

                    // No number worked
                    return false;
                }
            }
        }

        // No empty cells remain
        return true;
    }

    private static boolean isValid(
            char[][] board,
            int row,
            int col,
            char num) {

        // Check row
        for (int c = 0; c < 9; c++) {
            if (board[row][c] == num) {
                return false;
            }
        }

        // Check column
        for (int r = 0; r < 9; r++) {
            if (board[r][col] == num) {
                return false;
            }
        }

        // Check 3 x 3 box
        int boxRow = (row / 3) * 3;
        int boxCol = (col / 3) * 3;

        for (int r = boxRow; r < boxRow + 3; r++) {

            for (int c = boxCol; c < boxCol + 3; c++) {

                if (board[r][c] == num) {
                    return false;
                }
            }
        }

        return true;
    }
}
```

Don't memorize this code.

Understand these four things:

```text
Find empty cell
Try every possible number
Check validity
Backtrack if necessary
```

---

# 7. The Most Important Line

This line is the heart of the algorithm:

```java
if (solve(board)) {
    return true;
}
```

Why?

Because we are asking:

> "If I place this number here, can the remaining Sudoku be solved?"

If yes:

```java
return true;
```

If no:

```java
board[row][col] = '.';
```

and try another number.

This is the recursive decision.

---

# 8. Why Does `solve()` Return `boolean`?

This is an important difference from some previous recursion problems.

We don't want to generate every possible Sudoku solution.

We want to find **one valid solution**.

Therefore:

```java
boolean
```

is useful.

The function can tell its caller:

```text
true  → this path leads to a solution
false → this path is impossible
```

---

# 9. Meaning of `true`

If:

```java
solve(board)
```

returns:

```text
true
```

it means:

> "The current board can be completed successfully."

So the parent call doesn't need to try anything else.

It simply does:

```java
return true;
```

---

# 10. Meaning of `false`

If:

```java
solve(board)
```

returns:

```text
false
```

it means:

> "The choices made so far cannot produce a solution."

Therefore the previous choice must be undone.

```java
board[row][col] = '.';
```

Then we try another number.

---

# 11. Finding an Empty Cell

The code:

```java
for (int row = 0; row < 9; row++) {

    for (int col = 0; col < 9; col++) {

        if (board[row][col] == '.') {
            ...
        }
    }
}
```

searches the board from:

```text
top-left
```

to:

```text
bottom-right
```

The first empty cell becomes our next decision point.

---

# 12. Why Return `false` After the Number Loop?

Consider:

```java
if (board[row][col] == '.') {

    for (char num = '1'; num <= '9'; num++) {

        if (isValid(...)) {

            board[row][col] = num;

            if (solve(board)) {
                return true;
            }

            board[row][col] = '.';
        }
    }

    return false;
}
```

Suppose we tried:

```text
1
2
3
4
5
6
7
8
9
```

and none worked.

Then:

```text
There is no valid choice for this cell.
```

Therefore:

```java
return false;
```

This tells the previous recursive call:

> "Your previous choice led to a dead end."

---

# 13. Why Do We Stop at the First Empty Cell?

This is very important.

Suppose we find:

```text
row = 2
col = 5
```

and it is empty.

We don't continue searching for every empty cell.

We make this cell our current decision.

Then recursion finds the next empty cell.

So:

```text
solve()
 ↓
Find one empty cell
 ↓
Try a number
 ↓
solve()
 ↓
Find next empty cell
```

This creates a chain of decisions.

---

# 14. The Base Case

The base case is hidden in the loop structure.

If the entire board contains no `.`:

```text
No empty cells
```

then the loops finish.

The method reaches:

```java
return true;
```

That means:

> Every cell has been successfully filled.

So the Sudoku is solved.

---

# 15. Sudoku's Base Case

Conceptually:

```text
Are there any empty cells?

No
 ↓
Solved
 ↓
return true
```

Or:

```text
Are there any empty cells?

Yes
 ↓
Try to fill one
```

This is the recursion.

---

# 16. The Three Validity Checks

When trying:

```text
board[row][col] = num;
```

we must make sure that `num` doesn't already exist in:

```text
row
column
3 × 3 box
```

Therefore:

```text
isValid()
   |
   ├── Row
   ├── Column
   └── Box
```

---

# 17. Checking the Row

Suppose:

```text
5 3 . . 7 . . . .
```

and we want to place:

```text
3
```

There is already a `3`.

So:

```text
3
```

is invalid.

Code:

```java
for (int c = 0; c < 9; c++) {

    if (board[row][c] == num) {
        return false;
    }
}
```

---

# 18. Checking the Column

Suppose:

```text
5
6
.
8
4
7
.
.
.
```

and we want to place:

```text
8
```

There is already an `8`.

So the placement is invalid.

Code:

```java
for (int r = 0; r < 9; r++) {

    if (board[r][col] == num) {
        return false;
    }
}
```

---

# 19. Checking the 3 × 3 Box

Every Sudoku cell belongs to one of nine `3 × 3` boxes.

For example:

```text
┌───────┬───────┬───────┐
│ box 1 │ box 2 │ box 3 │
├───────┼───────┼───────┤
│ box 4 │ box 5 │ box 6 │
├───────┼───────┼───────┤
│ box 7 │ box 8 │ box 9 │
└───────┴───────┴───────┘
```

If we are at:

```text
row = 4
col = 7
```

the cell belongs to the middle-right box.

---

# 20. Finding the Box Start

The key formula is:

```java
int boxRow = (row / 3) * 3;
int boxCol = (col / 3) * 3;
```

Suppose:

```text
row = 4
col = 7
```

Then:

```text
row / 3 = 1
```

because integer division is used.

Therefore:

```text
boxRow = 1 * 3 = 3
```

For the column:

```text
7 / 3 = 2

boxCol = 2 * 3 = 6
```

So the box starts at:

```text
(3,6)
```

---

# 21. Why Integer Division Works

Rows:

```text
0 1 2 | 3 4 5 | 6 7 8
```

When divided by `3`:

```text
0/3 = 0
1/3 = 0
2/3 = 0

3/3 = 1
4/3 = 1
5/3 = 1

6/3 = 2
7/3 = 2
8/3 = 2
```

Then multiplying by `3` gives:

```text
0
3
6
```

which are exactly the starting indexes of the boxes.

---

# 22. Box Checking Code

```java
int boxRow = (row / 3) * 3;
int boxCol = (col / 3) * 3;

for (int r = boxRow; r < boxRow + 3; r++) {

    for (int c = boxCol; c < boxCol + 3; c++) {

        if (board[r][c] == num) {
            return false;
        }
    }
}
```

This checks all nine cells of the relevant box.

---

# 23. Complete `isValid()`

```java
private static boolean isValid(
        char[][] board,
        int row,
        int col,
        char num) {

    // Row
    for (int c = 0; c < 9; c++) {
        if (board[row][c] == num) {
            return false;
        }
    }

    // Column
    for (int r = 0; r < 9; r++) {
        if (board[r][col] == num) {
            return false;
        }
    }

    // Box
    int boxRow = (row / 3) * 3;
    int boxCol = (col / 3) * 3;

    for (int r = boxRow; r < boxRow + 3; r++) {
        for (int c = boxCol; c < boxCol + 3; c++) {

            if (board[r][c] == num) {
                return false;
            }
        }
    }

    return true;
}
```

Think of it as:

```text
Can I legally place this number here?

        |
        ├── Row okay?
        |
        ├── Column okay?
        |
        └── Box okay?

All okay
   ↓
true
```

---

# 24. Dry Run

Suppose we have:

```text
5 3 . | . 7 . | . . .
6 . . | 1 9 5 | . . .
. 9 8 | . . . | . 6 .
```

The first empty cell is:

```text
row = 0
col = 2
```

We try:

```text
1
```

Check:

```text
Row → no 1
Column → no 1
Box → no 1
```

So:

```text
1 is valid
```

Place:

```text
5 3 1 | . 7 . | . . .
```

Then:

```text
solve(board)
```

tries to solve the rest.

---

# 25. Suppose That Choice Eventually Fails

Imagine that after many recursive calls we reach:

```text
No valid number exists for some empty cell.
```

The deepest call returns:

```text
false
```

Then the previous call receives:

```text
false
```

and does:

```java
board[row][col] = '.';
```

This removes the earlier choice.

Then it tries:

```text
2
```

Maybe `2` eventually leads to a solution.

This is the power of recursive backtracking.

---

# 26. The Call Stack

Imagine:

```text
solve()
```

finds cell A.

It places:

```text
5
```

Then:

```text
solve()
```

finds cell B.

It places:

```text
7
```

Then:

```text
solve()
```

finds cell C.

It places:

```text
2
```

The stack looks conceptually like:

```text
solve(cell A = 5)
        ↓
solve(cell B = 7)
        ↓
solve(cell C = 2)
```

Suppose cell C leads to failure.

Then:

```text
solve(C) → false
```

returns to:

```text
solve(B)
```

which can undo B's choice and try another number.

---

# 27. Why Does the Board Change During Recursion?

The board is passed as:

```java
char[][] board
```

Java passes the reference value to the array object.

So all recursive calls operate on the same board.

For example:

```text
Call 1
board = same object

Call 2
board = same object

Call 3
board = same object
```

Therefore a placement made by one call is visible to deeper calls.

That's exactly what we want.

---

# 28. Why Must We Undo?

Because the board is shared.

Suppose:

```text
board[row][col] = '5';
```

Then recursion explores that choice.

If it fails:

```java
board[row][col] = '.';
```

must restore the board.

Otherwise the next attempt would see:

```text
5
```

even though that choice was already rejected.

So:

```text
Shared state
    ↓
Modify
    ↓
Recurse
    ↓
Undo
```

is essential.

---

# 29. The General Sudoku Pattern

The algorithm can be reduced to:

```java
boolean solve(board) {

    find empty cell;

    if no empty cell:
        return true;

    for every possible number:

        if number is valid:

            place number;

            if solve(board):
                return true;

            remove number;

    return false;
}
```

This is the most important thing to remember.

---

# 30. Sudoku vs N-Queens

The two problems look different, but their recursion is almost identical.

## N-Queens

```text
Find row
   ↓
Try every column
   ↓
Check safe
   ↓
Place queen
   ↓
Solve next row
   ↓
Remove queen
```

## Sudoku

```text
Find empty cell
   ↓
Try every number
   ↓
Check valid
   ↓
Place number
   ↓
Solve remaining cells
   ↓
Remove number
```

The pattern is:

```text
Find decision point
       ↓
Try choices
       ↓
Validate
       ↓
Recurse
       ↓
Undo
```

---

# 31. Sudoku Is More General

In N-Queens:

```text
One recursive level = one row
```

In Sudoku:

```text
One recursive level = one empty cell
```

The next decision point isn't necessarily at a predictable position.

That's why Sudoku is a slightly more advanced backtracking problem.

---

# 32. Choosing the Next Empty Cell

The basic solution chooses the **first empty cell**.

But we can improve it.

Instead of:

```text
Find first empty cell
```

we can choose:

> The empty cell with the fewest possible numbers.

This is called the:

```text
Minimum Remaining Values (MRV)
```

heuristic.

---

# 33. Why MRV Helps

Suppose:

```text
Cell A → 7 possible numbers
Cell B → 2 possible numbers
Cell C → 1 possible number
```

Which should we solve first?

Choose:

```text
Cell C
```

because it has only one possibility.

If that possibility causes a contradiction, we discover it early.

This produces stronger pruning.

---

# 34. Simple Example

Suppose:

```text
Cell A:
1 2 3 4 5

Cell B:
7 8

Cell C:
9
```

Trying Cell A first creates many branches.

Trying Cell C first creates only one branch.

So:

```text
Choose the most constrained cell first.
```

This is a general backtracking optimization.

---

# 35. Constraint Propagation

Sudoku is a **constraint satisfaction problem**.

Every placement changes what values are allowed elsewhere.

For example:

```text
Place 5
   ↓
Remove 5 from:
   ↓
same row
same column
same box
```

So every decision affects future choices.

This is called **constraint propagation**.

You don't need to implement advanced constraint propagation immediately.

Just understand the idea.

---

# 36. Optimizing `isValid()`

The basic solution scans:

```text
row → O(9)
column → O(9)
box → O(9)
```

Since Sudoku is fixed at `9 × 9`, this is effectively constant time.

But if we generalize the problem, we can track used numbers with:

```text
boolean[][] rows
boolean[][] columns
boolean[][] boxes
```

Then validity checks can be approximately:

```text
O(1)
```

---

# 37. Tracking Rows, Columns, and Boxes

We can maintain:

```java
boolean[][] rows = new boolean[9][10];
boolean[][] cols = new boolean[9][10];
boolean[][] boxes = new boolean[9][10];
```

For example:

```text
rows[3][5] = true
```

means:

> Row 3 already contains 5.

Similarly:

```text
cols[4][7] = true
```

means:

> Column 4 already contains 7.

---

# 38. Finding the Box Index

Instead of `(boxRow, boxCol)`, we can assign each box a number:

```text
0 1 2
3 4 5
6 7 8
```

The formula is:

```java
int box = (row / 3) * 3 + (col / 3);
```

For:

```text
row = 4
col = 7
```

we get:

```text
4 / 3 = 1
7 / 3 = 2

1 * 3 + 2 = 5
```

So the cell belongs to:

```text
box 5
```

---

# 39. Optimized Sudoku Structure

Conceptually:

```java
boolean[][] rows;
boolean[][] cols;
boolean[][] boxes;
```

Then:

```java
if (rows[row][num] ||
    cols[col][num] ||
    boxes[box][num]) {

    continue;
}
```

Place:

```java
rows[row][num] = true;
cols[col][num] = true;
boxes[box][num] = true;
```

Undo:

```java
rows[row][num] = false;
cols[col][num] = false;
boxes[box][num] = false;
```

This is much cleaner than repeatedly scanning the board.

---

# 40. Optimized Java Implementation

```java
public class SudokuSolver {

    private static final int SIZE = 9;

    private boolean[][] rows = new boolean[SIZE][10];
    private boolean[][] cols = new boolean[SIZE][10];
    private boolean[][] boxes = new boolean[SIZE][10];

    public boolean solveSudoku(char[][] board) {

        initialize(board);

        return solve(board);
    }

    private boolean solve(char[][] board) {

        int bestRow = -1;
        int bestCol = -1;
        int minOptions = 10;

        // Find the most constrained empty cell
        for (int row = 0; row < SIZE; row++) {

            for (int col = 0; col < SIZE; col++) {

                if (board[row][col] != '.') {
                    continue;
                }

                int box = getBox(row, col);

                int options = 0;

                for (int num = 1; num <= 9; num++) {

                    if (!rows[row][num]
                            && !cols[col][num]
                            && !boxes[box][num]) {

                        options++;
                    }
                }

                if (options < minOptions) {

                    minOptions = options;

                    bestRow = row;
                    bestCol = col;
                }
            }
        }

        // No empty cells
        if (bestRow == -1) {
            return true;
        }

        // No possible value
        if (minOptions == 0) {
            return false;
        }

        int box = getBox(bestRow, bestCol);

        for (int num = 1; num <= 9; num++) {

            if (rows[bestRow][num]
                    || cols[bestCol][num]
                    || boxes[box][num]) {

                continue;
            }

            // Choose
            board[bestRow][bestCol] =
                    (char) ('0' + num);

            rows[bestRow][num] = true;
            cols[bestCol][num] = true;
            boxes[box][num] = true;

            // Explore
            if (solve(board)) {
                return true;
            }

            // Undo
            board[bestRow][bestCol] = '.';

            rows[bestRow][num] = false;
            cols[bestCol][num] = false;
            boxes[box][num] = false;
        }

        return false;
    }

    private int getBox(int row, int col) {
        return (row / 3) * 3 + (col / 3);
    }

    private void initialize(char[][] board) {

        for (int row = 0; row < SIZE; row++) {

            for (int col = 0; col < SIZE; col++) {

                if (board[row][col] == '.') {
                    continue;
                }

                int num =
                        board[row][col] - '0';

                int box = getBox(row, col);

                rows[row][num] = true;
                cols[col][num] = true;
                boxes[box][num] = true;
            }
        }
    }
}
```

This version is more advanced.

You don't need to memorize it yet.

Understand the simpler version first.

---

# 41. Why Does the Optimized Version Work?

The basic version asks:

```text
"Is 5 already present in this row?"
```

by scanning the row.

The optimized version already knows:

```java
rows[row][5]
```

So it can answer immediately.

Same for:

```java
cols[col][5]
boxes[box][5]
```

This is an example of **maintaining state to avoid repeated work**.

---

# 42. A Very Important Backtracking Principle

You can often make backtracking faster by maintaining information about the current state.

Instead of repeatedly calculating:

```text
Is this choice valid?
```

you maintain:

```text
What choices are currently unavailable?
```

This principle appears in many advanced algorithms.

---

# 43. Boolean Arrays vs HashSet

You could also use:

```java
Set<Integer>
```

for:

```text
rows
columns
boxes
```

But because Sudoku values are only:

```text
1–9
```

boolean arrays are simple and fast.

For example:

```java
boolean[] used = new boolean[10];
```

Index:

```text
1 → number 1
2 → number 2
...
9 → number 9
```

Index `0` is unused.

---

# 44. The Search Tree

Imagine a Sudoku cell has:

```text
1, 4, 7
```

possible values.

Then the recursion branches:

```text
                    Cell
                 /    |    \
                1     4     7
                |     |     |
              solve solve solve
```

Suppose:

```text
1 → dead end
4 → dead end
7 → solution
```

Then:

```text
return true
```

propagates all the way back to the top.

---

# 45. Why Does `true` Propagate Up?

Suppose:

```text
solve(A)
```

chooses:

```text
5
```

Then calls:

```text
solve(B)
```

which chooses:

```text
7
```

Then:

```text
solve(C)
```

finds the complete solution.

So:

```text
solve(C) → true
```

Then:

```text
solve(B) → true
```

Then:

```text
solve(A) → true
```

Therefore:

```text
true
```

travels back through the call stack.

This is called **propagating the result through recursion**.

---

# 46. Why Doesn't It Try Other Solutions?

Because the problem usually asks for:

> A valid Sudoku solution.

Once one solution is found:

```java
return true;
```

immediately stops the search.

If the problem asked for:

> All possible Sudoku solutions,

then we would not stop at the first `true`.

We would collect solutions instead.

This is an important difference between:

```text
Find one solution
```

and:

```text
Generate all solutions
```

---

# 47. Sudoku vs Permutations

Permutation:

```text
for every choice:

    swap

    recurse

    swap back
```

Sudoku:

```text
for every number:

    if valid:

        place

        recurse

        remove
```

The structure is almost identical.

Only the state and constraints are different.

---

# 48. Sudoku vs N-Queens

N-Queens:

```text
for every column:

    if safe:

        place queen

        recurse(row + 1)

        remove queen
```

Sudoku:

```text
for every number:

    if valid:

        place number

        recurse()

        remove number
```

So you should start seeing the **pattern underneath the problem**.

---

# 49. Backtracking Template You Should Memorize

Not the code.

The thought process:

```text
1. Identify the decision point.
2. Identify possible choices.
3. Check whether a choice is valid.
4. Make the choice.
5. Recursively solve the smaller problem.
6. If it fails, undo the choice.
7. Try the next choice.
8. Stop when the problem is complete.
```

For Sudoku:

```text
Decision point → empty cell

Choices → 1 to 9

Constraint → row, column, box

Choice → place number

Recursive problem → solve remaining board

Undo → remove number

Completion → no empty cells
```

---

# 50. Common Mistakes

## Mistake 1 — Forgetting to Undo

Wrong:

```java
board[row][col] = num;

if (solve(board)) {
    return true;
}

// No undo
```

Correct:

```java
board[row][col] = num;

if (solve(board)) {
    return true;
}

board[row][col] = '.';
```

---

# 51. Mistake 2 — Returning `true` Immediately After Placement

Wrong:

```java
board[row][col] = num;

return true;
```

This only proves that the current placement is valid.

It does **not** prove the entire Sudoku can be solved.

You must recursively solve the remaining board:

```java
if (solve(board)) {
    return true;
}
```

---

# 52. Mistake 3 — Forgetting That `false` Means "Try Something Else"

When:

```java
solve(board)
```

returns:

```text
false
```

it doesn't mean the entire problem is impossible.

It means:

> **This particular choice was wrong.**

So:

```text
false
 ↓
undo
 ↓
try another choice
```

This is one of the most important ideas in backtracking.

---

# 53. Mistake 4 — Incorrect Box Calculation

Remember:

```java
int boxRow = (row / 3) * 3;
int boxCol = (col / 3) * 3;
```

or:

```java
int box = (row / 3) * 3 + (col / 3);
```

Don't try to memorize random formulas.

Understand that integer division groups rows and columns into blocks of three.

---

# 54. Mistake 5 — Checking Only Row and Column

A number can be valid in:

```text
row
column
```

but invalid in its:

```text
3 × 3 box
```

All three constraints must be checked.

---

# 55. Mistake 6 — Modifying the Original Given Numbers

Only modify:

```text
'.'
```

cells.

The original numbers are fixed constraints.

---

# 56. Complexity

Sudoku has a very large search space in the worst case.

A simple upper-bound intuition is:

```text
9^E
```

where `E` is the number of empty cells.

Why?

Each empty cell can theoretically have up to 9 choices.

But constraint checking and backtracking prune enormous numbers of branches.

So the practical search is much smaller than blindly exploring all `9^E` possibilities.

For interviews, it is reasonable to say:

```text
Worst-case: exponential
```

rather than pretending Sudoku has a simple polynomial complexity.

---

# 57. Space Complexity

The board itself is:

```text
9 × 9
```

which is constant-sized for standard Sudoku.

The recursion depth can be at most:

```text
81
```

because there are 81 cells.

So the recursion stack is:

```text
O(81)
```

which is effectively:

```text
O(1)
```

for fixed-size Sudoku.

For a generalized `N × N` version, the analysis would depend on `N`.

---

# 58. How to Recognize Sudoku-Type Problems

Look for:

```text
Fill a board
Place values under constraints
Find a valid configuration
Each choice affects neighboring choices
Try values and backtrack
```

These are strong signals for constraint-based backtracking.

---

# 59. Related Problems

Once you understand Sudoku, you can study:

* [ ] N-Queens
* [ ] Sudoku Solver
* [ ] Word Search
* [ ] Graph Coloring
* [ ] Knight's Tour
* [ ] Rat in a Maze
* [ ] Crossword Puzzle
* [ ] Letter Tile Possibilities
* [ ] Matchsticks to Square

All of these use variations of:

```text
Choose
Check
Explore
Undo
```

---

# 60. Practice Problems

### Level 1

* [ ] Implement Sudoku `isValid()`
* [ ] Find an empty cell
* [ ] Solve a Sudoku using recursion
* [ ] Print the solved board

### Level 2

* [ ] Track used numbers with boolean arrays
* [ ] Track rows, columns, and boxes
* [ ] Implement `getBox()`
* [ ] Return `boolean` from the recursive solver

### Level 3

* [ ] Choose the cell with minimum possibilities
* [ ] Implement MRV
* [ ] Optimize Sudoku with bitmasks

---

# 61. The Most Important Code to Understand

If you understand only one piece of code from this file, understand this:

```java
for (char num = '1'; num <= '9'; num++) {

    if (!isValid(board, row, col, num)) {
        continue;
    }

    board[row][col] = num;

    if (solve(board)) {
        return true;
    }

    board[row][col] = '.';
}

return false;
```

Read it in English:

```text
Try every number.

If the number is invalid:
    skip it.

Otherwise:
    place the number.

    Ask recursion:
        "Can you solve the remaining Sudoku?"

    If yes:
        return true.

    If no:
        remove my number.

After trying everything:
    return false.
```

If you understand that paragraph, you understand the core of the Sudoku solver.

---

# 62. The Complete Backtracking Pattern

You have now seen the same structure several times:

### Permutations

```text
Choose element
    ↓
Recurse
    ↓
Undo swap
```

### Combinations

```text
Choose element
    ↓
Recurse
    ↓
Remove element
```

### Subsets

```text
Include / Exclude
    ↓
Recurse
    ↓
Undo
```

### N-Queens

```text
Choose column
    ↓
Check constraints
    ↓
Place queen
    ↓
Recurse
    ↓
Remove queen
```

### Sudoku

```text
Choose number
    ↓
Check constraints
    ↓
Place number
    ↓
Recurse
    ↓
Remove number
```

---

# 63. The Big Picture

Your recursion learning path is now:

```text
                 RECURSION
                     |
          ┌──────────┴──────────┐
          ↓                     ↓
      Simple Recursion       Recursion Trees
          |                     |
          ↓                     ↓
     Factorial             Permutations
     Fibonacci             Combinations
     Binary Search         Subsets
                                |
                                ↓
                          BACKTRACKING
                                |
                  ┌─────────────┼─────────────┐
                  ↓             ↓             ↓
              N-Queens       Sudoku       Word Search
```

The important transition is:

```text
Recursion
   ↓
Make choices
   ↓
Check constraints
   ↓
Explore
   ↓
Undo
```

That is **backtracking**.

---

# 64. Final Mental Model

Whenever you see a problem where:

> "Try a choice, see whether it works, and if it doesn't work, go back and try something else."

Think:

```text
                    BACKTRACKING
                         |
                    Make a choice
                         ↓
                    Is it valid?
                     /       \
                   No        Yes
                   |           |
                 Skip        Choose
                               ↓
                           Recurse
                               ↓
                          Did it work?
                         /          \
                       Yes           No
                        |             |
                       Done         Undo
                                      |
                                      ↓
                               Try next choice
```

This is the pattern you should carry into interviews and LeetCode.

You now have enough foundation to move from **"I know recursion syntax"** to **"I can recognize and solve recursive search problems."**

The next file should focus on **`08-Backtracking.md`**, where we will stop treating backtracking as just individual problems and build a **general framework for recognizing, designing, debugging, and optimizing backtracking solutions in Java**.
