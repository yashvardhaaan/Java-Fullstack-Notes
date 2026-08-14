# 03 — Commits, History & Git Internals

> **Goal:** Understand what a Git commit really is, how Git stores files internally, how SHA-1 hashes identify objects, how `HEAD` works, and how Git builds project history.

This file moves from **using Git** to understanding **how Git actually works internally**.

---

# 1. The Big Picture

When you run:

```bash
git commit -m "Add authentication"
```

Git does much more than simply "save the changes."

Conceptually:

```text
Working Directory
        ↓
      Index
        ↓
      Tree
        ↓
     Commit
        ↓
      HEAD
        ↓
     Branch
```

Git internally stores objects:

```text
┌───────────────┐
│     Blob      │ → File contents
├───────────────┤
│     Tree      │ → Directory structure
├───────────────┤
│    Commit     │ → History + metadata
├───────────────┤
│      Tag      │ → Named object/reference
└───────────────┘
```

Understanding these four object types is one of the most valuable Git interview topics.

---

# 2. What Is a Commit?

A commit is a **Git object representing a particular state of the project**, together with metadata describing the history.

Example:

```bash
git commit -m "Add login endpoint"
```

Conceptually, the commit contains:

```text
Commit
├── tree
├── parent
├── author
├── committer
├── timestamp
└── message
```

For example:

```text
tree abc123
parent 8fd321
author Yash <yash@example.com>
committer Yash <yash@example.com>

Add login endpoint
```

The actual internal representation is more precise, but this is the correct mental model.

---

# 3. Commits Form a Graph

Suppose you make four commits:

```text
A
↓
B
↓
C
↓
D
```

This represents:

```text
A ← B ← C ← D
```

Each commit points to its parent.

So:

```text
D → C
C → B
B → A
A → nothing
```

This is why Git history is naturally a **directed acyclic graph (DAG)**.

---

# 4. Why Does a Commit Have a Parent?

The parent tells Git:

> "What commit came before this one?"

For example:

```text
A
↑
B
↑
C
```

Commit C contains:

```text
parent = B
```

Commit B contains:

```text
parent = A
```

This allows Git to walk backward through history.

---

# 5. Merge Commits Have Multiple Parents

Normal commit:

```text
A → B → C
```

Commit C has:

```text
parent = B
```

A merge commit can have two parents:

```text
        C
       / \
A → B     D
       \ /
        M
```

The merge commit `M` contains:

```text
parent = B
parent = D
```

This is why Git can represent branching and merging naturally.

---

# 6. Git Objects

Git stores information as objects.

The main object types are:

```text
Blob
Tree
Commit
Tag
```

The most important three are:

```text
Blob
Tree
Commit
```

---

# 7. Blob Object

**Blob = Binary Large Object**

In Git, a blob stores **file contents**.

Suppose:

```text
hello.txt
```

contains:

```text
Hello Git
```

Git can store the content as a blob.

Conceptually:

```text
Blob
└── "Hello Git"
```

Important:

> A blob does not store the filename.

The filename is associated through a tree.

---

# 8. Tree Object

A tree represents a **directory structure**.

Suppose your project is:

```text
project/
├── README.md
├── User.java
└── services/
    └── UserService.java
```

Conceptually:

```text
Tree
├── README.md → Blob
├── User.java → Blob
└── services/ → Tree
                  └── UserService.java → Blob
```

Therefore:

```text
Tree
→ directory structure

Blob
→ file content
```

---

# 9. Commit Object

A commit connects the history to a tree.

Conceptually:

```text
Commit
├── parent → previous Commit
└── tree → project Tree
```

Therefore:

```text
Commit
   ↓
 Tree
   ↓
┌───────┬───────────┐
↓       ↓           ↓
Blob   Blob        Tree
                    ↓
                   Blob
```

This is the fundamental Git storage model.

---

# 10. The Complete Git Object Model

Suppose:

```text
project/
├── README.md
└── src/
    └── App.java
```

Git might conceptually store:

```text
Commit
   │
   ↓
Root Tree
   ├── README.md → Blob A
   │
   └── src → Tree B
              │
              └── App.java → Blob C
```

So:

```text
Commit
   ↓
Tree
   ↓
Trees + Blobs
```

---

# 11. Git Uses Content-Based Hashing

Git identifies objects using hashes.

