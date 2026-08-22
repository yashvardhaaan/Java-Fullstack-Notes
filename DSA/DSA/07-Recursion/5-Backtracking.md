# Recursion & Backtracking — N-Queens in Java

N-Queens is one of the most important problems for learning **backtracking**.

It combines almost everything you've learned so far:

```text
Recursion
   ↓
Choices
   ↓
Constraints
   ↓
Backtracking
   ↓
Undo
```

The main idea is:

> **Place one queen at a time, check whether the placement is valid, and backtrack whenever the choice leads to a dead end.**

---

# 1. What Is the N-Queens Problem?

You are given an `N × N` chessboard.

You need to place:

```text
N queens
```

such that **no two queens attack each other**.

A queen can attack another queen if they are in the same:

* Row
* Column
* Diagonal

Therefore, no two queens can share any of these.

---

# 2. Example — 4 Queens

For:

```text
N = 4
```

one valid arrangement is:

```text
. Q . .
. . . Q
Q . . .
. . Q .
```

Where:

```text
Q = Queen
. = Empty cell
```

There are actually **2 valid solutions** for `N = 4`.

---

# 3. The Three Rules

Every queen placement must satisfy:

```text
1. No same row
2. No same column
3. No same diagonal
```

For example:

```text
Q . . .
. . Q .
```

is invalid because the queens are on the same diagonal.

---

# 4. Why Is N-Queens a Backtracking Problem?

Suppose we place a queen:

```text
Q . . .
```

Then we try to place the next queen.

Maybe:

```text
Q . Q .
```

is invalid because they share a row.

Try another position:

```text
Q . . .
. . Q .
```

Maybe that causes a diagonal conflict later.

So we need to:

```text
Place queen
    ↓
Continue
    ↓
Conflict?
    ↓
YES
    ↓
Remove queen
    ↓
Try another position
```

This is exactly:

```text
Choose
  ↓
Explore
  ↓
Undo
```

---

# 5. The Most Important Insight

Don't think:

> "How do I place N queens at once?"

Instead think:

> "How do I place one queen safely?"

Then recursion handles the remaining rows.

This is the core recursive idea.

```text
solve(row)
```

means:

> "I need to place a queen somewhere in this row."

Once the queen is successfully placed:

```text
solve(row + 1)
```

handles the next row.

---

# 6. Why One Queen Per Row?

We can make the problem easier by deciding:

> Put exactly one queen in each row.

Then we don't need to check whether two queens share a row.

If:

```text
solve(row)
```

means:

> Place a queen in this row.

then every recursive level automatically handles a different row.

So only two conflicts remain:

```text
Column
Diagonal
```

This is a very important problem-solving technique:

> **Design the recursion so that one constraint is automatically satisfied.**

---

# 7. Basic Structure

The recursion looks like:

```text
solve(row)
    |
    ├── try column 0
    ├── try column 1
    ├── try column 2
    └── try column 3
```

For every possible column:

```text
Place queen
     ↓
Check whether safe
     ↓
solve(row + 1)
     ↓
Remove queen
```

---

# 8. Basic Java Solution

```java
import java.util.*;

public class NQueens {

    public static List<List<String>> solveNQueens(int n) {

        List<List<String>> result = new ArrayList<>();

        char[][] board = new char[n][n];

        // Initialize board
        for (int row = 0; row < n; row++) {
            Arrays.fill(board[row], '.');
        }

        backtrack(board, 0, result);

        return result;
    }

    private static void backtrack(
            char[][] board,
            int row,
            List<List<String>> result) {

        // All queens placed
        if (row == board.length) {
            result.add(createBoard(board));
            return;
        }

        // Try every column in this row
        for (int col = 0; col < board.length; col++) {

            // Check whether this position is safe
            if (!isSafe(board, row, col)) {
                continue;
            }

            // Choose
            board[row][col] = 'Q';

            // Explore
            backtrack(board, row + 1, result);

            // Undo
            board[row][col] = '.';
        }
    }

    private static boolean isSafe(
            char[][] board,
            int row,
            int col) {

        int n = board.length;

        // Check column
        for (int r = 0; r < row; r++) {
            if (board[r][col] == 'Q') {
                return false;
            }
        }

        // Check upper-left diagonal
        for (
                int r = row - 1, c = col - 1;
                r >= 0 && c >= 0;
                r--, c--
        ) {
            if (board[r][c] == 'Q') {
                return false;
            }
        }

        // Check upper-right diagonal
        for (
                int r = row - 1, c = col + 1;
                r >= 0 && c < n;
                r--, c++
        ) {
            if (board[r][c] == 'Q') {
                return false;
            }
        }

        return true;
    }

    private static List<String> createBoard(char[][] board) {

        List<String> result = new ArrayList<>();

        for (char[] row : board) {
            result.add(new String(row));
        }

        return result;
    }
}
```

