# 05 — Merge, Rebase & Merge Conflicts

> **Goal:** Understand how Git combines branches, the difference between merge and rebase, what happens internally, why conflicts occur, and how to resolve them safely in real projects.

---

# 1. Why Do We Need Merge or Rebase?

Suppose your project has:

```text
A → B → C
```

`main` points to `C`.

You create:

```bash
git switch -c feature/login
```

Now both branches point to `C`:

```text
A → B → C
        ↑
       main
        ↑
     feature
```

You make commits on the feature branch:

```text
A → B → C → D → E
             ↑
          feature
```

Meanwhile, another developer adds commits to `main`:

```text
A → B → C → F → G
             ↑
            main
```

Now the branches have **diverged**:

```text
             D → E
            /
A → B → C
            \
             F → G
```

Eventually you need to combine these histories.

The two main approaches are:

```text
merge
rebase
```

---

# 2. What Is a Merge?

A merge combines two lines of development.

Suppose:

```text
             D → E
            /
A → B → C
            \
             F → G
```

You are on `main` and want to merge `feature`.

```bash
git switch main
git merge feature
```

Git may create:

```text
             D → E
            /     \
A → B → C         M
            \     /
             F → G
```

`M` is a **merge commit**.

---

# 3. Merge Commit

A normal commit has one parent:

```text
A → B
```

B has:

```text
parent = A
```

A merge commit usually has two parents:

```text
       D
      / \
     C   E
      \ /
       M
```

The merge commit contains:

```text
parent 1 → C
parent 2 → E
```

This allows Git to remember that two histories were combined.

---

# 4. The Three-Way Merge

Git usually performs a merge using three important commits:

```text
Current branch
Other branch
Common ancestor
```

Suppose:

```text
             D
            /
A → B → C
            \
             E
```

The common ancestor is:

```text
B
```

Git compares:

```text
B → C
```

and:

```text
B → E
```

Then combines the changes.

Conceptually:

```text
          Common ancestor
                 B
                / \
               /   \
              ↓     ↓
        main changes  feature changes
               \     /
                \   /
                  M
```

This is why it is often called a **three-way merge**.

---

# 5. Fast-Forward Merge

Not every merge creates a merge commit.

Suppose:

```text
A → B → C
        ↑
       main

A → B → C → D → E
                 ↑
               feature
```

`main` hasn't developed separately.

Run:

```bash
git switch main
git merge feature
```

Git can simply move `main`:

```text
A → B → C → D → E
                 ↑
                main
```

No merge commit is necessary.

This is a:

> **Fast-forward merge**

---

# 6. Why Is It Called Fast-Forward?

Because the branch reference simply moves forward.

Before:

```text
main → C
```

After:

```text
main → E
```

No new commit is created.

The history remains linear.

---

# 7. Preventing Fast-Forward

Sometimes you want a merge commit even when fast-forward is possible.

Use:

```bash
git merge --no-ff feature/login
```

Instead of:

```text
A → B → C → D
```

you may get:

```text
A → B → C ───── M
             ↗
           D
```

This makes the feature branch integration explicit in history.

Whether a team uses `--no-ff` depends on its Git workflow.

---

# 8. What Is Rebase?

Rebase takes your commits and **replays them on top of another base commit**.

Suppose:

```text
             D → E
            /
A → B → C
            \
             F → G
```

Assume:

```text
main = F → G
feature = D → E
```

If you rebase the feature branch onto `main`:

```bash
git switch feature
git rebase main
```

Git conceptually transforms:

```text
D → E
```

into new commits:

```text
D' → E'
```

resulting in:

```text
A → B → C → F → G → D' → E'
```

The feature commits have been replayed on top of `G`.

---

# 9. Why Are the Commits Called `D'` and `E'`?

Because they are **new commits**.

The original:

```text
D
E
```

are not literally moved.

Git creates new commits based on their changes:

```text
D → D'
E → E'
```

Since commits include parent information, changing the parent changes the commit identity.

Therefore:

