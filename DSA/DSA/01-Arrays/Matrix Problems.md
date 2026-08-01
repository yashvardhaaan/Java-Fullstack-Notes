# Matrix in Java

---

# What is a Matrix?

A matrix is a **2D array** consisting of rows and columns.

Example

```
Rows = 3
Columns = 4

1  2  3  4
5  6  7  8
9 10 11 12
```

Declaration

```java
int[][] matrix = new int[3][4];
```

Initialization

```java
int[][] matrix = {
    {1,2,3},
    {4,5,6},
    {7,8,9}
};
```

---

# Matrix Visualization

```
      Column

      0   1   2

0     1   2   3

1     4   5   6

2     7   8   9

Row
```

Access

```
matrix[row][column]
```

Example

```java
matrix[1][2]
```

Output

```
6
```

---

# Matrix Traversal

## Row Wise Traversal

```java
for(int i=0;i<matrix.length;i++){

    for(int j=0;j<matrix[0].length;j++){

        System.out.print(matrix[i][j]+" ");

    }

}
```

Output

```
1 2 3
4 5 6
7 8 9
```

Complexity

```
Time : O(rows × cols)

Space : O(1)
```

---

# Column Wise Traversal

```java
for(int j=0;j<matrix[0].length;j++){

    for(int i=0;i<matrix.length;i++){

        System.out.print(matrix[i][j]+" ");

    }

}
```

Output

```
1 4 7

2 5 8

3 6 9
```

---

# Reverse Traversal

```java
for(int i=matrix.length-1;i>=0;i--){

    for(int j=matrix[0].length-1;j>=0;j--){

        System.out.print(matrix[i][j]+" ");

    }

}
```

---

# Diagonal Traversal

Main Diagonal

```
1 2 3

4 5 6

7 8 9

↓

1 5 9
```

Java

```java
for(int i=0;i<matrix.length;i++){

    System.out.print(matrix[i][i]+" ");

}
```

---

Secondary Diagonal

```
1 2 3

4 5 6

7 8 9

↓

3 5 7
```

Java

```java
int n = matrix.length;

for(int i=0;i<n;i++){

    System.out.print(matrix[i][n-i-1]+" ");

}
```

---

# Matrix Transpose

Original

```
1 2 3

4 5 6

7 8 9
```

Transpose

```
1 4 7

2 5 8

3 6 9
```

Java

```java
public static void transpose(int[][] matrix){

    int n = matrix.length;

    for(int i=0;i<n;i++){

        for(int j=i+1;j<n;j++){

            int temp = matrix[i][j];

            matrix[i][j]=matrix[j][i];

            matrix[j][i]=temp;

        }

    }

}
```

Complexity

```
Time : O(n²)

Space : O(1)
```

---

# Rotate Matrix 90°

LeetCode 48

Steps

```
Transpose

↓

Reverse Every Row
```

Java

```java
public void rotate(int[][] matrix){

    transpose(matrix);

    for(int[] row : matrix){

        int left=0;

        int right=row.length-1;

        while(left<right){

            int temp=row[left];

            row[left]=row[right];

            row[right]=temp;

            left++;

            right--;

        }

    }

}
```

---

# Spiral Matrix

LeetCode 54

Visualization

```
1 2 3

8 9 4

7 6 5

↓

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

Template

```java
int top=0;
int bottom=rows-1;

int left=0;
int right=cols-1;

while(top<=bottom && left<=right){

    // Left → Right

    // Top → Bottom

    // Right → Left

    // Bottom → Top

}
```

---

# Search in 2D Matrix

LeetCode 74

Observation

Treat matrix as a sorted array.

Binary Search

```
row = mid / cols

col = mid % cols
```

Complexity

```
O(log(rows×cols))
```

---

# Set Matrix Zeroes

LeetCode 73

Idea

Store rows and columns containing zero.

Better Solution

Use first row and first column as markers.

Complexity

```
O(m×n)

