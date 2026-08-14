# 07 — Undoing Changes: Reset, Revert, Restore & Stash

> **Goal:** Learn how to safely undo changes in Git and understand the difference between `restore`, `reset`, `revert`, and `stash`.
>
> This file focuses heavily on **real-world scenarios**, because knowing how to recover from mistakes is one of the most valuable Git skills.

---

# 1. Why Git Has So Many Undo Commands

Git has multiple states:

```text
Working Directory
       ↓
Staging Area
       ↓
Commit
       ↓
Remote Repository
```

Because a mistake can happen at any of these levels, Git has different tools for different situations.

The most important commands are:

```text
git restore
git reset
git revert
git stash
```

They are **not interchangeable**.

---

# 2. The Most Important Mental Model

Think of Git as having three local layers:

```text
                 HEAD
                  ↓
             Last Commit
                  ↓
             Staging Area
                  ↓
          Working Directory
```

And then the remote:

```text
                 GitHub
                   ↑
                   │
              git push
                   │
              Local Git
```

Different commands affect different layers.

---

# 3. Quick Comparison

| Command                | Main purpose                                               |
| ---------------------- | ---------------------------------------------------------- |
| `git restore`          | Restore file contents                                      |
| `git restore --staged` | Unstage changes                                            |
| `git reset`            | Move HEAD/branch and optionally reset staging/working tree |
| `git revert`           | Create a new commit that reverses an earlier commit        |
| `git stash`            | Temporarily save uncommitted changes                       |

The most important rule:

```text
restore
→ file-level undo

reset
→ history/reference + staging/working-tree manipulation

revert
→ history-safe undo through a new commit

stash
→ temporarily put unfinished work aside
```

---

# 4. Scenario 1 — You Modified a File and Want to Discard It

Suppose:

```text
UserService.java
```

was committed as:

```java
return userRepository.findById(id);
```

You modify it:

```java
return userRepository.findById(id)
        .orElseThrow();
```

Then decide:

> "I don't want this change."

Check:

```bash
git status
```

Then:

```bash
git restore UserService.java
```

The working file is restored.

---

# 5. What Does `git restore` Do?

At a high level:

```text
Modified Working File
        ↓
git restore file
        ↓
Restore from Git's known version
```

For a normal unstaged modification, Git restores the file from the index.

Conceptually:

```text
HEAD
 ↓
Index
 ↓
Working Directory
```

If the index contains the original version:

```text
git restore file
```

makes the working file match the index.

---

# 6. Important Warning About `git restore`

If you have uncommitted changes:

```bash
git restore UserService.java
```

can discard them.

For example:

```text
You wrote 2 hours of code
        ↓
git restore UserService.java
        ↓
Changes discarded
```

So before using it, make sure you really want to throw away the changes.

---

# 7. Scenario 2 — You Staged the Wrong File

Suppose:

```bash
git add UserService.java
```

Then:

```bash
git status
```

shows:

```text
Changes to be committed:
    modified: UserService.java
```

But you don't want it in the next commit.

Use:

```bash
git restore --staged UserService.java
```

Now:

```text
Staging Area
     ↓
removed from staging
     ↓
Working Directory
```

Your modifications are still present.

---

# 8. `restore` vs `restore --staged`

This distinction is extremely important.

### Discard working-tree changes

```bash
git restore UserService.java
```

Effect:

```text
Working Directory
     ↓
restored
```

### Unstage changes

```bash
git restore --staged UserService.java
```

Effect:

```text
Staging Area
     ↓
unstaged
```

The second command normally does **not** throw away your working changes.

---

# 9. Scenario 3 — You Staged a File and Want to Discard Everything

Suppose:

```bash
git add UserService.java
```

Now the file is staged.

You want to completely discard the changes.

First:

```bash
git restore --staged UserService.java
```

Then:

```bash
git restore UserService.java
```

Conceptually:

```text
Staged
  ↓
Unstaged
  ↓
Discarded
```

This is safer to understand than blindly using more destructive commands.

