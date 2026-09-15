# `09-IO-Scheduling.md`

# I/O Scheduling — GATE CSE 2027

## 1. What is I/O Scheduling?

**I/O scheduling** decides the order in which pending I/O requests, especially **disk requests**, are serviced.

For GATE, the most important part is:

$$
\boxed{\text{Disk Scheduling}}
$$

> Main objective: reduce disk head movement and therefore reduce seek time.

---

# 2. Disk Structure ⭐⭐⭐⭐⭐

A magnetic disk contains:

```text
Platter
   ↓
Tracks
   ↓
Sectors
```

Multiple tracks at the same radius across platters form a:

$$
\boxed{\text{Cylinder}}
$$

### Important terms

| Term      | Meaning                        |
| --------- | ------------------------------ |
| Platter   | Circular magnetic disk surface |
| Track     | Circular path on surface       |
| Sector    | Subdivision of a track         |
| Cylinder  | Set of corresponding tracks    |
| Disk head | Reads/writes data              |
| Seek      | Move head to required track    |

---

# 3. Disk Access Time ⭐⭐⭐⭐⭐

Disk access time can be viewed as:

$$
\boxed{
T_{access}
=
T_{seek}
+
T_{rotational}
+
T_{transfer}
+
T_{queue}
}
$$

Depending on the question, not every component is included.

### Seek Time

Time required to move disk head to the desired track.

### Rotational Latency

Time waiting for the desired sector to rotate under the head.

### Transfer Time

Time to actually transfer data.

---

# 4. Seek Time — GATE Favorite ⭐⭐⭐⭐⭐

If head moves from cylinder \(a\) to cylinder \(b\):

$$
\boxed{\text{Head movement}=|a-b|}
$$

If it services:

```text
50 → 20 → 80 → 40
```

total movement:

$$
|50-20|+|20-80|+|80-40|
$$

$$
=30+60+40
$$

$$
\boxed{130\ cylinders}
$$

### 🔥 GATE Trap

Do **not** calculate:

$$
80-20
$$

unless the head actually moves directly between them.

Always follow the **service order**.

---

# 5. Disk Scheduling Algorithms ⭐⭐⭐⭐⭐

The major algorithms:

1. FCFS
2. SSTF
3. SCAN
4. C-SCAN
5. LOOK
6. C-LOOK

These are extremely important for GATE numericals.

---

# 6. FCFS Disk Scheduling ⭐⭐⭐⭐⭐

**First Come First Serve**

Service requests in their arrival order.

Example:

```text
Head = 50

Requests:
82, 170, 43, 140
```

Order:

```text
50 → 82 → 170 → 43 → 140
```

Total movement:

$$
|50-82|+|82-170|+|170-43|+|43-140|
$$

$$
=32+88+127+97
$$

$$
\boxed{344}
$$

### Advantages

* Simple
* Fair
* No starvation due to scheduling order

### Disadvantage

* Large head movement possible

---

# 7. SSTF ⭐⭐⭐⭐⭐

**Shortest Seek Time First**

Choose the request **closest to the current head position**.

Example:

```text
Current = 50

Requests:
40, 82, 170, 43
```

Distances:

```text
40 → 10
43 → 7
82 → 32
170 → 120
```

Choose:

$$
\boxed{43}
$$

Now current position = 43.

Recalculate distances from 43.

### 🔥 Golden Rule

> SSTF always chooses the **nearest pending request from the current head position**.

---

# 8. SSTF Problem — Starvation ⭐⭐⭐⭐⭐

Suppose requests continuously arrive near the current head.

```text
Head = 50

Requests:
49, 51, 48, 52, ...
```

A request at 150 might keep getting postponed.

Therefore:

$$
\boxed{\text{SSTF can cause starvation}}
$$

### GATE shortcut

```text
SSTF → low average seek time
SSTF → possible starvation
```

---

# 9. SCAN ⭐⭐⭐⭐⭐

SCAN is also called the:

$$
\boxed{\text{Elevator Algorithm}}
$$

The disk head moves in one direction, servicing requests along the way.

When it reaches the **end of the disk**, it reverses direction.

Example:

```text
0 ----------------------------- 199
                 ↑
                Head
                 →
```

It services requests while moving right:

```text
50 → 60 → 90 → 120 → 150 → 199
```

then reverses:

```text
199 → 140 → 80 → 20
```

---

# 10. Why SCAN?

Compared with SSTF, SCAN provides more predictable waiting behavior.

It avoids the strong tendency of SSTF to favor requests close to the current head.

