# `12-File-Systems.md`

# File Systems — GATE CSE 2027

## 1. What is a File System? ⭐⭐⭐⭐⭐

A **file system** is the OS mechanism used to organize, store, access, and manage files on secondary storage.

> It converts the physical disk into a logical structure of **files + directories**.

```text id="fs01"
Application
    ↓
File System
    ↓
Disk / SSD
```

---

# 2. File

A **file** is a named collection of related information stored on secondary storage.

Examples:

```text id="fs02"
program.c
data.txt
image.jpg
```

A file has:

* Name
* Type
* Size
* Location
* Permissions
* Timestamps
* Ownership

---

# 3. File Attributes ⭐⭐⭐⭐

Typical attributes:

| Attribute  | Meaning                      |
| ---------- | ---------------------------- |
| Name       | File name                    |
| Identifier | Unique internal ID           |
| Type       | File type                    |
| Location   | Storage location             |
| Size       | File size                    |
| Protection | Access permissions           |
| Time       | Creation/modification/access |
| Owner      | User/process owner           |

---

# 4. File Operations ⭐⭐⭐⭐⭐

Common operations:

```text id="fs03"
create
open
read
write
seek
close
delete
truncate
```

### `open()`

Opens a file and returns a file descriptor/handle.

### `read()`

Reads data.

### `write()`

Writes data.

### `seek()`

Moves the current file position.

### `close()`

Releases the open-file resources.

---

# 5. File Descriptor ⭐⭐⭐⭐⭐

A **file descriptor (FD)** is a small integer used by a process to refer to an open file.

Typical Unix/Linux:

```text id="fs04"
0 → stdin
1 → stdout
2 → stderr
```

Example:

```text id="fs05"
fd = open("data.txt")
```

The process uses `fd` for subsequent operations.

### 🔥 GATE Trap

> File descriptor = physical disk block number.

❌ No.

It identifies an **open file entry** maintained by the OS.

---

# 6. Open File Table

The OS maintains information about currently opened files.

Conceptually:

```text id="fs06"
Process
   |
File Descriptor Table
   |
Open File Table
   |
File metadata / inode
   |
Data blocks
```

The exact implementation varies by OS.

---

# 7. File Access Methods ⭐⭐⭐⭐⭐

Three important access methods:

### 1. Sequential Access

Data is processed in order.

```text id="fs07"
1 → 2 → 3 → 4 → 5
```

Good for:

* tapes
* logs
* sequential processing

---

### 2. Direct / Random Access

Any block/record can be accessed directly.

```text id="fs08"
1 → 5 → 2 → 9
```

Useful for:

* databases
* disk files

---

### 3. Indexed Access

An index helps locate records.

```text id="fs09"
Index
 ↓
Record
```

---

# 8. Sequential vs Direct Access

| Sequential               | Direct                   |
| ------------------------ | ------------------------ |
| Process in order         | Jump to desired location |
| Simple                   | Faster random access     |
| Good for sequential data | Good for databases       |

### 🔥 GATE

> Direct access does **not** mean physically accessing disk with zero seek time.

It means the file interface allows jumping to a desired position.

---

# 9. Directory ⭐⭐⭐⭐⭐

A directory maps file names to information used to locate/manage files.

Conceptually:

```text id="fs10"
Directory
├── A.txt
├── B.txt
└── C.txt
```

A directory may contain:

```text id="fs11"
File name → inode / metadata reference
```

---

# 10. Directory Structures ⭐⭐⭐⭐⭐

Important types:

1. Single-level
2. Two-level
3. Tree-structured
4. Acyclic graph
5. General graph

---

# 11. Single-Level Directory

All files exist in one directory.

```text id="fs12"
ROOT
├── A
├── B
├── C
```

### Problem

Two users cannot easily have files with the same name.

---

# 12. Two-Level Directory

Each user has a separate directory.

```text id="fs13"
ROOT
├── User1
│   ├── A
│   └── B
└── User2
    ├── A
    └── C
```

Now both users can have:

```text
A
```

without conflict.

---

# 13. Tree-Structured Directory ⭐⭐⭐⭐⭐

Directories can contain subdirectories.

```text id="fs14"
/
├── home
│   ├── user1
│   └── user2
├── bin
└── etc
```