Don't try to memorize this entire program.

Understand the structure first.

---

# 9. The Core Four Steps

The important section is:

```java
for (int col = 0; col < board.length; col++) {

    if (!isSafe(board, row, col)) {
        continue;
    }

    board[row][col] = 'Q';

    backtrack(board, row + 1, result);

    board[row][col] = '.';
}
```

Read it as:

```text
For every column:

    Is this position safe?

    If no:
        skip it

    If yes:
        place queen

        solve next row

        remove queen
```

That is N-Queens.

---

# 10. What Does `row` Mean?

This is extremely important.

```java
backtrack(board, row, result)
```

The parameter:

```text
row
```

means:

> "Which row am I currently trying to fill?"

For example:

```text
row = 0
```

means:

```text
Place queen in row 0
```

Then:

```text
row = 1
```

means:

```text
Place queen in row 1
```

Then:

```text
row = 2
```

and so on.

---

# 11. Base Case

The base case is:

```java
if (row == board.length)
```

Why?

Suppose:

```text
N = 4
```

Rows are:

```text
0
1
2
3
```

After successfully placing a queen in row `3`, we call:

```text
backtrack(row + 1)
```

which gives:

```text
row = 4
```

Now:

```text
row == board.length
```

means:

> All 4 queens have been successfully placed.

Therefore, we have found a solution.

---

# 12. The Recursion Tree

For `N = 4`, the first row has four choices:

```text
                    Row 0
              /       |       |       \
             C0       C1      C2       C3
```

Suppose we choose:

```text
Row 0 → Column 0
```

Then:

```text
Q . . .
```

Now move to row `1`.

We try:

```text
C0 → invalid
C1 → invalid
C2 → safe
C3 → safe
```

For example:

```text
Q . . .
. . Q .
```

Then continue to row `2`.

Every time a placement becomes impossible:

```text
backtrack
```

and try another column.

---

# 13. Why Do We Check Only Previous Rows?

Notice:

```java
for (int r = 0; r < row; r++)
```

when checking columns.

Why not check all rows?

Because rows after the current row are still empty.

We are building the board from:

```text
top → bottom
```

Therefore, only previous rows can contain queens.

This makes the checking simpler.

---

# 14. Checking the Column

Suppose:

```text
. Q . .
. . . .
. . . .
```

We want to place a queen at:

```text
row = 2
col = 1
```

But column `1` already contains a queen.

So:

```text
. Q . .
. . . .
. Q . .
```

is invalid.

The check:

```java
for (int r = 0; r < row; r++) {

    if (board[r][col] == 'Q') {
        return false;
    }
}
```

detects this.

---

# 15. Checking the Diagonal

There are two diagonals we need to check.

### Upper-left

```text
\ 
```

### Upper-right

```text
/
```

Because we're processing rows from top to bottom, only the **upper** diagonals can contain previously placed queens.

---

# 16. Upper-Left Diagonal

Starting from:

```text
row - 1
col - 1
```

we move:

```text
row--
col--
```

Code:

```java
for (
        int r = row - 1, c = col - 1;
        r >= 0 && c >= 0;
        r--, c--
) {
    if (board[r][c] == 'Q') {
        return false;
    }
}
```

Visually:

```text
. . . Q
. . Q .
. Q . .
Q . . .
```

Moving up-left means:

```text
↖
```

---

# 17. Upper-Right Diagonal

Starting from:

```text
row - 1
col + 1
```

we move:

```text
row--
col++
```

Code:

```java
for (
        int r = row - 1, c = col + 1;
        r >= 0 && c < n;
        r--, c++
) {
    if (board[r][c] == 'Q') {
        return false;
    }
}
```

Visually:

```text
Q . . .
. Q . .
. . Q .
. . . Q
```

Moving up-right means:

```text
↗
```

---

# 18. What Does `isSafe()` Really Ask?

The method:

```java
isSafe(board, row, col)
```

asks:

> "If I put a queen here, will it attack any queen that has already been placed?"