> Rebase rewrites commit history.

---

# 10. Merge vs Rebase

### Merge

```text
A → B → C ───── M
           \   /
            D → E
```

Preserves the original branch structure.

### Rebase

```text
A → B → C → D' → E'
```

Creates a linear history.

---

# 11. The Golden Rule of Rebase

A very important professional rule:

> **Do not casually rebase commits that other people are already depending on.**

Why?

Because rebase creates new commit IDs.

Suppose you've already pushed:

```text
A → B → C
```

and another developer based work on `C`.

If you rewrite it into:

```text
A → B → C'
```

the histories no longer match.

This can cause unnecessary collaboration problems.

---

# 12. When Should You Merge?

Merge is generally safer when:

* Multiple developers already share the branch.
* You don't want to rewrite existing history.
* You want to preserve the actual branching structure.
* You're integrating a completed feature.

Example:

```bash
git switch main
git merge feature/payment
```

---

# 13. When Should You Rebase?

Rebase is useful when:

* You're working on your own feature branch.
* You want to update your branch with the latest `main`.
* You want a clean linear history.
* Your team explicitly follows a rebase workflow.

Example:

```bash
git switch feature/payment
git fetch origin
git rebase origin/main
```

---

# 14. Updating Your Feature Branch

Suppose:

```text
main:
A → B → C → D

feature:
A → B → E → F
```

You want your feature branch to include the latest main changes.

You can merge:

```bash
git switch feature
git merge main
```

Result:

```text
A → B → C → D
     \       \
      E → F → M
```

Or rebase:

```bash
git switch feature
git rebase main
```

Result:

```text
A → B → C → D → E' → F'
```

---

# 15. What Happens During Rebase?

Conceptually:

```text
1. Find common ancestor.
2. Identify commits unique to your branch.
3. Move your branch to the new base.
4. Replay your commits one by one.
5. Create new commit objects.
```

Example:

```text
Before:

A → B → C → D → E
     \
      F → G
```

Rebase `F → G` onto `E`:

```text
A → B → C → D → E → F' → G'
```

---

# 16. Merge Conflicts

A merge conflict occurs when Git cannot automatically determine how to combine changes.

Example:

Developer A:

```java
return "Hello";
```

Developer B:

```java
return "Welcome";
```

Both changed the same part of the same file.

Git can't know which behavior the application should have.

So it reports:

```text
CONFLICT (content)
```

---

# 17. What Does a Conflict Look Like?

Git may insert conflict markers:

```text
<<<<<<< HEAD
return "Hello";
=======
return "Welcome";
>>>>>>> feature/login
```

Meaning:

```text
<<<<<<< HEAD
Your current branch version
=======
Incoming branch version
>>>>>>> feature/login
```

The exact labels depend on the operation and configuration, but the idea is:

```text
Current version
vs
Incoming version
```

---

# 18. Resolving a Conflict

Suppose you decide the correct result is:

```java
return "Welcome";
```

Edit the file so only the desired version remains:

```java
return "Welcome";
```

Remove:

```text
<<<<<<<
=======
>>>>>>>
```

Then check:

```bash
git status
```

Stage the resolved file:

```bash
git add UserService.java
```

For a merge, finish the merge:

```bash
git commit
```

For a rebase, continue:

```bash
git rebase --continue
```

---

# 19. Important Difference After a Conflict

### During merge

After resolving:

```bash
git add <file>
git commit
```

### During rebase

After resolving:

```bash
git add <file>
git rebase --continue
```

This distinction is important.

---

# 20. Aborting a Merge

If the merge becomes complicated and you want to return to the state before the merge:

```bash
git merge --abort
```

Conceptually:

```text
Before merge
     ↓
Merge begins
     ↓
Conflict
     ↓
git merge --abort
     ↓
Back to pre-merge state
```

This is extremely useful when you realize you started the wrong merge.

---

# 21. Aborting a Rebase

If you're rebasing and want to cancel:

```bash
git rebase --abort
```

