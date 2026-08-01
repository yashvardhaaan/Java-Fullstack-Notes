# 🚀 Java DSA Templates

> A collection of reusable Java templates for coding interviews and LeetCode.

---

# 1. Fast Input

```java
import java.util.*;

Scanner sc = new Scanner(System.in);

int n = sc.nextInt();
```

---

# 2. Array Input

```java
int n = sc.nextInt();

int[] arr = new int[n];

for(int i = 0; i < n; i++){
    arr[i] = sc.nextInt();
}
```

---

# 3. 2D Array Input

```java
int rows = sc.nextInt();
int cols = sc.nextInt();

int[][] matrix = new int[rows][cols];

for(int i = 0; i < rows; i++){

    for(int j = 0; j < cols; j++){

        matrix[i][j] = sc.nextInt();

    }

}
```

---

# 4. Array Traversal

```java
for(int num : arr){

    System.out.print(num + " ");

}
```

---

# 5. Binary Search

```java
int left = 0;
int right = arr.length - 1;

while(left <= right){

    int mid = left + (right-left)/2;

    if(arr[mid] == target){

        return mid;

    }else if(arr[mid] < target){

        left = mid + 1;

    }else{

        right = mid - 1;

    }

}

return -1;
```

---

# 6. Two Pointers

```java
int left = 0;
int right = arr.length - 1;

while(left < right){

    if(condition){

        left++;

    }else{

        right--;

    }

}
```

---

# 7. Sliding Window (Fixed)

```java
int left = 0;
int sum = 0;

for(int right = 0; right < arr.length; right++){

    sum += arr[right];

    if(right-left+1 > k){

        sum -= arr[left];
        left++;

    }

    if(right-left+1 == k){

        // Update Answer

    }

}
```

---

# 8. Sliding Window (Variable)

```java
int left = 0;

for(int right = 0; right < arr.length; right++){

    // Expand Window

    while(condition){

        // Shrink Window

        left++;

    }

    // Update Answer

}
```

---

# 9. Prefix Sum

```java
int[] prefix = new int[arr.length];

prefix[0] = arr[0];

for(int i = 1; i < arr.length; i++){

    prefix[i] = prefix[i-1] + arr[i];

}
```

---

# 10. HashMap Frequency

```java
HashMap<Integer,Integer> map = new HashMap<>();

for(int num : arr){

    map.put(num,map.getOrDefault(num,0)+1);

}
```

---

# 11. Character Frequency

```java
HashMap<Character,Integer> map = new HashMap<>();

for(char c : s.toCharArray()){

    map.put(c,map.getOrDefault(c,0)+1);

}
```

---

# 12. HashSet

```java
HashSet<Integer> set = new HashSet<>();

for(int num : arr){

    if(set.contains(num)){

        return true;

    }

    set.add(num);

}
```

---

# 13. Stack

```java
Stack<Integer> stack = new Stack<>();

stack.push(10);

stack.pop();

stack.peek();

stack.isEmpty();
```

---

# 14. Queue

```java
Queue<Integer> queue = new LinkedList<>();

queue.offer(10);

queue.poll();

queue.peek();

queue.isEmpty();
```

---

# 15. Priority Queue (Min Heap)

```java
PriorityQueue<Integer> pq = new PriorityQueue<>();

pq.offer(10);

pq.poll();

pq.peek();
```

---

# 16. Max Heap

```java
PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
```

---

# 17. DFS (Tree)

```java
public void dfs(TreeNode root){

    if(root == null)
        return;

    dfs(root.left);

    dfs(root.right);

}
```

---

# 18. DFS (Graph)

```java
public void dfs(int node){

    visited[node] = true;

    for(int next : graph[node]){

        if(!visited[next]){

            dfs(next);

        }

    }

}
```

---

# 19. BFS

```java
Queue<Integer> queue = new LinkedList<>();

queue.offer(start);

visited[start] = true;

while(!queue.isEmpty()){

    int node = queue.poll();

    for(int next : graph[node]){

        if(!visited[next]){

            visited[next] = true;

            queue.offer(next);

        }

    }

}
```

---

# 20. Matrix DFS

```java
int[] dx = {-1,1,0,0};
int[] dy = {0,0,-1,1};

void dfs(int row,int col){

    if(outOfBounds)
        return;

    dfs(row+1,col);

    dfs(row-1,col);

    dfs(row,col+1);

    dfs(row,col-1);

}
```

---

# 21. Union Find

```java
int[] parent = new int[n];

for(int i = 0; i < n; i++){

    parent[i] = i;

}
```

Find

```java
int find(int x){

    if(parent[x] == x)
        return x;

    return parent[x] = find(parent[x]);

}
```

Union

```java
void union(int a,int b){

    parent[find(a)] = find(b);

}
```

---

# 22. Backtracking

```java
void backtrack(){

    if(baseCase){

        return;

    }

    for(...){

        choose();

        backtrack();

        undo();

    }

}
```

---

# 23. Dynamic Programming

```java
int[] dp = new int[n];

dp[0] = ...;

for(int i = 1; i < n; i++){

    dp[i] = ...;

}
```

---

# 24. Memoization

```java
int solve(int n){

    if(baseCase)
        return ...;

    if(dp[n] != -1)
        return dp[n];

    return dp[n] = solve(...);

}
```

---

# 25. Sorting

```java
Arrays.sort(arr);
```

Descending

```java
Arrays.sort(arr, Collections.reverseOrder());
```

---

# 26. Comparator

```java
Arrays.sort(arr,(a,b)->a[0]-b[0]);
```

---

# 27. StringBuilder

```java
StringBuilder sb = new StringBuilder();

sb.append("Hello");

sb.reverse();

sb.toString();
```

---

# 28. Common Math

Maximum

```java
Math.max(a,b);
```

Minimum

```java
Math.min(a,b);
```

Power

```java
Math.pow(a,b);
```

Absolute

```java
Math.abs(x);
```

---

# 29. Common Arrays Utility

```java
Arrays.sort(arr);

Arrays.fill(arr,-1);

Arrays.toString(arr);

Arrays.equals(arr1,arr2);
```

---

# 30. Interview Checklist

Before submitting:

- Handle null input
- Handle empty input
- Handle single element
- Check index bounds
- Analyze Time Complexity
- Analyze Space Complexity
- Dry run once

---

# Pattern → Template Map

| Pattern | Template |
|----------|----------|
| Traversal | for Loop |
| Sorted Search | Binary Search |
| Pair Problems | Two Pointers |
| Contiguous | Sliding Window |
| Range Sum | Prefix Sum |
| Frequency | HashMap |
| Duplicate | HashSet |
| Parentheses | Stack |
| Shortest Path | BFS |
| Connected Components | DFS |
| Top K | Priority Queue |
| Merge Sets | Union Find |
| Generate All | Backtracking |
| Optimization | Dynamic Programming |

---

# Quick Revision

✅ Binary Search → `while(left <= right)`

✅ Two Pointers → `left`, `right`

✅ Sliding Window → `left`, `right`

✅ Prefix Sum → `prefix[i]`

✅ HashMap → `getOrDefault()`

✅ Stack → `push()`, `pop()`

✅ Queue → `offer()`, `poll()`

✅ Heap → `PriorityQueue`

✅ DFS → Recursion

✅ BFS → Queue

✅ DP → `dp[]`