### 🔥 Trick

> **SCAN goes all the way to the disk end before reversing.**

---

# 11. C-SCAN ⭐⭐⭐⭐⭐

**Circular SCAN**

The head moves in **one direction only** while servicing requests.

When it reaches one end:

```text
→ end
↓
jump to beginning
↓
→ continue
```

Example:

```text
0 ----------------------------- 199
→ → → → → → → → → → → → → → →
199
↓
jump
0
→ → → → → → → → → →
```

### Important

The return from end to beginning does **not service requests** during the return.

---

# 12. SCAN vs C-SCAN

| SCAN                     | C-SCAN                               |
| ------------------------ | ------------------------------------ |
| Moves both directions    | Services in one direction            |
| Reverses at end          | Jumps back to beginning              |
| Elevator-like            | Circular                             |
| Services while returning | Return path doesn't service requests |

### 🔥 GATE Shortcut

```text
SCAN  → go + reverse
C-SCAN → go + jump
```

---

# 13. LOOK ⭐⭐⭐⭐⭐

LOOK is similar to SCAN but does **not go all the way to the physical disk end** if no request exists there.

Instead:

> Reverse at the **last pending request** in that direction.

Example:

```text
Requests up to 180
Head = 50
```

LOOK goes:

```text
50 → ... → 180
```

then reverses.

It does not need to go to cylinder 199.

### 🔥 Trick

$$
\boxed{LOOK = SCAN\ without\ unnecessary\ end\ movement}
$$

---

# 14. C-LOOK ⭐⭐⭐⭐⭐

C-LOOK is the circular version of LOOK.

Head:

```text
→ services requests
→ reaches highest request
→ jumps to lowest request
→ continues
```

It does not travel to the physical disk ends unnecessarily.

### Shortcut

```text
SCAN   → end + reverse
LOOK   → last request + reverse

C-SCAN  → end + jump
C-LOOK  → last request + jump
```

---

# 15. All Algorithms at a Glance

| Algorithm | Direction             | Reaches physical end? | Starvation? |
| --------- | --------------------- | --------------------: | ----------: |
| FCFS      | Request order         |          Not relevant |           ❌ |
| SSTF      | Nearest request       |                    No |  ✅ Possible |
| SCAN      | Both directions       |                 ✅ Yes |         Low |
| C-SCAN    | One service direction |                 ✅ Yes |         Low |
| LOOK      | Both directions       |                  ❌ No |         Low |
| C-LOOK    | One service direction |                  ❌ No |         Low |

---

# 16. Disk Scheduling Example ⭐⭐⭐⭐⭐

Suppose:

```text
Disk: 0–199
Head: 50
Direction: right

Requests:
82, 170, 43, 140, 24, 16, 190
```

Sorted:

```text
16, 24, 43, 82, 140, 170, 190
```

---

## FCFS

Order:

```text
50 → 82 → 170 → 43 → 140 → 24 → 16 → 190
```

Calculate each movement.

---

## SSTF

Start at 50:

Nearest:

```text
43
```

Then from 43:

```text
24
```

Then:

```text
16
```

Then:

```text
82
```

and continue by repeatedly choosing the closest pending request.

### Important

You **must recalculate after every movement**.

---

# 17. SCAN Example

Head = 50, direction = right.

Requests greater than 50:

```text
82, 140, 170, 190
```

SCAN:

```text
50 → 82 → 140 → 170 → 190 → 199
```

Then reverse:

```text
199 → 43 → 24 → 16
```

### Important

Even though 190 is the highest request, SCAN goes to:

$$
\boxed{199}
$$

because SCAN reaches the physical disk end.

---

# 18. LOOK Example

Same situation.

LOOK:

```text
50 → 82 → 140 → 170 → 190
```

Then immediately reverses:

```text
190 → 43 → 24 → 16
```

It does **not** go to 199.

---

# 19. C-SCAN Example

Head = 50, direction = right.

Service:

```text
50 → 82 → 140 → 170 → 190 → 199
```

Then:

```text
199 → 0
```

Then continue:

```text
0 → 16 → 24 → 43
```

### 🔥 Trap

The jump:

$$
199\rightarrow0
$$

is counted as head movement if the question asks for total head movement.

---

# 20. C-LOOK Example

Head = 50, direction = right.

Service:

```text
50 → 82 → 140 → 170 → 190
```

Then jump to lowest pending request:

```text
190 → 16
```

Then:

```text
16 → 24 → 43
```