This attempts to restore the branch to the state it had before the rebase started.

---

# 22. Continue a Rebase

After resolving a conflict:

```bash
git add <resolved-file>
git rebase --continue
```

Git may encounter another conflict.

Then:

```text
Resolve
   ↓
git add
   ↓
git rebase --continue
```

Repeat until the rebase finishes.

---

# 23. Skip a Rebase Commit

Sometimes a commit becomes unnecessary during a rebase.

You can use:

```bash
git rebase --skip
```

Be careful.

You are telling Git:

> Skip applying this commit during the current rebase.

Don't use it unless you understand why the commit can be skipped.

---

# 24. Merge Conflict Workflow

Typical process:

```text
git merge feature
       ↓
    CONFLICT
       ↓
git status
       ↓
Open conflicted files
       ↓
Resolve manually
       ↓
git add <files>
       ↓
git commit
```

---

# 25. Rebase Conflict Workflow

Typical process:

```text
git rebase main
       ↓
    CONFLICT
       ↓
git status
       ↓
Resolve files
       ↓
git add <files>
       ↓
git rebase --continue
       ↓
Another conflict?
       │
      yes
       ↓
Resolve again
       ↓
Continue
```

---

# 26. `git status` During a Conflict

When a conflict occurs, run:

```bash
git status
```

Git tells you which files are:

```text
both modified
```

or otherwise involved in the conflict.

Never panic when you see:

```text
CONFLICT
```

A conflict is not a Git failure.

It means:

> Git needs a human to decide the intended result.

---

# 27. Why Can't Git Automatically Resolve Everything?

Git works with file contents and history.

It can often determine:

```text
Developer A changed line 10
Developer B changed line 50
```

These changes can usually be combined automatically.

But if both change the same logical section:

```text
Developer A → line 10
Developer B → line 10
```

Git cannot know the business requirement.

For example:

```java
price = 100;
```

Developer A:

```java
price = 90;
```

Developer B:

```java
price = 80;
```

Git cannot decide:

```text
90?
80?
Something else?
```

Only a human or higher-level tool can make that decision correctly.

---

# 28. Conflict Resolution Is a Business Decision

This is important for real development.

Don't simply choose:

```text
ours
```

or:

```text
theirs
```

without understanding the code.

Ask:

```text
What behavior should the application have?
```

For example:

```text
Database change
API contract
Authentication logic
Payment calculation
Seat availability
```

A syntactically valid resolution can still be logically wrong.

---

# 29. `ours` and `theirs`

During conflicts, Git has concepts of:

```text
ours
theirs
```

But be careful:

Their exact meaning depends on whether you're doing a merge or a rebase.

During a merge:

```text
ours
→ current branch

theirs
→ branch being merged
```

During a rebase, the mental model can be less intuitive because the commits are being replayed.

Therefore, don't blindly use commands like:

```bash
git checkout --ours
git checkout --theirs
```

without first understanding which side Git considers each one to be.

Modern alternatives may use:

```bash
git restore --ours <file>
git restore --theirs <file>
```

---

# 30. Merge vs Rebase: Interview Answer

If asked:

> "What's the difference between merge and rebase?"

A strong answer:

> **Merge combines two histories and usually preserves their existing structure by creating a merge commit when necessary. Rebase moves/replays commits onto a new base, creating new commit objects and producing a more linear history. Because rebase rewrites commit history, it should generally be avoided on shared history unless the team explicitly expects it.**

---

# 31. Interactive Rebase

Git also supports:

```bash
git rebase -i HEAD~3
```

This means:

> Interactively rebase the last three commits.

You may see:

```text
pick abc123 Add user entity
pick def456 Fix user entity
pick ghi789 Update user entity
```

You can change commands such as:

```text
pick
reword
edit
squash
fixup
drop
```

---

# 32. Why Use Interactive Rebase?

Suppose your feature branch has:

```text
Add authentication
Fix typo
Fix authentication
Fix authentication again
Update code
```

Before creating a PR, you may want:

```text
Add authentication
```