It checks:

```text
Column
   ↓
Diagonal ↖
   ↓
Diagonal ↗
```

If none contain a queen:

```text
return true;
```

Otherwise:

```text
return false;
```

---

# 19. Why Don't We Check the Current Row?

Because:

```text
solve(row)
```

only places one queen in that row.

The loop tries:

```text
col = 0
col = 1
col = 2
...
```

but only one position is selected before moving to:

```text
row + 1
```

Therefore, there can never be two queens in the same row.

---

# 20. Dry Run — N = 4

Let's understand the process conceptually.

Start:

```text
....
....
....
....
```

### Row 0

Try column `0`:

```text
Q...
....
....
....
```

Now row `1`.

---

# 21. Row 1

Try column `0`.

Invalid:

```text
Q...
Q...
....
....
```

Same column.

Try column `1`.

Invalid:

```text
Q...
.Q..
....
....
```

Same diagonal.

Try column `2`.

Safe:

```text
Q...
..Q.
....
....
```

Move to row `2`.

---

# 22. Row 2

Try possible positions.

Many will be invalid because of:

```text
Q...
..Q.
....
....
```

Eventually this branch reaches a point where no valid position exists.

That means:

```text
dead end
```

So we backtrack.

Remove the queen from row `1`:

```text
Q...
....
....
....
```

Then try the next possible column.

This continues until all possibilities have been explored.

---

# 23. What Does Backtracking Mean Here?

Suppose:

```text
Q...
..Q.
```

and later we discover:

```text
No valid position in next row
```

We don't throw away the entire board.

We undo only the most recent choice:

```text
..Q.
```

becomes:

```text
....
```

Then try:

```text
...Q
```

This is exactly:

```text
Choose
 ↓
Explore
 ↓
Dead end
 ↓
Undo
 ↓
Try next choice
```

---

# 24. The Most Important Difference From Subsets

In subsets:

```text
Include
Exclude
```

Every element has two obvious choices.

In N-Queens:

```text
Choose a column
```

There may be:

```text
N
```

possible choices at a row.

But invalid choices are rejected.

So the pattern becomes:

```text
for every possible choice:

    if choice is invalid:
        continue

    make choice
    recurse
    undo choice
```

This is the **general backtracking pattern**.

---

# 25. General Backtracking Template

You should know this pattern extremely well:

```java
void backtrack(state) {

    if (solutionFound) {
        saveSolution();
        return;
    }

    for (choice : choices) {

        if (!isValid(choice)) {
            continue;
        }

        // Choose
        makeChoice(choice);

        // Explore
        backtrack(nextState);

        // Undo
        undoChoice(choice);
    }
}
```

N-Queens fits perfectly:

```text
choice      → column
isValid     → isSafe()
makeChoice  → place Q
Explore     → next row
undoChoice  → remove Q
```

---

# 26. Optimizing N-Queens

The board-based solution repeatedly scans the board.

We can make it faster by keeping track of:

```text
columns
diagonals
```

using sets or boolean arrays.

For example:

```java
boolean[] columns;
boolean[] diagonal1;
boolean[] diagonal2;
```

Then checking whether a position is safe becomes approximately:

```text
O(1)
```

instead of scanning the board.

---

# 27. Column Tracking

Suppose:

```text
columns[col] == true
```

means:

> A queen already exists in this column.

Then:

```java
if (columns[col]) {
    continue;
}
```

means:

> Don't place another queen in this column.

When placing:

```java
columns[col] = true;
```

When backtracking:

```java
columns[col] = false;
```

---

# 28. Diagonal Tracking

This is one of the most important N-Queens concepts.

There are two types of diagonals.

For:

```text
\
```

we can identify a diagonal using:

```text
row - col
```

For:

```text
/
```

we can identify a diagonal using:

```text
row + col
```

This is a very useful grid/backtracking trick.

---

# 29. Why `row - col`?

Consider:

```text
\ 
```

diagonal cells:

```text
(0,0)
(1,1)
(2,2)
(3,3)
```

Calculate:

```text
row - col
```

```text
0 - 0 = 0
1 - 1 = 0
2 - 2 = 0
3 - 3 = 0
```

They all have the same value.

Therefore:

```text
row - col
```