Historically, Git uses **SHA-1** object IDs by default, while modern Git also supports repositories configured to use **SHA-256**.

For a SHA-1 repository, an object ID looks like:

```text
e4b7c1f2...
```

with:

```text
40 hexadecimal characters
```

Example:

```text
a3f5c8e9d2...
```

The hash is derived from the object's content and type information.

This means:

> The identity of a Git object is based on its contents.

---

# 12. Why Is Content-Based Hashing Useful?

Suppose Git stores:

```text
Hello Git
```

That content produces a particular object ID.

If the content changes:

```text
Hello Git!
```

the hash changes.

Conceptually:

```text
"Hello Git"
     ↓
Hash A

"Hello Git!"
     ↓
Hash B
```

Therefore Git can efficiently identify objects.

---

# 13. Git Object Storage

Inside:

```text
.git/objects/
```

Git stores objects.

Conceptually:

```text
.git/
└── objects/
    ├── 4a/
    │   └── ...
    ├── 8f/
    │   └── ...
    └── d2/
        └── ...
```

The object ID is split into:

```text
first 2 characters
+
remaining characters
```

For example:

```text
abcdef123456...
```

is conceptually stored under:

```text
ab/
```

with the remainder used as the filename.

Git may later pack many objects into packfiles for efficiency.

---

# 14. Inspecting Objects

You can inspect Git objects using:

```bash
git cat-file
```

First create a repository:

```bash
mkdir git-internals
cd git-internals
git init
```

Create:

```text
hello.txt
```

with:

```text
Hello Git
```

Then:

```bash
git add hello.txt
```

You can inspect the index:

```bash
git ls-files --stage
```

You may see something resembling:

```text
100644 <hash> 0 hello.txt
```

The hash identifies the staged blob.

---

# 15. `git cat-file`

Given an object hash:

```bash
git cat-file -t <hash>
```

This tells you the object type.

For example:

```text
blob
```

Inspect its content:

```bash
git cat-file -p <hash>
```

For a blob:

```text
Hello Git
```

For a tree:

```text
100644 blob abc123 README.md
040000 tree def456 src
```

For a commit:

```text
tree abc123
parent def456
author ...
committer ...

Initial commit
```

This is one of the best ways to explore Git internals hands-on.

---

# 16. What Is `HEAD`?

`HEAD` is one of the most important concepts in Git.

At a high level:

> `HEAD` tells Git what commit/branch you are currently working from.

Suppose:

```text
A → B → C
        ↑
       main
```

Typically:

```text
HEAD
 ↓
main
 ↓
C
```

So:

```text
HEAD → branch → commit
```

---

# 17. Inspect HEAD

Run:

```bash
git symbolic-ref HEAD
```

You may get:

```text
refs/heads/main
```

You can also inspect:

```bash
cat .git/HEAD
```

You may see:

```text
ref: refs/heads/main
```

This means:

```text
HEAD
 ↓
refs/heads/main
 ↓
commit
```

---

# 18. What Is a Branch Internally?

A branch is essentially a **reference pointing to a commit**.

Suppose:

```text
A → B → C
        ↑
       main
```

The branch `main` points to commit C.

If you make another commit:

```text
A → B → C → D
            ↑
           main
```

The branch reference moves from C to D.

This is why Git branches are lightweight.

A branch does not duplicate your entire project.

---

# 19. Branches Are Pointers

Think:

```text
main ───────→ C
feature ────→ F
```

The commits contain the history.

Branches are simply references to commits.

This explains why creating a branch is extremely cheap:

```bash
git branch feature/login
```

Git mostly needs to create/update a reference.

---

# 20. `HEAD` + Branch + Commit

This is worth memorizing:

```text
HEAD
 ↓
main
 ↓
C
 ↓
B
 ↓
A
```

If you switch branches:

```bash
git switch feature/login
```

you get:

```text
HEAD
 ↓
feature/login
 ↓
F
 ↓
...
```

---

# 21. Detached HEAD

Normally:

```text
HEAD
 ↓
main
 ↓
C
```

But you can check out a specific commit:

```bash
git switch --detach <commit>
```

Now:

```text
HEAD
 ↓
C
```

There is no branch between HEAD and the commit.

This is called:

> **Detached HEAD state**