as a clean logical commit.

Interactive rebase can help organize commits.

For example:

```bash
git rebase -i HEAD~5
```

You can squash related commits.

---

# 33. Squashing

Suppose:

```text
A → B → C → D
```

where:

```text
B = Add login
C = Fix typo
D = Fix login
```

You can squash them into:

```text
A → E
```

where E represents the combined logical change.

This can make PR history easier to review.

But remember:

> Squashing rewrites history.

Use it carefully if commits have already been shared.

---

# 34. Practical Team Workflow

For a team project:

```text
main
  │
  ├── feature/authentication
  ├── feature/payment
  └── feature/booking
```

Developer creates:

```bash
git switch main
git pull
git switch -c feature/authentication
```

Work and commit:

```bash
git add .
git commit -m "Implement authentication"
```

Before opening PR, depending on team policy:

### Merge latest main

```bash
git fetch origin
git merge origin/main
```

or:

### Rebase onto latest main

```bash
git fetch origin
git rebase origin/main
```

Then push.

If rebasing commits that were already pushed, you may need:

```bash
git push --force-with-lease
```

rather than blindly using:

```bash
git push --force
```

---

# 35. Why `--force-with-lease` Is Safer

Suppose you rebased your branch.

Your remote branch contains:

```text
A → B → C
```

Your local rewritten history is:

```text
A → B → D
```

Normal push may be rejected because the histories don't fast-forward.

You may need:

```bash
git push --force-with-lease
```

`--force-with-lease` checks that the remote branch is still at the expected state before replacing it.

This is safer than blindly:

```bash
git push --force
```

because another developer may have pushed new work.

---

# 36. Never Blindly Force Push Shared Branches

Avoid:

```bash
git push --force origin main
```

on a shared branch.

You can overwrite remote history and potentially remove other developers' commits from the branch's reachable history.

If force pushing is necessary, use:

```bash
git push --force-with-lease
```

and only when your team workflow permits it.

---

# 37. Practical Example: Feature Branch Behind Main

Suppose Git history is:

```text
A → B → C → D
         \
          E → F
```

`main`:

```text
A → B → C → D
```

`feature`:

```text
A → B → C → E → F
```

You want feature updated with main.

Option 1:

```bash
git switch feature
git merge main
```

Result:

```text
A → B → C → D ── M
         \       /
          E → F
```

Option 2:

```bash
git switch feature
git rebase main
```

Result:

```text
A → B → C → D → E' → F'
```

---

# 38. Which One Should You Use?

A practical rule:

```text
Personal/unshared feature branch
        ↓
      Rebase
        ↓
Clean history
```

```text
Shared/public history
        ↓
       Merge
        ↓
Preserve existing history
```

But always follow your team's established workflow.

---

# 39. Common Mistakes

## Mistake 1 — Rebasing shared branches

Don't casually do:

```bash
git rebase main
```

on a branch that multiple developers are actively using.

---

## Mistake 2 — Force pushing without understanding

Avoid:

```bash
git push --force
```

Prefer:

```bash
git push --force-with-lease
```

when force-pushing is genuinely required.

---

## Mistake 3 — Resolving conflicts without understanding the code

Don't simply click:

```text
Accept Yours
```

or:

```text
Accept Theirs
```

Understand the intended application behavior first.

---

## Mistake 4 — Forgetting `git add` after resolving conflicts

After fixing a conflict:

```bash
git add <file>
```

Then:

```bash
git commit
```

or:

```bash
git rebase --continue
```

---

## Mistake 5 — Panicking during conflicts

A conflict doesn't mean your repository is destroyed.

You can often:

```bash
git merge --abort
```

or:

```bash
git rebase --abort
```

if you need to safely back out.

---

# 40. Interview Questions

## Q1. What is a merge?

Merge combines histories from two branches.

---

## Q2. What is a fast-forward merge?

A merge where the target branch can simply move its reference to the newer commit without creating a merge commit.

---

## Q3. What is a three-way merge?

