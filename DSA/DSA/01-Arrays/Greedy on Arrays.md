# Greedy Algorithms on Arrays

> Make the **best local choice** at every step, hoping it leads to the global optimum.

---

# What is a Greedy Algorithm?

A Greedy Algorithm always chooses the **best possible option at the current step** without reconsidering previous choices.

Unlike Dynamic Programming, Greedy **does not backtrack**.

---

# Greedy Strategy

```
Current State

↓

Choose Best Option

↓

Move Forward

↓

Never Look Back
```

---

# When Should You Think of Greedy?

Keywords

- Maximum
- Minimum
- Fewest
- Largest
- Smallest
- Earliest
- Latest
- Can Reach
- Schedule
- Interval

---

# How to Identify Greedy Problems?

Ask yourself

```
Can I make the best decision now

without affecting future decisions?
```

If YES

↓

Greedy might work.

---

# Greedy vs Dynamic Programming

| Greedy | Dynamic Programming |
|----------|---------------------|
| Local Optimum | Global Optimum |
| No Recalculation | Reuses Previous States |
| Faster | Usually Slower |
| Easier | Harder |

---

# Pattern 1

## Best Time to Buy and Sell Stock

LeetCode 121

Input

```
7 1 5 3 6 4
```

Output

```
5
```

Observation

Track

```
Minimum Price

↓

Maximum Profit
```

Java

```java
public int maxProfit(int[] prices){

    int min = Integer.MAX_VALUE;
    int profit = 0;

    for(int price : prices){

        min = Math.min(min,price);

        profit = Math.max(profit,price-min);

    }

    return profit;

}
```

Complexity

```
Time : O(n)

Space : O(1)
```

---

# Pattern 2

## Jump Game

LeetCode 55

Question

Can you reach the last index?

Observation

Track the

```
Farthest Reachable Index
```

Java

```java
public boolean canJump(int[] nums){

    int reach = 0;

    for(int i=0;i<nums.length;i++){

        if(i>reach)
            return false;

        reach = Math.max(reach,i+nums[i]);

    }

    return true;

}
```

---

# Pattern 3

## Jump Game II

LeetCode 45

Need

```
Minimum Jumps
```

Observation

Treat every jump like exploring a level.

Track

```
Current End

↓

Farthest Reach
```

Complexity

```
O(n)
```

---

# Pattern 4

## Gas Station

LeetCode 134

Observation

If total gas < total cost

↓

Impossible

Otherwise

Track

```
Current Fuel

↓

Negative?

↓

Start From Next Station
```

---

# Pattern 5

## Assign Cookies

LeetCode 455

Steps

```
Sort Children

↓

Sort Cookies

↓

Give Smallest Possible Cookie
```

Java

```java
Arrays.sort(g);
Arrays.sort(s);

int child = 0;
int cookie = 0;

while(child < g.length && cookie < s.length){

    if(s[cookie] >= g[child]){

        child++;

    }

    cookie++;

}

return child;
```

---

# Pattern 6

## Candy

LeetCode 135

Observation

Two passes.

```
Left → Right

↓

Right → Left
```

Need

```
Max(left,right)
```

---

# Pattern 7

## Partition Labels

LeetCode 763

Observation

Store

```
Last Occurrence

↓

Expand Current Partition

↓

Cut Partition
```

---

# Pattern 8

## Lemonade Change

LeetCode 860

Observation

Always use

```
$10

+

$5

before

Three $5 Bills
```

Greedy works.

---

# Pattern 9

## Maximum Units on a Truck

LeetCode 1710

Observation

Sort

↓

Highest Units First

↓

Take Maximum

---

# Generic Greedy Template

```java
Sort if required

↓

Traverse

↓

Take Best Choice

↓

Update Answer

↓

Continue
```

---

# Dry Run

Example

Jump Game

```
2 3 1 1 4

Reach = 0

↓

Reach = 2

↓

Reach = 4

↓

Reach = 4

↓

Reach = 8

Reached End
```

---

# Pattern Recognition

Think Greedy when the problem says

- Minimum
- Maximum
- Earliest
- Latest
- Can Reach
- Fewest
- Largest
- Smallest
- Scheduling
- Interval

---

# Common Mistakes

## Mistake 1

Using Greedy when future decisions matter.

Sometimes DP is required.

---

## Mistake 2

Not proving why Greedy works.

Interviewers may ask

```
Why is this always optimal?
```

Be ready to explain.

---

## Mistake 3

Forgetting to sort.

Many Greedy problems begin with

```
Sort

↓

Greedy
```

---

# Complexity

| Problem | Time |
|----------|------|
| Best Stock | O(n) |
| Jump Game | O(n) |
| Jump Game II | O(n) |
| Assign Cookies | O(n log n) |
| Gas Station | O(n) |
| Lemonade Change | O(n) |
| Candy | O(n) |
| Partition Labels | O(n) |

---

# Interview Tips

Ask yourself

- Can I make the best choice now?
- Will this choice never become worse later?
- Is sorting required first?
- Can I prove my choice is always optimal?

If yes,

Think

```
Greedy
```

---

# Practice Problems

## Easy

- LeetCode 121 – Best Time to Buy and Sell Stock
- LeetCode 455 – Assign Cookies
- LeetCode 860 – Lemonade Change

## Medium

- LeetCode 45 – Jump Game II
- LeetCode 55 – Jump Game
- LeetCode 134 – Gas Station
- LeetCode 763 – Partition Labels
- LeetCode 1710 – Maximum Units on a Truck

## Hard

- LeetCode 135 – Candy
- LeetCode 630 – Course Schedule III

---

# Decision Tree

```
Problem

↓

Need Maximum / Minimum?

↓

Can Local Best Choice Work?

↓

Yes

↓

Greedy

↓

Need Sorting?

↓

Sort First

↓

Apply Greedy
```

---

# Summary

✅ Greedy chooses the best local option at every step.

✅ It does **not** reconsider previous decisions.

✅ Many Greedy problems start with sorting.

✅ Master these interview problems:

- Best Time to Buy and Sell Stock
- Jump Game
- Jump Game II
- Gas Station
- Assign Cookies
- Candy
- Partition Labels
- Lemonade Change