This is the common hierarchical organization.

---

# 14. Acyclic-Graph Directory ⭐⭐⭐⭐

Allows sharing of files/directories while preventing cycles.

```text id="fs15"
       A
      / \
     B   C
      \ /
       D
```

`D` can be shared.

But no cyclic path is allowed.

---

# 15. General Graph Directory ⭐⭐⭐⭐

Cycles are allowed.

```text id="fs16"
A → B → C
↑       ↓
└───────┘
```

Problem:

* infinite traversal
* difficult deletion
* garbage collection may be required

---

# 16. Path Names ⭐⭐⭐⭐⭐

### Absolute Path

Starts from root.

```text id="fs17"
/home/user/a.txt
```

### Relative Path

Starts from current directory.

```text id="fs18"
../data/a.txt
```

### 🔥 GATE

```text
Absolute → root
Relative → current directory
```

---

# 17. File Allocation

File allocation determines how file blocks are placed on disk.

Major methods:

1. Contiguous allocation
2. Linked allocation
3. Indexed allocation

---

# 18. Contiguous Allocation ⭐⭐⭐⭐⭐

A file occupies consecutive disk blocks.

Example:

```text id="fs19"
File A:
[10][11][12][13][14]
```

Directory stores:

```text
Starting block = 10
Length = 5
```

---

## Advantages

* Very fast sequential access
* Very fast direct access
* Simple
* Good locality

## Disadvantages

* External fragmentation
* File growth can be difficult

---

# 19. Contiguous Allocation Address Calculation ⭐⭐⭐⭐⭐

Suppose:

```text
Starting block = 100
Block size = 4 KB
```

File block number:

$$
i=5
$$

Physical block:

$$
100+5
$$

$$
\boxed{105}
$$

### 🔥 GATE Shortcut

For contiguous allocation:

$$
\boxed{Physical\ Block=Start+i}
$$

---

# 20. Linked Allocation ⭐⭐⭐⭐⭐

File blocks can be located anywhere on disk.

Each block contains a pointer to the next block.

```text id="fs20"
[10] → [27] → [4] → [91] → NULL
```

Directory stores the first block.

---

## Advantages

* No external fragmentation
* File can grow easily

## Disadvantages

* Poor random access
* Pointer overhead
* Reliability issue if pointer is corrupted

---

# 21. Linked Allocation Access

To access block \(i\), you generally follow the chain:

```text id="fs21"
Start
 ↓
Block 1
 ↓
Block 2
 ↓
...
 ↓
Block i
```

Therefore random access is slow.

### 🔥 GATE

$$
\boxed{\text{Linked allocation → sequential access is natural}}
$$

---

# 22. FAT ⭐⭐⭐⭐

**File Allocation Table (FAT)** stores the linked-list pointers in a separate table rather than inside each data block.

Conceptually:

```text id="fs22"
FAT:

Block 10 → 27
Block 27 → 4
Block 4  → 91
Block 91 → EOF
```

This improves traversal compared with storing pointers directly in data blocks.

---

# 23. Indexed Allocation ⭐⭐⭐⭐⭐

Each file has an **index block** containing pointers to its data blocks.

```text id="fs23"
          Index Block
        /    |    |    \
       ↓     ↓    ↓     ↓
      10     25   41    90
```

Directory points to the index block.

---

## Advantages

* Direct access possible
* No external fragmentation
* File blocks can be anywhere

## Disadvantages

* Index-block overhead
* Large files may need multiple levels/index blocks

---

# 24. Allocation Comparison ⭐⭐⭐⭐⭐

| Feature                | Contiguous | Linked | Indexed |
| ---------------------- | ---------- | ------ | ------- |
| Consecutive blocks     | ✅          | ❌      | ❌       |
| External fragmentation | Possible   | No     | No      |
| Sequential access      | Excellent  | Good   | Good    |
| Direct access          | Excellent  | Poor   | Good    |
| File growth            | Difficult  | Easy   | Easy    |
| Pointer/index overhead | Low        | Yes    | Yes     |
| Locality               | Excellent  | Poorer | Good    |

---

# 25. Inode ⭐⭐⭐⭐⭐

In Unix-like file systems, an **inode** stores metadata about a file.

Typically contains:

* File type
* Permissions
* Owner
* Size
* Timestamps
* Block pointers

It generally does **not** store the filename itself.

```text id="fs24"
Directory
   |
filename → inode number
             |
             ↓
        inode
        / | \
       /  |  \
 metadata pointers
             |
             ↓
          data blocks
```

### 🔥 GATE Trap

> Filename is stored inside the inode.

Usually:

$$
\boxed{\text{False}}
$$

Directory maps filename → inode.

---

# 26. Inode Block Pointers ⭐⭐⭐⭐⭐

Traditional inode structures can use:

```text id="fs25"
Direct pointers
Indirect pointer
Double indirect
Triple indirect
```

Conceptually:

```text id="fs26"
inode
 |
 ├── Direct → Data block
 ├── Direct → Data block
 ├── Indirect → [pointers]
 ├── Double Indirect → [pointers → pointers]
 └── Triple Indirect
```

---

# 27. Direct Pointer Capacity

Suppose:

```text id="fs27"
Block size = B bytes
Pointer size = P bytes
```

Number of pointers in one indirect block:

$$
\boxed{\frac{B}{P}}
$$

If there are \(D\) direct pointers:

Direct capacity:

$$
\boxed{D\times B}
$$

---

# 28. Single Indirect Capacity ⭐⭐⭐⭐⭐

Number of pointers:

$$
\frac{B}{P}
$$

Each points to one data block of \(B\) bytes.

Therefore:

$$
\boxed{
Single\ indirect\ capacity
=
\frac{B}{P}\times B
}
$$

---

# 29. Double Indirect Capacity

A double-indirect block points to indirect blocks.

Number of data blocks:

$$
\left(\frac{B}{P}\right)^2
$$

Therefore data capacity:

$$
\boxed{
\left(\frac{B}{P}\right)^2B
}
$$

---

# 30. Triple Indirect Capacity

Number of data blocks:

$$
\left(\frac{B}{P}\right)^3
$$

Capacity:

$$
\boxed{
\left(\frac{B}{P}\right)^3B
}
$$

---

# 31. GATE Inode Numerical ⭐⭐⭐⭐⭐

Suppose:

```text
Block size = 4 KB
Pointer size = 4 bytes
```

Pointers per indirect block:

$$
\frac{4096}{4}
=
1024
$$

### Single indirect:

$$
1024\times4KB
=
\boxed{4MB}
$$

### Double indirect:

$$
1024^2\times4KB
=
\boxed{4GB}
$$

### Triple indirect:

$$
1024^3\times4KB
=
\boxed{4TB}
$$

Ignoring filesystem-specific limits/overheads.

---

# 32. Free Space Management ⭐⭐⭐⭐⭐

OS must track which disk blocks are free.

Common techniques:

1. Bit vector / bitmap
2. Linked list
3. Grouping
4. Counting

---

# 33. Bit Vector ⭐⭐⭐⭐⭐

Each disk block corresponds to one bit.

```text id="fs28"
Blocks: 0 1 2 3 4 5 6
Bits:   1 0 1 1 0 0 1
```

For example:

```text
1 → allocated
0 → free
```

Convention can vary; the important point is **one bit per block**.

---

# 34. Bitmap Numerical

Suppose disk has:

$$
1,000,000\text{ blocks}
$$

One bit per block:

$$
1,000,000\ bits
$$

Convert to bytes:

$$
\frac{1,000,000}{8}
=
125,000\ bytes
$$

Approximately:

$$
\boxed{122.07\ KB}
$$

---

# 35. Linked-List Free Space Management

Free blocks are linked together.

```text id="fs29"
Free block
   ↓
Block 7 → Block 15 → Block 21 → ...
```

Simple, but finding a large contiguous region can be expensive.

---

# 36. Counting

Store:

```text
(starting block, number of consecutive free blocks)
```

Example:

```text id="fs30"
(100, 50)
```

means:

```text
Blocks 100–149 are free
```

Useful when free blocks occur in runs.

---

# 37. Disk Mounting ⭐⭐⭐⭐

Before accessing a file system, the OS may need to **mount** it.

Conceptually:

```text id="fs31"
Disk/File System
      ↓
    mount
      ↓
Directory tree
```

The file system becomes accessible at a mount point.

---