---

# 10. What Is `git reset`?

`git reset` is more powerful.

It can move the current branch/HEAD and optionally reset the staging area and working tree.

The three important forms are:

```bash
git reset --soft
git reset --mixed
git reset --hard
```

The default mode is:

```bash
git reset --mixed
```

---

# 11. Understanding Reset Through the Three Areas

Suppose:

```text
HEAD
 ↓
Commit C

Index
 ↓
same state

Working Directory
 ↓
same state
```

Now:

```bash
git reset HEAD~1
```

moves HEAD back one commit and resets the index accordingly.

The working directory is generally preserved.

This is why reset behavior becomes much easier if you think in terms of:

```text
HEAD
Index
Working Tree
```

---

# 12. `git reset --soft`

Example:

```bash
git reset --soft HEAD~1
```

Effect:

```text
HEAD
 ↓
moves backward

Index
 ↓
keeps changes staged

Working Directory
 ↓
keeps changes
```

Conceptually:

```text
Before:

A → B → C
        ↑
       HEAD

After:

A → B
    ↑
   HEAD

Changes from C remain staged.
```

---

# 13. When Is `--soft` Useful?

Suppose you accidentally made a bad commit message:

```text
Add things
```

but the code is correct.

You can:

```bash
git reset --soft HEAD~1
```

Now the commit disappears from the current branch history, but the changes remain staged.

You can create a better commit:

```bash
git commit -m "Add user authentication"
```

---

# 14. `git reset --mixed`

This is the default reset mode.

```bash
git reset --mixed HEAD~1
```

or simply:

```bash
git reset HEAD~1
```

Effect:

```text
HEAD
 ↓
moves backward

Index
 ↓
reset

Working Directory
 ↓
keeps changes
```

So your changes become **unstaged**.

Conceptually:

```text
Before:

A → B → C
        ↑
       HEAD

After:

A → B
    ↑
   HEAD

Working Directory:
contains changes from C

Staging:
does not contain those changes
```

---

# 15. When Is `--mixed` Useful?

Suppose you made a commit too early:

```bash
git commit -m "Work"
```

Then realize:

> "I need to modify this code before committing it."

Use:

```bash
git reset HEAD~1
```

The commit is removed from the current branch, but your code remains in the working directory.

You can continue working.

---

# 16. `git reset --hard`

This is the dangerous one.

```bash
git reset --hard HEAD~1
```

Conceptually:

```text
HEAD
 ↓
moves backward

Index
 ↓
reset

Working Directory
 ↓
reset
```

So:

```text
HEAD
Index
Working Tree
```

are all moved/reset to the target state.

---

# 17. Why Is `--hard` Dangerous?

Suppose:

```text
You wrote 3 hours of code.
```

Then:

```bash
git reset --hard HEAD
```

Your uncommitted changes can be discarded.

Therefore:

> Never use `git reset --hard` casually.

Before using it, make sure you don't need the changes.

---

# 18. Reset Comparison

| Command   | HEAD  | Staging   | Working Tree |
| --------- | ----- | --------- | ------------ |
| `--soft`  | moved | preserved | preserved    |
| `--mixed` | moved | reset     | preserved    |
| `--hard`  | moved | reset     | reset        |

Remember:

```text
soft
→ commit moves

mixed
→ commit + staging move/reset

hard
→ commit + staging + working tree reset
```

---

# 19. Scenario 4 — Undo Last Local Commit

Suppose:

```text
A → B → C
        ↑
       HEAD
```

You haven't pushed C yet.

You want to remove the commit but keep the code.

Use:

```bash
git reset --soft HEAD~1
```

Now:

```text
A → B
    ↑
   HEAD
```

The changes from C remain staged.

---

# 20. Scenario 5 — Remove Commit but Keep Changes Unstaged

Use:

```bash
git reset HEAD~1
```

This is equivalent to:

```bash
git reset --mixed HEAD~1
```

Now:

```text
A → B
    ↑
   HEAD
```

Your code remains in the working directory but isn't staged.

