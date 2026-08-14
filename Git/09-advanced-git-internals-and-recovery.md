# 09 — Advanced Git Internals and Recovery

> **Goal:** Understand what Git stores internally and learn how to recover from mistakes safely.

---

# 1. Git's Core Architecture

Git is fundamentally an **object database + references**.

The most important objects are:

```text
Blob
Tree
Commit
Tag
```

---

# 2. Blob

A blob stores **file content**.

Suppose:

```text
hello.txt

Hello Git
```

Git stores the content as a blob.

A blob does NOT normally store:

* filename
* directory location

It stores file content.

---

# 3. Tree

A tree represents a directory.

It connects:

```text
filename
    ↓
blob

directory
    ↓
tree
```

Example:

```text
tree
├── README.md → blob
├── main.java → blob
└── src → tree
```

---

# 4. Commit

A commit points to a tree.

Conceptually:

```text
Commit
 ├── tree
 ├── parent
 ├── author
 ├── committer
 └── message
```

Example:

```text
commit C
   |
   └── tree
        |
        ├── README
        └── src
```

---

# 5. Commit Chain

Suppose:

```text
A → B → C → D
```

Each commit stores the parent commit.

```text
D
|
C
|
B
|
A
```

Therefore Git can walk backward through history.

---

# 6. SHA-1 / Object IDs

Git identifies objects using cryptographic hashes.

For example:

```text
a7b3c9...
```

Historically Git uses SHA-1 object IDs.

Modern Git also supports SHA-256 repositories.

The important concept is:

```text
Content
   ↓
Hash
   ↓
Object ID
```

---

# 7. Content Addressability

Git's storage is content-addressed.

Conceptually:

```text
same content
     ↓
same hash
     ↓
same object
```

This helps Git efficiently store and reuse data.

---

# 8. `.git` Directory

Inside a Git repository:

```text
.git/
```

contains Git's internal information.

Important areas:

```text
.git/
├── HEAD
├── config
├── index
├── objects/
├── refs/
├── logs/
└── hooks/
```

---

# 9. HEAD

`HEAD` tells Git where you currently are.

Usually:

```text
HEAD
 ↓
refs/heads/main
 ↓
commit abc123
```

Check:

```bash
cat .git/HEAD
```

On Windows:

```bash
type .git\HEAD
```

Typical result:

```text
ref: refs/heads/main
```

---

# 10. Branches Are References

A branch is basically a movable reference to a commit.

Example:

```text
main
 ↓
C
```

After a new commit:

```text
main
 ↓
D
```

The branch pointer moves.

The old commit still exists.

This is one of the most important Git concepts.

---

# 11. Inspect References

```bash
git show-ref
```

Example:

```text
abc123 refs/heads/main
def456 refs/heads/feature/login
```

---

# 12. `git cat-file`

One of the best commands for understanding internals:

```bash
git cat-file -t HEAD
```

Returns:

```text
commit
```

Inspect:

```bash
git cat-file -p HEAD
```

You may see:

```text
tree abc123
parent def456
author ...
committer ...

commit message
```

---

# 13. Inspect the Tree

Get the tree:

```bash
git cat-file -p HEAD^{tree}
```

Example:

```text
100644 blob abc123 README.md
100644 blob def456 pom.xml
040000 tree xyz789 src
```

This shows the relationship:

```text
Tree
 ├── README.md → blob
 ├── pom.xml → blob
 └── src → tree
```

---

# 14. Index

The index is also called the:

```text
staging area
```

It sits between:

```text
Working Directory
       ↓
     Index
       ↓
    Repository
```

When you run:

```bash
git add file.txt
```

Git updates the index.

It does NOT create a commit.

---

# 15. Git Add Internally

Suppose:

```text
file.txt
```

changes.

Running:

```bash
git add file.txt
```

roughly causes:

```text
Working file
     ↓
Calculate hash
     ↓
Create/store blob
     ↓
Update index
```

Then:

```bash
git commit
```

creates:

```text
tree
 ↓
commit
```

---

# 16. Reflog

One of Git's most useful recovery mechanisms:

```bash
git reflog
```

It records movements of references such as:

```text
HEAD
branches
```

Example:

```text
abc123 HEAD@{0}: commit: Add login
def456 HEAD@{1}: checkout: moving from main to feature/login
ghi789 HEAD@{2}: commit: Add user
```

---

# 17. Recovering a Lost Commit

Suppose you accidentally execute:

```bash
git reset --hard HEAD~2
```

Your commits appear to disappear.

Don't panic.

Run:

```bash
git reflog
```

Find the old commit:

```text
abc123
```

Then:

```bash
git reset --hard abc123
```

The commit can often be recovered because the object still exists.

---

# 18. Reflog vs Git Log

### `git log`

Shows commit history reachable from your current references.

```bash
git log
```

### `git reflog`

Shows movements of local references.

```bash
git reflog
```

Think:

```text
git log
=
"What commits are in my history?"

git reflog
=
"Where has my HEAD/branch pointer been?"
```

---

# 19. Detached HEAD

Normally:

```text
HEAD
 ↓
main
 ↓
commit
```