It doesn't travel to 199 or 0 unnecessarily.

---

# 21. Important GATE Difference

### SCAN

```text
request → request → END → reverse
```

### LOOK

```text
request → request → LAST REQUEST → reverse
```

### C-SCAN

```text
request → END → jump to START → request
```

### C-LOOK

```text
request → LAST REQUEST → jump to FIRST REQUEST
```

Memorize this diagram:

```text
SCAN:
→ → → END ← ← ←

LOOK:
→ → → LAST ← ← ←

C-SCAN:
→ → → END ↘ START → → →

C-LOOK:
→ → → LAST ↘ FIRST → → →
```

---

# 22. Rotational Latency ⭐⭐⭐⭐

After reaching the correct track, the desired sector may not immediately be under the head.

The disk must rotate.

For a disk rotating at:

$$
RPM
$$

Time for one complete rotation:

$$
\boxed{
T_{rotation}=\frac{60}{RPM}\ seconds
}
$$

---

# 23. Average Rotational Latency ⭐⭐⭐⭐⭐

Assuming the desired sector is uniformly distributed:

$$
\boxed{
T_{avg\ rotational}=
\frac{1}{2}T_{rotation}
}
$$

Therefore:

$$
\boxed{
T_{avg\ rotational}=
\frac{30}{RPM}\ seconds
}
$$

### Example

Disk speed:

$$
6000\ RPM
$$

One rotation:

$$
\frac{60}{6000}=0.01s
$$

$$
=10ms
$$

Average rotational latency:

$$
\boxed{5ms}
$$

---

# 24. Disk Access Time Example

Suppose:

```text
Seek time = 8 ms
Average rotational latency = 4 ms
Transfer time = 2 ms
```

Then:

$$
T_{access}=8+4+2
$$

$$
\boxed{14ms}
$$

If queueing time is also given, include it.

---

# 25. Disk Transfer Time ⭐⭐⭐⭐

If one revolution transfers:

$$
N
$$

bytes and disk rotates at \(RPM\):

Time per revolution:

$$
\frac{60}{RPM}
$$

Therefore transfer rate:

$$
\boxed{
Transfer\ Rate=
\frac{N}{60/RPM}
}
$$

or:

$$
\boxed{
Transfer\ Rate=N\times\frac{RPM}{60}
}
$$

---

# 26. GATE Numerical Strategy ⭐⭐⭐⭐⭐

For disk scheduling questions:

### Step 1

Write:

```text
Disk range
Head position
Request queue
Initial direction
```

### Step 2

Choose the algorithm.

### Step 3

Write the **exact service sequence**.

### Step 4

Calculate:

$$
\boxed{
Total\ Head\ Movement
=
\sum |Position_i-Position_{i-1}|
}
$$

### Step 5

Only then calculate average/total time if required.

---

# 27. 🔥 Direction Matters

Suppose:

```text
Head = 50
Requests = 20, 80
```

If direction = right:

```text
50 → 80 → 20
```

If direction = left:

```text
50 → 20 → 80
```

Therefore:

> **SCAN/LOOK/C-SCAN/C-LOOK require the initial direction.**

If direction isn't specified, check the question carefully for another convention.

---

# 28. GATE PYQ Pattern — SSTF

Typical question gives:

```text
Initial head
Request sequence
```

and asks:

> Total number of cylinders traversed under SSTF?

### Method

Always:

```text
Current head
 ↓
Find nearest pending request
 ↓
Move there
 ↓
Recalculate
 ↓
Repeat
```

### 🔥 Don't sort once and blindly follow it.

SSTF is **dynamic**.

---

# 29. GATE PYQ Pattern — SCAN vs LOOK

Typical question:

> Head is moving toward higher-numbered cylinders. There are no requests after cylinder 170. Disk ends at 199. Where does SCAN reverse?

Answer:

$$
\boxed{199}
$$

Where does LOOK reverse?

$$
\boxed{170}
$$

---

# 30. GATE PYQ Pattern — C-SCAN

Typical question:

> Under C-SCAN, what happens after reaching the highest cylinder?

Answer:

```text
Go to opposite end
→ resume service in same direction
```

The key is:

$$
\boxed{\text{No servicing while moving back}}
$$

---

# 31. GATE PYQ Pattern — Rotational Latency

Given:

$$
RPM=7200
$$

Time per revolution:

$$
\frac{60}{7200}
=
0.008333s
$$

$$
=8.333ms
$$

Average rotational latency:

$$
\frac{8.333}{2}
$$