identifies a `\` diagonal.

---

# 30. Why `row + col`?

Consider:

```text
/
```

diagonal cells:

```text
(0,3)
(1,2)
(2,1)
(3,0)
```

Calculate:

```text
row + col
```

```text
0 + 3 = 3
1 + 2 = 3
2 + 1 = 3
3 + 0 = 3
```

They all have the same value.

Therefore:

```text
row + col
```

identifies a `/` diagonal.

---

# 31. Optimized Java Solution

```java
import java.util.*;

public class NQueens {

    public static List<List<String>> solveNQueens(int n) {

        List<List<String>> result = new ArrayList<>();

        char[][] board = new char[n][n];

        for (int row = 0; row < n; row++) {
            Arrays.fill(board[row], '.');
        }

        boolean[] columns = new boolean[n];

        boolean[] diagonal1 = new boolean[2 * n - 1];

        boolean[] diagonal2 = new boolean[2 * n - 1];

        backtrack(
                0,
                n,
                board,
                columns,
                diagonal1,
                diagonal2,
                result
        );

        return result;
    }

    private static void backtrack(
            int row,
            int n,
            char[][] board,
            boolean[] columns,
            boolean[] diagonal1,
            boolean[] diagonal2,
            List<List<String>> result) {

        if (row == n) {
            result.add(createBoard(board));
            return;
        }

        for (int col = 0; col < n; col++) {

            int d1 = row - col + n - 1;
            int d2 = row + col;

            if (columns[col] ||
                    diagonal1[d1] ||
                    diagonal2[d2]) {

                continue;
            }

            // Choose
            board[row][col] = 'Q';

            columns[col] = true;
            diagonal1[d1] = true;
            diagonal2[d2] = true;

            // Explore
            backtrack(
                    row + 1,
                    n,
                    board,
                    columns,
                    diagonal1,
                    diagonal2,
                    result
            );

            // Undo
            board[row][col] = '.';

            columns[col] = false;
            diagonal1[d1] = false;
            diagonal2[d2] = false;
        }
    }

    private static List<String> createBoard(char[][] board) {

        List<String> result = new ArrayList<>();

        for (char[] row : board) {
            result.add(new String(row));
        }

        return result;
    }
}
```

---

# 32. Why `row - col + n - 1`?

There is one problem.

For:

```text
row - col
```

the result can be negative.

For example:

```text
row = 0
col = 3
```

gives:

```text
0 - 3 = -3
```

Array indices cannot be negative.

So we shift the value:

```text
row - col + n - 1
```

For `n = 4`:

```text
-3 + 3 = 0
```

So all diagonal indexes become valid array indexes.

---

# 33. Why Are There `2n - 1` Diagonals?

An `N × N` board has:

```text
2N - 1
```

diagonals in each direction.

For:

```text
N = 4
```

there are:

```text
7
```

diagonals.

Therefore:

```java
boolean[] diagonal1 = new boolean[2 * n - 1];
boolean[] diagonal2 = new boolean[2 * n - 1];
```

---

# 34. Complexity

The naive solution can explore approximately:

```text
O(N!)
```

arrangements in the worst case.

Why?

For the first row:

```text
N choices
```

Second row:

```text
N - 1 choices
```

Third row:

```text
N - 2 choices
```

and so on.

So roughly:

```text
N × (N-1) × (N-2) × ... × 1
```

which is:

```text
N!
```

The exact practical behavior is reduced by pruning invalid choices.

---

# 35. Space Complexity

The recursion depth is:

```text
N
```

so recursion stack:

```text
O(N)
```

The board requires:

```text
O(N²)
```

space.

The result itself can be large because there may be many valid boards.

---

# 36. What Is Pruning?

Pruning means:

> **Stop exploring a branch as soon as you know it cannot produce a valid solution.**

For example:

```text
Q...
....
..Q.
```

Suppose the current position is attacked.

We immediately do:

```java
continue;
```

We don't explore that branch.

Without pruning:

```text
Explore everything
     ↓
Check later
```

With pruning:

```text
Check early
     ↓
Invalid?
     ↓
STOP
```

Pruning is one of the biggest reasons backtracking can work despite having a huge search space.

---

# 37. Backtracking vs Brute Force

Brute force might try:

```text
Every possible placement
```

and check whether the final board is valid.

Backtracking says:

```text
Try a placement
     ↓
Already invalid?
     ↓