You can inspect old commits safely, but if you create commits there and don't create a branch/reference for them, those commits can eventually become difficult to find.

---

# 22. Git History

Basic command:

```bash
git log
```

Example:

```text
commit abc123
Author: Yash
Date: ...

    Add authentication

commit def456
Author: Yash
Date: ...

    Add user service

commit 789abc
Author: Yash
Date: ...

    Initial project setup
```

A more useful version:

```bash
git log --oneline
```

Example:

```text
abc123 Add authentication
def456 Add user service
789abc Initial project setup
```

---

# 23. Visualizing Branch History

Use:

```bash
git log --oneline --graph --all
```

Example:

```text
* abc123 Add payment
* def456 Add authentication
| * 987xyz Add notification
|/
* 789abc Initial project
```

This is extremely useful when working with branches.

---

# 24. Commit Hash

Each commit has an object ID.

Example:

```text
abc123def456...
```

You can refer to a commit using:

```bash
git show abc123
```

You don't usually need the full hash.

Git often accepts an unambiguous abbreviated hash.

---

# 25. Relative Commit References

Git provides useful references.

### `HEAD`

Current position:

```bash
git show HEAD
```

### `HEAD~1`

Parent of HEAD:

```bash
git show HEAD~1
```

### `HEAD~2`

Grandparent:

```bash
git show HEAD~2
```

Example:

```text
A ← B ← C ← D
          ↑
         HEAD
```

Then:

```text
HEAD     = D
HEAD~1   = C
HEAD~2   = B
HEAD~3   = A
```

---

# 26. `HEAD^` vs `HEAD~`

For a normal linear history:

```text
HEAD^
```

and:

```text
HEAD~1
```

both refer to the parent.

For merge commits, the difference becomes important because a merge commit has multiple parents.

For example:

```text
       B
      / \
A ───     M
      \ /
       C
```

`M^1` means first parent.

`M^2` means second parent.

This becomes important when debugging merge history.

---

# 27. What Happens When You Commit?

Let's follow the entire process.

You modify:

```text
UserService.java
```

Then:

```bash
git add UserService.java
```

Git updates the index.

Conceptually:

```text
Working Directory
       ↓
       add
       ↓
Index
```

Then:

```bash
git commit -m "Update user service"
```

Git creates/uses:

```text
Blob
Tree
Commit
```

Conceptually:

```text
UserService.java
       ↓
     Blob
       ↓
     Tree
       ↓
    Commit
       ↓
Branch reference moves
       ↓
HEAD follows branch
```

---

# 28. What Happens to the Branch After Commit?

Before:

```text
A → B
    ↑
   main
    ↑
   HEAD
```

After:

```text
A → B → C
        ↑
       main
        ↑
       HEAD
```

The branch reference moves to the new commit.

The previous commit remains in history because C points to B.

---

# 29. Git Does Not Need to Store Every Full Copy

Suppose:

```text
Commit A
```

contains:

```text
User.java
UserService.java
README.md
```

Then Commit B changes only:

```text
UserService.java
```

Git can reuse objects for unchanged content.

Conceptually:

```text
Commit A
  ↓
Tree A
├── Blob User.java
├── Blob UserService.java A
└── Blob README

Commit B
  ↓
Tree B
├── Blob User.java      ← reused
├── Blob UserService B  ← new object
└── Blob README         ← reused
```

This object-sharing model is an important reason Git is efficient.

---

# 30. Is Git Storing Diffs?

A common interview question:

> Does Git store every commit as a diff?

The best answer is:

> Git's core storage model is based on snapshots represented through trees and blobs, not a simple chain of diffs. For storage and transfer efficiency, Git can use packfiles and delta compression internally.

So avoid saying:

> "Git stores only diffs."

That is an oversimplification.

---

# 31. Git's Object Database

Git's internal database is commonly called the **object database**.

Objects include:

```text
.git/objects/
```

Important objects:

```text
Blob
Tree
Commit
Tag
```

The relationships are:

```text
Commit
   ↓
Tree
   ↓
Blob / Tree
```

And history:

```text
Commit
   ↓ parent
Commit
   ↓ parent
Commit
```

---

# 32. The Index

The index is the technical name for the staging area.

It stores information describing what is currently staged for the next commit.

You can inspect it:

```bash
git ls-files --stage
```

Example:

```text
100644 abc123... 0 UserService.java
```