A merge that considers:

```text
current branch
other branch
common ancestor
```

to determine the combined result.

---

## Q4. What is a merge commit?

A commit created to combine divergent histories, usually containing multiple parent commits.

---

## Q5. What is rebase?

Rebase replays commits onto a new base, creating new commit objects.

---

## Q6. Why does rebase change commit hashes?

Because a commit's identity depends on information including its parent. Changing the parent creates a different commit object.

---

## Q7. Merge vs rebase?

```text
Merge
→ preserves history
→ may create merge commit
→ safer for shared history

Rebase
→ rewrites history
→ creates new commits
→ produces linear history
→ useful for private feature branches
```

---

## Q8. What causes merge conflicts?

Git cannot automatically reconcile incompatible changes, commonly when different branches modify overlapping portions of a file.

---

## Q9. How do you resolve a merge conflict?

```text
1. git status
2. Open conflicted files
3. Decide correct content
4. Remove conflict markers
5. git add <resolved-file>
6. git commit
```

---

## Q10. How do you resolve a rebase conflict?

```text
1. Resolve file
2. git add <file>
3. git rebase --continue
```

---

## Q11. How do you cancel a merge?

```bash
git merge --abort
```

---

## Q12. How do you cancel a rebase?

```bash
git rebase --abort
```

---

## Q13. What is interactive rebase?

```bash
git rebase -i
```

It allows you to reorganize commits by actions such as:

```text
pick
reword
squash
fixup
edit
drop
```

---

## Q14. Why shouldn't you rebase shared history?

Because rebase creates new commit IDs and can cause collaborators' histories to diverge from the rewritten branch.

---

# 41. Hands-On Exercise

Create a repository:

```bash
mkdir merge-practice
cd merge-practice
git init
```

Create `app.txt`:

```text
Version 1
```

Commit:

```bash
git add .
git commit -m "Initial version"
```

Create feature:

```bash
git switch -c feature/login
```

Modify:

```text
Version 1
Login feature
```

Commit:

```bash
git add .
git commit -m "Add login"
```

Switch to main:

```bash
git switch main
```

Modify the same area:

```text
Version 1
Main feature
```

Commit:

```bash
git add .
git commit -m "Add main feature"
```

Now:

```bash
git merge feature/login
```

You should get a conflict.

Run:

```bash
git status
```

Open the file.

You should see conflict markers.

Resolve the file manually.

Then:

```bash
git add app.txt
git commit
```

Finally:

```bash
git log --oneline --graph --all
```

Study the resulting graph.

---

# 42. Rebase Exercise

Create another branch:

```bash
git switch -c feature/payment
```

Make two commits:

```bash
git add .
git commit -m "Add payment model"

git add .
git commit -m "Add payment service"
```

Switch to main:

```bash
git switch main
```

Make another commit.

Then:

```bash
git switch feature/payment
git rebase main
```

Inspect:

```bash
git log --oneline --graph --all
```

Notice that the feature commits now appear after the latest main commit.

---

# 43. 20/80 Summary

Remember:

```text
MERGE
```

combines histories:

```text
       feature
       /
A → B → C → M
       \   /
        D
```

and may create a merge commit.

```text
REBASE
```

replays commits:

```text
A → B → C → D' → E'
```

and creates new commit identities.

### Merge

```text
Preserves history
Safe for shared history
May create merge commits
```

### Rebase

```text
Rewrites history
Creates new commits
Produces linear history
Best for appropriate private/unshared branches
```

### Conflict

```text
Git cannot determine the intended result
             ↓
       Human resolves
             ↓
         git add
             ↓
 merge → git commit
 rebase → git rebase --continue
```

The most important rule:

> **Merge combines histories. Rebase rewrites and replays history.**

The next file is:

```text
06-remote-repositories-fetch-pull-push.md
```

It will explain **GitHub/remotes, `origin`, `fetch`, `pull`, `push`, upstream branches, tracking, non-fast-forward errors, and what actually happens when you push a commit to GitHub.**