---

# 21. Scenario 6 — Remove Commit and Changes

If you're absolutely certain you want to discard the commit and its changes:

```bash
git reset --hard HEAD~1
```

Result:

```text
A → B
    ↑
   HEAD
```

The changes introduced by C are removed from the working tree and index.

Again:

> Be extremely careful with `--hard`.

---

# 22. Reset and Shared Branches

Suppose you've already pushed:

```text
A → B → C
        ↑
      GitHub
```

You run:

```bash
git reset --hard HEAD~1
```

locally:

```text
A → B
    ↑
   HEAD
```

But GitHub still has:

```text
A → B → C
```

Now your histories differ.

If you force push:

```bash
git push --force
```

you rewrite the remote branch.

This can disrupt other developers.

Therefore:

> Avoid resetting shared/public history unless you fully understand the consequences and your team explicitly permits it.

---

# 23. What Is `git revert`?

`git revert` is different.

Instead of deleting an old commit from history, it creates a **new commit that reverses its changes**.

Suppose:

```text
A → B → C
```

C introduced a bug.

Run:

```bash
git revert C
```

Git creates:

```text
A → B → C → D
             ↑
          reverses C
```

History remains intact.

---

# 24. Why Is Revert Safer for Shared Branches?

Suppose GitHub contains:

```text
A → B → C
```

Everyone already has C.

If you use reset:

```text
A → B
```

you rewrite history.

But if you use revert:

```text
A → B → C → D
```

everyone keeps the same history.

Commit D simply cancels C's changes.

This is why:

> `git revert` is usually preferred for undoing changes on shared branches.

---

# 25. Example: Production Bug

Suppose:

```text
A → B → C → D
```

Commit D introduced a production bug.

You shouldn't necessarily rewrite production history.

Instead:

```bash
git revert D
```

Now:

```text
A → B → C → D → E
                 ↑
             fix/reversal
```

The history clearly shows:

```text
D = introduced change
E = reverted D
```

This is excellent for auditing.

---

# 26. Reset vs Revert

This is one of the most common interview questions.

### Reset

```text
Moves branch/HEAD
Can rewrite local history
Useful for local/unshared commits
```

### Revert

```text
Creates a new reversing commit
Preserves history
Preferred for shared branches
```

A strong interview answer:

> **Reset moves the branch reference and can rewrite history, while revert creates a new commit that reverses an earlier commit without removing it from history.**

---

# 27. Scenario 7 — You Have Unfinished Work

Suppose you're working on:

```text
feature/payment
```

You have changes:

```text
PaymentService.java
PaymentController.java
```

Suddenly your manager says:

> "There's a production bug. Fix it immediately."

You cannot easily switch branches because you have uncommitted work.

You could commit unfinished work, but you don't want a bad commit.

Use:

```bash
git stash
```

---

# 28. What Is `git stash`?

`git stash` temporarily saves uncommitted changes and restores your working directory to a clean state.

Conceptually:

```text
Uncommitted work
       ↓
   git stash
       ↓
Stash storage
       ↓
Clean Working Directory
```

Now you can switch branches.

---

# 29. Basic Stash Workflow

Save:

```bash
git stash
```

Check:

```bash
git status
```

Switch:

```bash
git switch main
```

Fix the production bug.

Then return:

```bash
git switch feature/payment
```

Restore your work:

```bash
git stash pop
```

Your unfinished changes come back.

---

# 30. `git stash list`

You can have multiple stashes.

Run:

```bash
git stash list
```

Example:

```text
stash@{0}: WIP on feature/payment
stash@{1}: WIP on feature/auth
stash@{2}: WIP on feature/booking
```

---

# 31. `git stash pop`

```bash
git stash pop
```

Restores the latest stash and removes that stash entry if the application succeeds.

Conceptually:

```text
stash
 ↓
working directory
 ↓
stash entry removed
```

---

# 32. `git stash apply`

```bash
git stash apply
```

restores the stash but keeps the stash entry.

Conceptually:

