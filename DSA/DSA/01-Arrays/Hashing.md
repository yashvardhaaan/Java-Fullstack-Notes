# HashMap & HashSet in Java

---

# What is Hashing?

Hashing is a technique used to store and retrieve data in **O(1)** average time.

Instead of searching sequentially, a **hash function** converts a key into an index (bucket).

```
Key

↓

Hash Function

↓

Bucket Index

↓

Store Value
```

---

# What is HashMap?

A HashMap stores data as **Key → Value** pairs.

Example

```java
HashMap<String,Integer> marks = new HashMap<>();

marks.put("John",90);
marks.put("Alice",95);
marks.put("Bob",80);
```

Memory

```
John  → 90

Alice → 95

Bob   → 80
```

---

# HashMap Operations

Create

```java
HashMap<Integer,Integer> map = new HashMap<>();
```

Insert

```java
map.put(1,100);
```

Update

```java
map.put(1,200);
```

Get

```java
map.get(1);
```

Contains Key

```java
map.containsKey(1);
```

Remove

```java
map.remove(1);
```

Size

```java
map.size();
```

Empty

```java
map.isEmpty();
```

---

# Common Methods

```java
map.put(key,value);

map.get(key);

map.getOrDefault(key,0);

map.containsKey(key);

map.remove(key);

map.clear();

map.keySet();

map.values();

map.entrySet();
```

---

# Iterating HashMap

Using Keys

```java
for(Integer key : map.keySet()){

    System.out.println(key + " " + map.get(key));

}
```

Using EntrySet

```java
for(Map.Entry<Integer,Integer> entry : map.entrySet()){

    System.out.println(entry.getKey()+" "+entry.getValue());

}
```

---

# Time Complexity

| Operation | Average |
|------------|---------|
| Put | O(1) |
| Get | O(1) |
| Remove | O(1) |
| Contains | O(1) |

Worst Case

```
O(n)
```

---

# What is HashSet?

HashSet stores **only unique values**.

Duplicates are ignored.

```java
HashSet<Integer> set = new HashSet<>();

set.add(10);
set.add(20);
set.add(20);

System.out.println(set);
```

Output

```
10 20
```

---

# HashSet Operations

```java
set.add(5);

set.remove(5);

set.contains(5);

set.size();

set.clear();

set.isEmpty();
```

---

# Pattern 1

## Frequency Counting

Input

```
1 2 1 4 2 1
```

Output

```
1 → 3

2 → 2

4 → 1
```

Java

```java
HashMap<Integer,Integer> map = new HashMap<>();

for(int num : arr){

    map.put(num,map.getOrDefault(num,0)+1);

}
```

---

# Dry Run

```
1

{}

↓

{1=1}

↓

2

{1=1,2=1}

↓

1

{1=2,2=1}

↓

4

{1=2,2=1,4=1}
```

---

# Pattern 2

## Two Sum

LeetCode 1

Observation

Need fast lookup.

Java

```java
public int[] twoSum(int[] nums,int target){

    HashMap<Integer,Integer> map = new HashMap<>();

    for(int i=0;i<nums.length;i++){

        int remain = target-nums[i];

        if(map.containsKey(remain)){

            return new int[]{map.get(remain),i};

        }

        map.put(nums[i],i);

    }

    return new int[]{-1,-1};

}
```

Complexity

```
Time

O(n)

Space

O(n)
```

---

# Pattern 3

## Contains Duplicate

LeetCode 217

Java

```java
public boolean containsDuplicate(int[] nums){

    HashSet<Integer> set = new HashSet<>();

    for(int num : nums){

        if(set.contains(num))
            return true;

        set.add(num);

    }

    return false;

}
```

---

# Pattern 4

## Valid Anagram

LeetCode 242

Java

```java
public boolean isAnagram(String s,String t){

    if(s.length()!=t.length())
        return false;

    HashMap<Character,Integer> map = new HashMap<>();

    for(char c:s.toCharArray()){

        map.put(c,map.getOrDefault(c,0)+1);

    }

    for(char c:t.toCharArray()){

        if(!map.containsKey(c))
            return false;

        map.put(c,map.get(c)-1);

        if(map.get(c)==0){

            map.remove(c);

        }

    }

    return map.isEmpty();

}
```

---

# Pattern 5

## Group Anagrams

LeetCode 49

Observation

Sorted String

↓

Key

↓

HashMap