The important parts include:

```text
file mode
object ID
stage number
path
```

Normally the stage number is:

```text
0
```

During a merge conflict, higher stage numbers can appear because Git needs to represent multiple versions of a file.

We'll cover this in the merge/conflict file.

---

# 33. `git ls-tree`

You can inspect a tree:

```bash
git ls-tree HEAD
```

Example:

```text
100644 blob abc123 README.md
040000 tree def456 src
```

This shows the directory structure represented by the tree object referenced by the commit.

---

# 34. `git show`

Inspect a commit:

```bash
git show HEAD
```

Inspect an older commit:

```bash
git show HEAD~1
```

Inspect a specific object:

```bash
git show <hash>
```

This is extremely useful for debugging.

---

# 35. Practical Internal Experiment

Create a repository:

```bash
mkdir git-internals-practice
cd git-internals-practice
git init
```

Configure your identity if necessary:

```bash
git config user.name "Your Name"
git config user.email "your@email.com"
```

Create:

```text
hello.txt
```

with:

```text
Hello Git
```

Stage it:

```bash
git add hello.txt
```

Inspect the index:

```bash
git ls-files --stage
```

Copy the hash.

Check the object:

```bash
git cat-file -t <hash>
```

You should get:

```text
blob
```

Then:

```bash
git cat-file -p <hash>
```

You should see:

```text
Hello Git
```

Now commit:

```bash
git commit -m "Initial commit"
```

Find the commit:

```bash
git log --oneline
```

Inspect it:

```bash
git cat-file -p HEAD
```

You'll see something conceptually like:

```text
tree <tree-hash>
author ...
committer ...

Initial commit
```

Then inspect the tree:

```bash
git cat-file -p <tree-hash>
```

You'll find the blob reference for:

```text
hello.txt
```

You have now manually followed:

```text
Commit
  ↓
Tree
  ↓
Blob
  ↓
File contents
```

This is one of the best Git internals exercises you can do.

---

# 36. Important Commands From This File

```bash
git log
git log --oneline
git log --oneline --graph --all

git show HEAD
git show <commit>

git cat-file -t <object>
git cat-file -p <object>

git ls-files --stage
git ls-tree HEAD

git rev-parse HEAD
git rev-parse --short HEAD

git symbolic-ref HEAD
```

---

# 37. Interview Questions

## Q1. What is a Git commit internally?

A commit is a Git object containing metadata such as the author, committer, message, parent commit reference(s), and a reference to a tree representing the project state.

---

## Q2. What is a blob?

A blob is a Git object that stores file contents.

It does not directly store the filename.

---

## Q3. What is a tree?

A tree represents directory structure and references blobs and other trees.

---

## Q4. What is the relationship between commit, tree, and blob?

```text
Commit
  ↓
Tree
  ↓
Blob
```

The commit references a tree, and the tree references file-content blobs.

---

## Q5. What is HEAD?

`HEAD` identifies the current position in the repository, usually by pointing to the current branch, which in turn points to a commit.

---

## Q6. What is a branch internally?

A branch is essentially a reference pointing to a commit.

---

## Q7. Why are Git branches lightweight?

Because creating a branch generally involves creating a small reference to an existing commit rather than copying the entire project.

---

## Q8. Does Git store snapshots or diffs?

Git's conceptual object model is snapshot-based, using trees and blobs. Git can additionally use delta compression inside packfiles for storage efficiency.

---

## Q9. What is `.git/objects`?

It is the area of the Git repository that stores Git objects such as commits, trees, and blobs, initially as loose objects and potentially later in packed form.

---

## Q10. What is detached HEAD?

Detached HEAD means HEAD points directly to a commit rather than to a branch reference.

---

# 38. 20/80 Summary

Remember these relationships:

```text
                    HEAD
                     ↓
                   Branch
                     ↓
                   Commit
                     ↓
                    Tree
                  ↙      ↘
              Blob       Tree
                ↓          ↓
             File       Directory
```

And:

```text
Commit
├── parent
├── author
├── committer
├── message
└── tree
```

The most important internal concepts are:

```text
.git
  ↓
objects
  ↓
blob
tree
commit

refs
  ↓
branches

HEAD
  ↓
current position

index
  ↓
staging area
```

If you understand this diagram, you understand the foundation of how Git works internally.