Space O(1)
```

---

# Prefix Sum Matrix

Formula

```
prefix[i][j]

=

Top

+

Left

-

Diagonal

+

Current
```

Used in

- Range Sum Query
- Image Processing

---

# Grid DFS/BFS

Movement Arrays

```java
int[] dx={-1,1,0,0};

int[] dy={0,0,-1,1};
```

Directions

```
Up

Down

Left

Right
```

Useful in

- Number of Islands
- Flood Fill
- Rotten Oranges

---

# Flood Fill

LeetCode 733

Template

```java
dfs(row,col){

    Check Bounds

    Check Visited

    Process

    Explore 4 Directions

}
```

---

# Number of Islands

LeetCode 200

Observation

Every island

↓

One DFS/BFS

Count Components

Complexity

```
O(rows×cols)
```

---

# Rotten Oranges

LeetCode 994

Observation

Need shortest time.

Think

```
Multi-source BFS
```

---

# Generic Matrix Traversal

```java
for(int i=0;i<rows;i++){

    for(int j=0;j<cols;j++){

        // Process matrix[i][j]

    }

}
```

---

# Common Patterns

| Pattern | Problems |
|----------|----------|
| Traversal | Print Matrix |
| Transpose | Rotate Matrix |
| Spiral | Spiral Matrix |
| Binary Search | Search Matrix |
| Prefix Sum | Range Sum |
| DFS | Islands |
| BFS | Rotten Oranges |
| Simulation | Set Matrix Zeroes |

---

# Common Mistakes

## Mistake 1

Using

```java
matrix.length
```

for columns.

Correct

```java
matrix[0].length
```

---

## Mistake 2

Not checking boundaries.

Always verify

```java
row>=0

row<rows

col>=0

col<cols
```

---

## Mistake 3

Forgetting visited array in DFS/BFS.

---

## Mistake 4

Confusing row and column.

Remember

```
matrix[row][column]
```

---

# Complexity

| Operation | Time |
|------------|------|
| Traversal | O(m×n) |
| Transpose | O(n²) |
| Rotate | O(n²) |
| Spiral | O(m×n) |
| Search Matrix | O(log(m×n)) |
| DFS/BFS | O(m×n) |

---

# Interview Tips

Ask yourself

- Is it row-wise or column-wise?
- Can I use two loops?
- Is it a graph problem disguised as a matrix?
- Can I move in four directions?
- Is Binary Search possible?

---

# Practice Problems

## Easy

- LeetCode 867 – Transpose Matrix
- LeetCode 566 – Reshape Matrix
- LeetCode 1572 – Matrix Diagonal Sum

## Medium

- LeetCode 54 – Spiral Matrix
- LeetCode 48 – Rotate Image
- LeetCode 73 – Set Matrix Zeroes
- LeetCode 74 – Search a 2D Matrix
- LeetCode 240 – Search a 2D Matrix II

## Graph on Matrix

- LeetCode 200 – Number of Islands
- LeetCode 695 – Max Area of Island
- LeetCode 733 – Flood Fill
- LeetCode 994 – Rotten Oranges
- LeetCode 542 – 01 Matrix
- LeetCode 130 – Surrounded Regions

---

# Matrix Decision Tree

```
Problem

↓

2D Array?

↓

Need Traversal?

↓

Two Loops

↓

Need Rotation?

↓

Transpose + Reverse

↓

Need Search?

↓

Binary Search

↓

Need Neighbors?

↓

DFS / BFS

↓

Need Range Sum?

↓

2D Prefix Sum
```

---

# Summary

✅ Matrix is a 2D array accessed as `matrix[row][column]`.

✅ Master:
- Row-wise Traversal
- Column-wise Traversal
- Diagonal Traversal
- Transpose
- Rotate Matrix
- Spiral Traversal
- Binary Search in Matrix
- DFS/BFS on Grid
- 2D Prefix Sum

✅ Matrix problems often combine arrays, graph traversal, and simulation.