Detached HEAD:

```text
HEAD
 ↓
commit
```

You are directly pointing to a commit rather than a branch.

Create it:

```bash
git checkout <commit>
```

or:

```bash
git switch --detach <commit>
```

---

# 20. Is Detached HEAD Dangerous?

Not immediately.

You can inspect old commits safely.

The danger is creating commits and then abandoning them without creating a branch.

If you create useful work:

```bash
git switch -c recovery-branch
```

Now the commit is referenced by a branch.

---

# 21. Recover Uncommitted Changes

If you haven't committed your changes and execute:

```bash
git reset --hard
```

your working-directory changes may be lost.

Git cannot guarantee recovery of uncommitted content.

Therefore:

> Commit important work before performing risky history operations.

---

# 22. `git fsck`

Git can inspect unreachable objects:

```bash
git fsck --full
```

You may find:

```text
dangling commit abc123
dangling blob def456
```

A dangling commit may contain your lost work.

Inspect:

```bash
git show abc123
```

Recover:

```bash
git branch recovery abc123
```

---

# 23. Reset Internals

There are three major reset modes.

## Soft

```bash
git reset --soft HEAD~1
```

Moves:

```text
HEAD
```

but keeps:

```text
index
working directory
```

Useful when you want to redo the commit.

---

## Mixed

```bash
git reset --mixed HEAD~1
```

Moves:

```text
HEAD
```

and resets:

```text
index
```

but keeps working-directory changes.

This is the default.

---

## Hard

```bash
git reset --hard HEAD~1
```

Moves:

```text
HEAD
index
working directory
```

Potentially destructive.

---

# 24. Restore

Modern Git provides:

```bash
git restore file.txt
```

Discard working-directory changes.

Restore staged state:

```bash
git restore --staged file.txt
```

This removes the file from staging without deleting the working-directory changes.

---

# 25. Revert

Instead of rewriting history:

```bash
git revert <commit>
```

creates a new commit that reverses the old commit.

Example:

```text
A---B---C
```

Revert C:

```text
A---B---C---D
```

where D undoes C.

Best for shared branches.

---

# 26. Reset vs Revert

| Command   | Main purpose                  |
| --------- | ----------------------------- |
| `reset`   | Move branch pointer           |
| `restore` | Restore file contents/staging |
| `revert`  | Create a new undo commit      |

Simple rule:

```text
Private/local history
→ reset

Shared/public history
→ revert
```

---

# 27. Cherry-Pick

Apply a specific commit to your current branch:

```bash
git cherry-pick abc123
```

Example:

```text
main:
A---B---C

feature:
A---B---D
```

Cherry-pick D:

```text
main:
A---B---C---D'
```

The resulting commit has a different ID.

---

# 28. Bisect

`git bisect` helps locate which commit introduced a bug.

Start:

```bash
git bisect start
```

Mark current version bad:

```bash
git bisect bad
```

Mark known good version:

```bash
git bisect good <commit>
```

Git checks out a commit approximately halfway through the range.

Test it.

Then:

```bash
git bisect good
```

or:

```bash
git bisect bad
```

Git performs a binary search.

Finish:

```bash
git bisect reset
```

---

# 29. Stash Internals

```bash
git stash
```

temporarily stores changes.

Useful when:

```text
You are working on feature A
        ↓
Urgent bug appears
        ↓
Need clean working tree
```

Use:

```bash
git stash
git switch main
```

Later:

```bash
git stash pop
```

View:

```bash
git stash list
```

---

# 30. Git Recovery Cheat Sheet

### Accidentally deleted local commit

```bash
git reflog
git reset --hard <commit>
```

### Accidentally reset branch

```bash
git reflog
git reset --hard <old-commit>
```

### Lost commit not in reflog

```bash
git fsck --full
```

### Accidentally staged file

```bash
git restore --staged file.txt
```

### Accidentally modified file

```bash
git restore file.txt
```

### Undo shared commit

```bash
git revert <commit>
```

### Need to temporarily save work

```bash
git stash
```

---

# 31. Interview Questions

### What is a Git object?

An object stored in Git's object database, such as a blob, tree, or commit.

### What is a blob?

An object containing file content.

### What is a tree?

An object representing directory structure and references to blobs/subtrees.

### What does a commit contain?

At a high level:

```text
tree
parent
author
committer
message
```

### What is HEAD?

A reference representing the current checkout position.

### What is a branch internally?

A movable reference pointing to a commit.

### What is reflog?

A local record of reference movements.

### Can a deleted commit be recovered?

Often yes, using:

```bash
git reflog
```

or sometimes:

```bash
git fsck
```

### What is detached HEAD?

HEAD points directly to a commit rather than a branch.

### What does `git add` actually do?

It updates the index and records the staged snapshot information.

---

# 32. Mental Model

Remember Git as:

```text
WORKING DIRECTORY
       ↓
      git add
       ↓
      INDEX
       ↓
    git commit
       ↓
    COMMIT
       ↓
     BRANCH
       ↓
      HEAD
```

And internally:

```text
Commit
  ↓
Tree
  ↓
Blob
```

This model makes most Git commands much easier to understand.