# 38. File Protection ⭐⭐⭐⭐⭐

Common permissions:

```text id="fs32"
Read    (r)
Write   (w)
Execute (x)
```

For:

```text
owner | group | others
```

Example:

```text id="fs33"
rwx | r-x | r--
```

means:

* owner: read/write/execute
* group: read/execute
* others: read

---

# 39. Hard Link vs Symbolic Link ⭐⭐⭐⭐⭐

### Hard Link

Another directory entry referring to the same underlying inode.

```text id="fs34"
A ──┐
    ├──→ inode → data
B ──┘
```

### Symbolic Link

A separate file containing a reference/path to another file.

```text id="fs35"
Link → pathname → target
```

---

# 40. Hard Link vs Symbolic Link

| Hard Link                                                                    | Symbolic Link                    |
| ---------------------------------------------------------------------------- | -------------------------------- |
| Same inode                                                                   | Different inode                  |
| Points directly to file's inode                                              | Points to pathname               |
| Usually cannot cross file systems                                            | Can generally cross file systems |
| Target deletion doesn't immediately destroy data if another hard link exists | Can become dangling              |
| Directory entry                                                              | Separate link file               |

### 🔥 GATE

$$
\boxed{\text{Hard links share inode}}
$$

---

# 41. File System Layers ⭐⭐⭐⭐

Conceptually:

```text id="fs36"
User Programs
      ↓
System Call Interface
      ↓
Logical File System
      ↓
File-Organization Module
      ↓
Basic File System
      ↓
I/O Control
      ↓
Device
```

Different OS implementations may organize these layers differently.

---

# 42. File System vs Disk Scheduling

Don't confuse:

### File System

Answers:

> **Where/how are files organized and their blocks managed?**

### Disk Scheduling

Answers:

> **Which pending disk request should be serviced next?**

Examples:

```text id="fs37"
File System:
inode, FAT, allocation

Disk Scheduling:
FCFS, SSTF, SCAN, LOOK
```

---

# 43. GATE Pattern — Allocation

### Question

A file requires 5 blocks. Which allocation method gives the fastest direct access when blocks are contiguous?

$$
\boxed{\text{Contiguous allocation}}
$$

Reason:

$$
PhysicalBlock=Start+i
$$

---

# 44. GATE Pattern — Linked Allocation

### Question

Which allocation method suffers from poor random access because blocks must be traversed sequentially?

$$
\boxed{\text{Linked allocation}}
$$

---

# 45. GATE Pattern — Indexed Allocation

### Question

Which allocation method uses an index block containing pointers to file blocks?

$$
\boxed{\text{Indexed allocation}}
$$

---

# 46. GATE Pattern — Inode

### Question

A Unix directory contains:

```text
filename → inode number
```

Where is the file's block-location information primarily stored?

$$
\boxed{\text{Inode}}
$$

---

# 47. GATE Pattern — Bitmap

If:

```text
Disk blocks = N
```

and one bit represents each block:

$$
\boxed{\text{Bitmap size}=N\ bits}
$$

In bytes:

$$
\boxed{\frac{N}{8}}
$$

---

# 48. GATE Pattern — Maximum File Size ⭐⭐⭐⭐⭐

Suppose:

```text id="fs38"
Block size = 4 KB
Pointer size = 4 bytes
Direct pointers = 12
```

Then:

$$
N=\frac{4096}{4}=1024
$$

Maximum data blocks:

$$
12+1024+1024^2+1024^3
$$

Maximum file size:

$$
\boxed{
(12+1024+1024^2+1024^3)\times4KB
}
$$

### 🔥 GATE Strategy

First calculate:

$$
\boxed{\text{Pointers per indirect block}=\frac{Block\ Size}{Pointer\ Size}}
$$

Then calculate direct + indirect capacities.

---

# 🔥 GATE Traps

### Trap 1

> Linked allocation causes external fragmentation.

❌ File blocks can be scattered; external fragmentation is not the issue.

---

### Trap 2

> Contiguous allocation has no fragmentation.

❌ External fragmentation can occur.

---

### Trap 3

> Indexed allocation requires consecutive data blocks.

❌ Data blocks can be anywhere.

---

### Trap 4

> Inode stores filename.

❌ Typically directory stores filename → inode mapping.

---

### Trap 5