```
eat

↓

aet

↓

Map
```

---

# Pattern 6

## Longest Consecutive Sequence

LeetCode 128

Observation

HashSet

Start sequence only if

```
num-1

Does Not Exist
```

Time

```
O(n)
```

---

# Pattern 7

## Top K Frequent Elements

LeetCode 347

Steps

```
Frequency Map

↓

Bucket Sort / Heap

↓

Answer
```

---

# Pattern 8

## Prefix Sum + HashMap

LeetCode 560

Formula

```
Current Prefix

-

K

=

Previous Prefix
```

HashMap stores

```
Prefix Sum

↓

Frequency
```

---

# Pattern 9

## First Unique Character

LeetCode 387

```
Frequency

↓

Traverse Again

↓

First Frequency = 1
```

---

# Pattern 10

## Happy Number

LeetCode 202

Observation

Need to detect cycle.

Store visited numbers.

Use

```
HashSet
```

---

# Generic Templates

## Frequency Count

```java
HashMap<Integer,Integer> map = new HashMap<>();

for(int num : arr){

    map.put(num,map.getOrDefault(num,0)+1);

}
```

---

## Character Count

```java
HashMap<Character,Integer> map = new HashMap<>();

for(char c : s.toCharArray()){

    map.put(c,map.getOrDefault(c,0)+1);

}
```

---

## Duplicate Detection

```java
HashSet<Integer> set = new HashSet<>();

for(int num : arr){

    if(set.contains(num))
        return true;

    set.add(num);

}
```

---

## Fast Lookup

```java
if(map.containsKey(key)){

}
```

---

# Common Mistakes

## Mistake 1

```java
map.get(key)
```

When key doesn't exist.

May return

```
null
```

Better

```java
map.getOrDefault(key,0);
```

---

## Mistake 2

Forgetting

```java
map.put()
```

after updating count.

---

## Mistake 3

Using HashMap when order matters.

Use

```
LinkedHashMap
```

or

```
TreeMap
```

---

## Mistake 4

Confusing

```
contains()

with

containsKey()
```

HashMap uses

```java
containsKey()
```

---

# Pattern Recognition

Think HashMap when you see

- Frequency
- Count
- Duplicate
- Pair Sum
- Anagram
- Mapping
- Lookup
- Prefix Sum
- Grouping

Think HashSet when you see

- Unique
- Distinct
- Visited
- Duplicate Detection
- Cycle Detection

---

# Complexity

| Operation | HashMap | HashSet |
|------------|---------|---------|
| Insert | O(1) | O(1) |
| Search | O(1) | O(1) |
| Delete | O(1) | O(1) |

Worst Case

```
O(n)
```

---

# Interview Tips

Ask yourself

- Do I need fast lookup?
- Do I need frequency?
- Do I need uniqueness?
- Can I replace nested loops with a HashMap?

If yes

Think

```
HashMap
```

---

# Practice Problems

## Easy

- LeetCode 1 – Two Sum
- LeetCode 217 – Contains Duplicate
- LeetCode 242 – Valid Anagram
- LeetCode 387 – First Unique Character
- LeetCode 202 – Happy Number

## Medium

- LeetCode 49 – Group Anagrams
- LeetCode 128 – Longest Consecutive Sequence
- LeetCode 347 – Top K Frequent Elements
- LeetCode 560 – Subarray Sum Equals K
- LeetCode 525 – Contiguous Array
- LeetCode 930 – Binary Subarrays With Sum

## Hard

- LeetCode 76 – Minimum Window Substring
- LeetCode 30 – Substring with Concatenation of All Words

---

# Decision Tree

```
Problem

↓

Need Fast Lookup?

↓

Yes

↓

Need Frequency?

↓

HashMap

↓

Need Unique Elements?

↓

HashSet

↓

Need Order?

↓

LinkedHashMap / TreeMap
```

---

# Summary

✅ HashMap stores **Key → Value** pairs.

✅ HashSet stores **only unique elements**.

✅ HashMap is commonly used for:
- Frequency counting
- Fast lookups
- Pair problems
- Prefix Sum
- Grouping

✅ HashSet is commonly used for:
- Duplicate detection
- Unique elements
- Visited tracking
- Cycle detection

✅ Master these templates:
- Frequency Map
- Character Count
- Two Sum
- Duplicate Detection
- Prefix Sum + HashMap
- Grouping Problems