```text
stash
 ↓
working directory

stash remains
```

This is useful if you want to apply the same stash again or keep it as a backup.

---

# 33. `pop` vs `apply`

| Command           | Restores changes | Removes stash |
| ----------------- | ---------------- | ------------- |
| `git stash pop`   | Yes              | Usually yes   |
| `git stash apply` | Yes              | No            |

---

# 34. Named Stashes

Instead of:

```bash
git stash
```

you can provide a message:

```bash
git stash push -m "Payment API work"
```

Then:

```bash
git stash list
```

might show:

```text
stash@{0}: On feature/payment: Payment API work
```

This is much easier when you have multiple stashes.

---

# 35. Stashing Untracked Files

By default, `git stash` primarily handles tracked modifications.

If you also want to stash untracked files:

```bash
git stash -u
```

or:

```bash
git stash --include-untracked
```

---

# 36. Stash Is Not a Permanent Backup Strategy

Don't treat:

```bash
git stash
```

as long-term project storage.

If the work is important, commit it on an appropriate branch.

Stash is primarily for:

```text
temporary interruption
quick context switch
unfinished local work
```

---

# 37. Scenario 8 — You Accidentally Deleted a File

Suppose:

```text
UserService.java
```

was tracked and you deleted it.

Check:

```bash
git status
```

You may see:

```text
deleted: UserService.java
```

Restore:

```bash
git restore UserService.java
```

Git restores the file from the appropriate known version.

---

# 38. Scenario 9 — You Deleted a File and Staged the Deletion

Suppose:

```bash
rm UserService.java
git add UserService.java
```

Now the deletion is staged.

You can unstage:

```bash
git restore --staged UserService.java
```

Then restore the working file:

```bash
git restore UserService.java
```

---

# 39. Scenario 10 — Undo a Commit Already Pushed

Suppose:

```text
GitHub:

A → B → C
```

Commit C is bad.

Use:

```bash
git revert C
```

Now:

```text
A → B → C → D
```

where D reverses C.

Then:

```bash
git push
```

This is usually the safest workflow for a shared branch.

---

# 40. Scenario 11 — Fix the Last Commit Message

Suppose you made:

```bash
git commit -m "Add things"
```

and haven't pushed yet.

You can use:

```bash
git commit --amend -m "Add authentication"
```

This replaces the previous commit with a new commit containing the updated message.

Conceptually:

```text
Before:

A → B

After amend:

A → B'
```

`B'` has a different commit identity.

---

# 41. Amend Existing Changes

Suppose you committed:

```text
Add authentication
```

then realize you forgot a file.

Add the file:

```bash
git add MissingFile.java
```

Then:

```bash
git commit --amend --no-edit
```

This updates the previous commit.

The commit is rewritten.

Again:

> Don't amend a commit that other developers already depend on unless you understand the consequences.

---

# 42. `git clean`

Sometimes you have untracked files that you want to remove.

Preview:

```bash
git clean -n
```

This performs a dry run.

Example:

```text
Would remove test.txt
Would remove temp/
```

Then:

```bash
git clean -f
```

removes untracked files.

Be careful.

You can also remove untracked directories with:

```bash
git clean -fd
```

Never run destructive cleanup commands without first understanding what will be deleted.

---

# 43. Reset vs Restore vs Revert vs Stash

A very useful table:

| Situation                                     | Command                     |
| --------------------------------------------- | --------------------------- |
| Discard unstaged file changes                 | `git restore file`          |
| Unstage a file                                | `git restore --staged file` |
| Remove local commit but keep changes staged   | `git reset --soft HEAD~1`   |
| Remove local commit but keep changes unstaged | `git reset HEAD~1`          |
| Remove local commit and changes               | `git reset --hard HEAD~1`   |
| Undo shared commit safely                     | `git revert <commit>`       |
| Temporarily save unfinished work              | `git stash`                 |
| Restore stashed work                          | `git stash pop`             |
| Restore stash but keep it                     | `git stash apply`           |
| Modify last local commit                      | `git commit --amend`        |