> TLB and inode perform similar functions.

❌

```text
TLB → virtual → physical translation cache

inode → file metadata + block pointers
```

---

### Trap 6

> Hard link creates another copy of the file.

❌ It creates another directory reference to the same inode.

---

### Trap 7

> Symbolic link always remains valid after target deletion.

❌ It can become a **dangling link**.

---

### Trap 8

> Direct access means no disk access overhead.

❌ It only means the file can be accessed at an arbitrary position.

---

### Trap 9

> One bitmap bit represents one byte.

❌ Typically one bit represents one **disk block**.

---

### Trap 10

> Larger block size always improves file-system performance.

❌ Larger blocks reduce metadata overhead but can increase internal fragmentation and I/O waste.

---

# 🎯 GATE Priority

| Topic                        | Priority |
| ---------------------------- | -------: |
| File Allocation              |    ⭐⭐⭐⭐⭐ |
| Contiguous Allocation        |    ⭐⭐⭐⭐⭐ |
| Linked Allocation            |    ⭐⭐⭐⭐⭐ |
| Indexed Allocation           |    ⭐⭐⭐⭐⭐ |
| Inode                        |    ⭐⭐⭐⭐⭐ |
| Direct/Indirect Pointers     |    ⭐⭐⭐⭐⭐ |
| Maximum File Size Numericals |    ⭐⭐⭐⭐⭐ |
| Free Space / Bitmap          |    ⭐⭐⭐⭐⭐ |
| Directory Structures         |     ⭐⭐⭐⭐ |
| File Access Methods          |     ⭐⭐⭐⭐ |
| File Operations              |      ⭐⭐⭐ |
| Hard vs Symbolic Links       |    ⭐⭐⭐⭐⭐ |
| File Protection              |     ⭐⭐⭐⭐ |
| Mounting                     |      ⭐⭐⭐ |
| FAT                          |      ⭐⭐⭐ |

---

# 🧠 GATE Mental Model

```text id="fs39"
                    FILE SYSTEM
                         |
            ┌────────────┴────────────┐
            ↓                         ↓
         FILES                    DIRECTORIES
            |                         |
      ┌─────┼─────┐             Tree / Graph
      ↓     ↓     ↓
 Contiguous Linked Indexed
      |      |      |
   Fast    Easy   Direct
   access  growth access
      |
    External
   fragmentation

File metadata
      ↓
    inode
      ↓
Block pointers
      ↓
Data blocks
```

---

# ⚡ 30-Second Revision

```text id="fs40"
File system:
→ Organizes files/directories on storage

File descriptor:
→ Integer/handle used by process for open file

Access:
→ Sequential / Direct / Indexed

Directory:
→ Maps names to file information/reference

Contiguous:
→ Consecutive blocks
→ Fast sequential + random
→ External fragmentation
→ Growth difficult

Linked:
→ Each block points to next
→ No external fragmentation
→ Poor random access

Indexed:
→ Index block contains block pointers
→ Direct access possible
→ Index overhead

inode:
→ Metadata + block pointers
→ Filename generally NOT in inode

Indirect:
Pointers per block = Block size / Pointer size

Single indirect:
→ N data blocks

Double indirect:
→ N² data blocks

Triple indirect:
→ N³ data blocks

Bitmap:
→ 1 bit per disk block

Hard link:
→ Same inode

Symbolic link:
→ Separate inode + pathname reference

Absolute path:
→ Starts at root

Relative path:
→ Starts from current directory
```

## 🔥 Absolute GATE Must-Remember

$$
\boxed{\text{Contiguous → Fast + External Fragmentation}}
$$

$$
\boxed{\text{Linked → Easy Growth + Poor Random Access}}
$$

$$
\boxed{\text{Indexed → Index Block + Direct Access}}
$$

$$
\boxed{\text{inode → Metadata + Block Pointers}}
$$

$$
\boxed{\text{Pointers per block}=\frac{Block\ Size}{Pointer\ Size}}
$$

$$
\boxed{\text{Bitmap size}=\frac{\text{Number of Blocks}}{8}\ bytes}
$$

$$
\boxed{\text{Hard Link → Same inode}}
$$

### ⭐ GATE Priority: **5/5**

**This completes the 12 core OS files in your current folder.**
