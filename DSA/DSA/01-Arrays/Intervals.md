# Intervals in Java

> Master interval problems using **Sorting + Greedy**.

---

# What is an Interval?

An interval represents a range.

```
[start, end]
```

Example

```
[1,3]

[2,6]

[8,10]

[15,18]
```

Each interval has

- Start
- End

---

# Types of Interval Problems

```
Intervals

│

├── Merge Intervals
├── Insert Interval
├── Remove Overlapping
├── Meeting Rooms
├── Employee Free Time
├── Minimum Arrows
├── Interval Intersection
└── Scheduling
```

---

# When Should You Think of Intervals?

Keywords

- Interval
- Range
- Meeting
- Schedule
- Booking
- Calendar
- Overlap
- Merge

Usually

```
Sort

↓

Traverse

↓

Merge
```

---

# Why Sort?

Input

```
[8,10]

[1,3]

[2,6]
```

Hard to process.

Sort

```
[1,3]

[2,6]

[8,10]
```

Now overlapping intervals are adjacent.

---

# Generic Template

```java
Arrays.sort(intervals,(a,b)->Integer.compare(a[0], b[0]));

List<int[]> answer = new ArrayList<>();

for(int[] current : intervals){

    if(answer.isEmpty()
        || answer.get(answer.size()-1)[1] < current[0]){

        answer.add(current);

    }else{

        answer.get(answer.size()-1)[1] =
            Math.max(answer.get(answer.size()-1)[1], current[1]);

    }

}

return answer.toArray(new int[answer.size()][]);
```

---

# Pattern 1

## Merge Intervals

LeetCode 56

Input

```
[1,3]

[2,6]

[8,10]

[15,18]
```

Output

```
[1,6]

[8,10]

[15,18]
```

Observation

```
Current Start

<=

Previous End

↓

Merge
```

Otherwise

```
New Interval
```

Complexity

```
Time

O(n log n)

Space

O(n)
```

---

# Dry Run

Sorted

```
[1,3]

[2,6]

[8,10]

[15,18]
```

Result

```
[1,3]

↓

Overlap

↓

[1,6]

↓

No Overlap

↓

[8,10]

↓

No Overlap

↓

[15,18]
```

---

# Pattern 2

## Insert Interval

LeetCode 57

Input

```
Intervals

[1,3]

[6,9]

Insert

[2,5]
```

Output

```
[1,5]

[6,9]
```

Algorithm

```
Add Left Intervals

↓

Merge Overlap

↓

Add Remaining
```

---

# Pattern 3

## Non-overlapping Intervals

LeetCode 435

Goal

Remove minimum intervals.

Greedy

Keep

```
Smallest Ending Interval
```

Complexity

```
O(n log n)
```

---

# Pattern 4

## Meeting Rooms

LeetCode 252

Question

Can one person attend every meeting?

Idea

Sort by start time.

If

```
Current Start

<

Previous End
```

Conflict

Return

```
false
```

---

# Pattern 5

## Meeting Rooms II

LeetCode 253

Need

Minimum meeting rooms.

Solution

Priority Queue.

```
Sort

↓

Min Heap

↓

Reuse Room

↓

Else

Create Room
```

Complexity

```
O(n log n)
```

---

# Pattern 6

## Minimum Number of Arrows

LeetCode 452

Observation

Sort by

```
Ending Point
```

Shoot arrow

↓

Remove overlapping balloons.

Greedy.

---

# Pattern 7

## Interval List Intersections

LeetCode 986

Observation

Two sorted interval lists.

Use

```
Two Pointers
```

Formula

```
Start

=

max(start1,start2)

End

=

min(end1,end2)
```

If

```
Start <= End

Intersection Exists
```

---

# Pattern 8

## Employee Free Time

Observation

Merge all schedules.

Find gaps.

---

# Generic Merge Algorithm

```
Sort

↓

First Interval

↓

For Every Interval

↓

Overlap?

↓

Merge

↓

Else

Add New Interval
```

---

# Generic Java Skeleton

```java
Arrays.sort(intervals,
    (a,b)->Integer.compare(a[0], b[0]));

List<int[]> result = new ArrayList<>();

for(int[] interval : intervals){

    if(result.isEmpty()){

        result.add(interval);

    }else{

        int[] last = result.get(result.size()-1);

        if(last[1] >= interval[0]){

            last[1] = Math.max(last[1], interval[1]);

        }else{

            result.add(interval);

        }

    }

}
```

---

# Pattern Recognition

Think Intervals when the problem says

- Merge
- Overlap
- Range
- Schedule
- Meeting
- Calendar
- Booking
- Time Slots

---

# Common Mistakes

## Mistake 1

Forgetting to sort.

Intervals almost always need sorting.

---

## Mistake 2

Comparing wrong values.

Correct

```
Last End

vs

Current Start
```

---

## Mistake 3

Using

```java
a[0]-b[0]
```

Comparator.

Safer

```java
Integer.compare(a[0], b[0]);
```

Avoids integer overflow.

---

## Mistake 4

Not updating

```
Maximum End
```

after merging.

---

# Complexity

| Problem | Time |
|----------|------|
| Merge | O(n log n) |
| Insert | O(n) |
| Remove Overlap | O(n log n) |
| Meeting Rooms | O(n log n) |
| Meeting Rooms II | O(n log n) |
| Intersections | O(n) |

---

# Interview Tips

Whenever you see intervals, ask

1. Do I need to sort?
2. Are intervals overlapping?
3. Can I merge them?
4. Is Greedy enough?
5. Do I need a Priority Queue?

---

# Practice Problems

## Easy

- LeetCode 252 – Meeting Rooms

## Medium

- LeetCode 56 – Merge Intervals
- LeetCode 57 – Insert Interval
- LeetCode 435 – Non-overlapping Intervals
- LeetCode 452 – Minimum Number of Arrows
- LeetCode 986 – Interval List Intersections
- LeetCode 253 – Meeting Rooms II

## Hard

- LeetCode 759 – Employee Free Time

---

# Decision Tree

```
Intervals

↓

Need Merge?

↓

Merge Intervals

↓

Need Insert?

↓

Insert Interval

↓

Need Remove?

↓

Greedy

↓

Need Rooms?

↓

Priority Queue

↓

Need Intersection?

↓

Two Pointers
```

---

# Summary

✅ Most interval problems begin with **sorting by start time**.

✅ Merge when

```
Current Start <= Previous End
```

✅ Common techniques:

- Sorting
- Greedy
- Two Pointers
- Priority Queue

✅ Master these interview problems:

- Merge Intervals
- Insert Interval
- Meeting Rooms
- Non-overlapping Intervals
- Minimum Arrows
- Interval Intersections