Stop immediately
```

So:

```text
Backtracking = Search + Pruning
```

This is an extremely useful way to think about it.

---

# 38. N = 1

For:

```text
N = 1
```

the answer is:

```text
Q
```

There is one solution.

---

# 39. N = 2

For:

```text
N = 2
```

there is no solution.

Why?

Any two queens will attack each other.

Therefore:

```text
[]
```

---

# 40. N = 3

For:

```text
N = 3
```

there is also no solution.

Again:

```text
[]
```

---

# 41. N = 4

For:

```text
N = 4
```

there are:

```text
2
```

solutions.

One is:

```text
.Q..
...Q
Q...
..Q.
```

The other is:

```text
..Q.
Q...
...Q
.Q..
```

---

# 42. Why N-Queens Is Important

N-Queens teaches several general programming concepts:

### Recursion

```text
solve(row + 1)
```

### Backtracking

```text
place
explore
remove
```

### Constraint checking

```text
isSafe()
```

### Pruning

```text
if invalid → continue
```

### State management

```text
board
columns
diagonals
```

These same ideas appear in many other problems.

---

# 43. Where Else Is This Pattern Used?

The same structure appears in:

```text
N-Queens
Sudoku
Maze solving
Graph coloring
Word search
Combination Sum
Permutations
Subsets
Palindrome partitioning
Knight's Tour
```

The problem changes.

The pattern remains:

```text
Choose
 ↓
Check constraint
 ↓
Explore
 ↓
Undo
```

---

# 44. How to Recognize Backtracking Problems

Look for wording such as:

```text
Find all possible solutions
Generate all valid arrangements
Place objects under constraints
Try every possible choice
Find all valid configurations
Return all possible combinations
```

Especially when:

> A choice can lead to a dead end and you need to undo it.

That's a strong signal for backtracking.

---

# 45. The N-Queens Template

For future problems, remember:

```java
void backtrack(state) {

    if (complete) {
        saveAnswer();
        return;
    }

    for (choice : possibleChoices) {

        if (!valid(choice)) {
            continue;
        }

        // Choose
        makeChoice(choice);

        // Explore
        backtrack(nextState);

        // Undo
        undoChoice(choice);
    }
}
```

N-Queens:

```text
state
→ current row

choice
→ column

valid
→ column + diagonals

makeChoice
→ place Q

nextState
→ next row

undoChoice
→ remove Q
```

---

# 46. The Most Important Mental Model

When solving N-Queens, don't think:

> "I need to find the final board."

Think:

> "I'm currently deciding where to place the queen in this row."

Then:

```text
Current row
     ↓
Try column 0
     ↓
Safe?
   /   \
 No    Yes
 |      |
Skip   Place
         ↓
      Next row
         ↓
      Eventually
      return
         ↓
      Remove
         ↓
      Try next column
```

That is backtracking.

---

# 47. Practice Problems

Solve these in order.

### Beginner

* [ ] Solve N-Queens for `N = 4`
* [ ] Count solutions for N-Queens
* [ ] Implement `isSafe()`
* [ ] Solve N-Queens using a `char[][]` board

### Intermediate

* [ ] Optimize using column tracking
* [ ] Optimize using diagonal tracking
* [ ] Count N-Queens solutions without storing boards
* [ ] Solve N-Queens using `HashSet`

### Advanced

* [ ] N-Queens II
* [ ] Sudoku Solver
* [ ] Word Search
* [ ] Graph Coloring
* [ ] Knight's Tour

---

# 48. What You Must Understand Before Sudoku

Before moving to Sudoku, you should be able to explain:

```text
1. Why do we process one row at a time?

2. What does row represent?

3. Why is row == n the base case?

4. Why do we try every column?

5. What makes a position invalid?

6. Why do we only check previous rows?

7. Why do we remove the queen after recursion?

8. What is pruning?

9. Why does row - col identify one diagonal?

10. Why does row + col identify the other diagonal?
```

If you understand these, you're ready for Sudoku.

---

# 49. The Recursion Progression

Your understanding should now look like this:

```text
                    RECURSION
                        |
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
        Basic      Permutations    Subsets
                        |             |
                        └──────┬──────┘
                               ↓
                         Combinations
                               |
                               ↓
                         BACKTRACKING
                               |
                               ↓
                           N-QUEENS
                               |
                               ↓
                            SUDOKU
```

The key progression is:

```text
Simple recursion
      ↓
Make choices
      ↓
Explore choices
      ↓
Undo choices
      ↓
Check constraints
      ↓
Prune invalid branches
      ↓
Advanced backtracking
```

That is the real purpose of the N-Queens problem.