---

# 44. The Decision Tree

When you want to undo something, ask:

```text
What do I want to undo?
          │
          ├── Uncommitted file changes?
          │       ↓
          │   git restore
          │
          ├── Staged changes?
          │       ↓
          │   git restore --staged
          │
          ├── Local commit?
          │       ↓
          │   git reset
          │
          ├── Shared/pushed commit?
          │       ↓
          │   git revert
          │
          └── Need to temporarily hide work?
                  ↓
              git stash
```

This decision tree is worth memorizing.

---

# 45. What Happens Internally During Reset?

Suppose:

```text
A → B → C
        ↑
       main
        ↑
       HEAD
```

Run:

```bash
git reset --mixed B
```

The branch reference moves:

```text
A → B
    ↑
   main
```

HEAD follows:

```text
HEAD
 ↓
main
 ↓
B
```

The index is reset to match B.

The working tree remains as it was, unless the mode specifies otherwise.

This is why reset can be powerful and dangerous.

---

# 46. What Happens Internally During Revert?

Suppose:

```text
A → B → C
```

C changed:

```text
file.txt
```

Running:

```bash
git revert C
```

does not move `main` backward.

Instead Git calculates the inverse of C's changes and creates a new commit:

```text
A → B → C → D
```

D contains the reverse changes.

So:

```text
reset
→ move reference

revert
→ create new commit
```

---

# 47. Why Can Deleted Commits Sometimes Be Recovered?

Suppose:

```text
A → B → C
        ↑
       main
```

You run:

```bash
git reset --hard B
```

Now:

```text
A → B
    ↑
   main
```

It may look like C disappeared.

But Git may still know about C through the **reflog**.

Run:

```bash
git reflog
```

You may see:

```text
B HEAD@{0}: reset: moving to HEAD~1
C HEAD@{1}: commit: Add feature
```

You can potentially recover C.

This will be covered deeply in File 09.

---

# 48. Practical Recovery Scenario

Suppose you accidentally run:

```bash
git reset --hard HEAD~2
```

and panic.

Don't immediately make more changes.

First:

```bash
git reflog
```

Find the previous commit:

```text
abc123 HEAD@{1}: commit: Add payment
```

Then inspect:

```bash
git show abc123
```

You may be able to recover by creating a branch:

```bash
git branch recovery abc123
```

Now:

```text
recovery → abc123
```

Your commit has a reference again.

This is why Git is often much more recoverable than beginners expect.

---

# 49. Real Spring Boot Scenario

You're working on:

```text
feature/booking
```

You have:

```text
BookingService.java
BookingController.java
```

with unfinished changes.

Suddenly you need to fix:

```text
main → production bug
```

Do:

```bash
git stash push -m "WIP booking"
```

Switch:

```bash
git switch main
git pull
```

Create:

```bash
git switch -c hotfix/booking-error
```

Fix the bug:

```bash
git add .
git commit -m "Fix booking error"
git push -u origin hotfix/booking-error
```

After the hotfix is handled:

```bash
git switch feature/booking
```

Restore your work:

```bash
git stash pop
```

Continue development.

This is a real-world use case for stash.

---

# 50. Common Mistakes

## Mistake 1 — Using `reset --hard` without checking

Dangerous:

```bash
git reset --hard
```

You may lose uncommitted changes.

---

## Mistake 2 — Using reset on shared branches

If commits have already been pushed and others depend on them, reset can cause history problems.

Prefer:

```bash
git revert
```

for shared history.

---

## Mistake 3 — Confusing restore and revert

These are completely different.

```text
restore
→ restore file state

revert
→ create commit reversing another commit
```

---

## Mistake 4 — Thinking stash is a backup system

Stash is for temporary work.

Important work should eventually become a proper commit.

---

## Mistake 5 — Forgetting that amend rewrites a commit

```bash
git commit --amend
```

creates a new commit identity.

Avoid casually amending already-published commits.

---

# 51. Interview Questions