$$
\boxed{4.167ms}
$$

---

# 32. GATE PYQ Pattern — Total Disk Access

Typical:

```text
Seek = 5 ms
Rotation = 10,000 RPM
Transfer = 1 ms
```

First:

$$
T_{rotation}=\frac{60}{10000}=6ms
$$

Average rotational latency:

$$
3ms
$$

Total:

$$
5+3+1
$$

$$
\boxed{9ms}
$$

---

# 33. 🔥 GATE Traps

### Trap 1

> SSTF guarantees no starvation.

❌ False.

---

### Trap 2

> SCAN reverses at the last request.

❌ That's **LOOK**.

---

### Trap 3

> LOOK goes to physical disk end.

❌ It reverses at the last request.

---

### Trap 4

> C-SCAN services requests in both directions.

❌ Service occurs in one direction.

---

### Trap 5

> C-LOOK goes to cylinder 0.

❌ It jumps from highest pending request to lowest pending request.

---

### Trap 6

> Average rotational latency = one full rotation.

❌

$$
\boxed{\text{Average}=\frac12\text{ rotation}}
$$

---

### Trap 7

> Cylinder movement = sector movement.

❌ Disk scheduling usually measures **cylinder/head movement**.

---

### Trap 8

> Initial direction doesn't matter.

❌ It matters for SCAN, C-SCAN, LOOK and C-LOOK.

---

### Trap 9

> SCAN and LOOK are identical.

❌ SCAN reaches the physical end; LOOK doesn't.

---

# 🎯 GATE Priority

| Topic                      | Priority |
| -------------------------- | -------: |
| Disk scheduling numericals |    ⭐⭐⭐⭐⭐ |
| SSTF                       |    ⭐⭐⭐⭐⭐ |
| SCAN                       |    ⭐⭐⭐⭐⭐ |
| C-SCAN                     |    ⭐⭐⭐⭐⭐ |
| LOOK                       |    ⭐⭐⭐⭐⭐ |
| C-LOOK                     |    ⭐⭐⭐⭐⭐ |
| FCFS disk scheduling       |     ⭐⭐⭐⭐ |
| Seek time                  |    ⭐⭐⭐⭐⭐ |
| Rotational latency         |    ⭐⭐⭐⭐⭐ |
| Disk access time           |     ⭐⭐⭐⭐ |
| Disk structure             |      ⭐⭐⭐ |
| Transfer time              |      ⭐⭐⭐ |

---

# 🧠 One Diagram to Memorize

```text
                DISK SCHEDULING

FCFS
→ arrival order

SSTF
→ nearest request

SCAN
→ → → END ← ← ←
      ↑
    reverse

LOOK
→ → → LAST REQUEST ← ← ←

C-SCAN
→ → → END
         ↓
       START
→ → → → →

C-LOOK
→ → → LAST REQUEST
          ↓
       FIRST REQUEST
→ → → → →
```

---

# ⚡ 30-Second Revision

```text
Disk:
Track → circular path
Sector → subdivision of track
Cylinder → corresponding tracks

Disk access:
Seek + Rotational latency + Transfer (+ Queue)

Head movement:
|current - next|

FCFS:
→ request order
→ simple
→ high movement possible

SSTF:
→ nearest pending request
→ low seek time
→ starvation possible

SCAN:
→ elevator
→ moves both directions
→ reaches physical end
→ reverses

C-SCAN:
→ one service direction
→ reaches end
→ jumps to beginning
→ continues same direction

LOOK:
→ like SCAN
→ reverses at last request
→ doesn't go to physical end

C-LOOK:
→ like C-SCAN
→ jumps from highest request to lowest request
→ doesn't go to physical ends

Rotation:
Trotation = 60/RPM seconds

Average rotational latency:
= 30/RPM seconds

Total movement:
Σ |Pi - Pi-1|
```

### ⭐ GATE Priority: **5/5**

## 🔥 Absolute must-remember

$$
\boxed{SSTF=\text{Nearest}}
$$

$$
\boxed{SCAN=\text{End + Reverse}}
$$

$$
\boxed{LOOK=\text{Last Request + Reverse}}
$$

$$
\boxed{C\!-\!SCAN=\text{End + Jump + Same Direction}}
$$

$$
\boxed{C\!-\!LOOK=\text{Last Request + Jump + Same Direction}}
$$

$$
\boxed{T_{avg\ rotational}=\frac{30}{RPM}\ sec}
$$

➡️ **Next: `10-Memory-Management.md`**