## Q1. Difference between reset and revert?

```text
reset
→ moves HEAD/branch
→ can rewrite history

revert
→ creates a new reversing commit
→ preserves existing history
```

---

## Q2. Difference between restore and revert?

```text
restore
→ restores file contents

revert
→ creates a commit that reverses another commit
```

---

## Q3. What does `git reset --soft HEAD~1` do?

Moves HEAD/branch back one commit while keeping the changes staged.

---

## Q4. What does `git reset --mixed HEAD~1` do?

Moves HEAD back one commit and resets the staging area while keeping working-tree changes.

---

## Q5. What does `git reset --hard HEAD~1` do?

Moves HEAD back one commit and resets the index and working tree to that state, potentially discarding uncommitted changes.

---

## Q6. When should you use revert?

When you need to undo a commit while preserving shared history, especially on a shared branch.

---

## Q7. What is `git stash`?

A mechanism for temporarily storing uncommitted changes so you can work with a clean working tree.

---

## Q8. Difference between stash pop and apply?

```text
pop
→ apply stash + remove stash entry

apply
→ apply stash + keep stash entry
```

---

## Q9. What is `git commit --amend`?

It replaces the latest commit with a new commit, allowing you to modify its message or include additional staged changes.

---

## Q10. How can you recover a lost commit?

Often by using:

```bash
git reflog
```

to find the commit and then creating a branch or otherwise referencing it.

---

# 52. Hands-On Exercise 1 — Restore

Create:

```bash
mkdir undo-practice
cd undo-practice
git init
```

Create:

```text
app.txt
```

Commit:

```bash
git add .
git commit -m "Initial commit"
```

Modify the file.

Check:

```bash
git diff
```

Discard:

```bash
git restore app.txt
```

Verify:

```bash
git status
```

---

# 53. Hands-On Exercise 2 — Reset

Create two commits:

```text
A → B
```

Then:

```bash
git reset --soft HEAD~1
```

Check:

```bash
git status
```

Observe that the changes remain staged.

Now commit again:

```bash
git commit -m "Second commit"
```

Repeat with:

```bash
git reset --mixed HEAD~1
```

Observe that changes remain in the working tree but are unstaged.

Only experiment with:

```bash
git reset --hard HEAD~1
```

when you're comfortable losing the changes.

---

# 54. Hands-On Exercise 3 — Revert

Create:

```text
A → B → C
```

Run:

```bash
git revert HEAD
```

Now:

```text
A → B → C → D
```

Inspect:

```bash
git log --oneline
```

Notice:

> The original commit still exists.

The new commit reverses its effect.

---

# 55. Hands-On Exercise 4 — Stash

Modify a file:

```bash
git status
```

Then:

```bash
git stash push -m "WIP"
```

Check:

```bash
git status
```

Your working directory should be clean.

View:

```bash
git stash list
```

Restore:

```bash
git stash pop
```

Check:

```bash
git status
```

Your work should return.

---

# 56. 20/80 Summary

The most important mental model:

```text
Need to undo a file?
        ↓
git restore
```

```text
Need to unstage?
        ↓
git restore --staged
```

```text
Need to undo a local commit?
        ↓
git reset
```

```text
Need to undo a shared/pushed commit?
        ↓
git revert
```

```text
Need to temporarily hide unfinished work?
        ↓
git stash
```

And remember:

```text
RESET
→ moves history/reference

REVERT
→ adds a new reversing commit

RESTORE
→ restores file state

STASH
→ temporarily stores unfinished changes
```

The most important commands:

```bash
git restore <file>
git restore --staged <file>

git reset --soft HEAD~1
git reset HEAD~1
git reset --hard HEAD~1

git revert <commit>

git stash
git stash list
git stash pop
git stash apply

git commit --amend
git reflog
```

> **Golden rule:** Before using a destructive Git command, ask yourself: **"Has this work already been shared with other developers?"** If yes, prefer operations that preserve history, such as `revert`, unless your team explicitly follows a history-rewriting workflow.
