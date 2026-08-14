# 04 — Branches and Branching Strategy

> **Goal:** Understand what branches are, why developers use them, how branches work internally, and how to use them safely in real projects.

Branches are one of the most important Git concepts for professional development.

---

# 1. What Is a Branch?

A Git branch is essentially a **reference (pointer) to a commit**.

Suppose your history is:

```text
A → B → C
        ↑
       main
```

The `main` branch points to commit `C`.

If you create a new branch:

```bash
git branch feature/login
```

Git creates another reference:

```text
A → B → C
        ↑
       main
        ↑
   feature/login
```

Both branches currently point to the same commit.

---

# 2. A Branch Is NOT a Copy of Your Project

A common beginner misunderstanding is:

> "Creating a branch creates another copy of the project."

Not conceptually.

A branch is primarily a **small reference to a commit**.

```text
main ───────────→ C
feature/login ──→ C
```

The commits and objects are shared.

This is why creating a branch is cheap.

---

# 3. Creating a Branch

Create:

```bash
git branch feature/login
```

List branches:

```bash
git branch
```

Example:

```text
* main
  feature/login
```

The `*` indicates your current branch.

---

# 4. Creating and Switching in One Command

Instead of:

```bash
git branch feature/login
git switch feature/login
```

you can use:

```bash
git switch -c feature/login
```

This:

1. Creates the branch.
2. Switches to it.

Example:

```bash
git switch -c feature/login
```

Now:

```text
HEAD
 ↓
feature/login
 ↓
C
```

---

# 5. `git switch`

Use:

```bash
git switch feature/login
```

to switch to an existing branch.

Example:

```text
main
feature/login
feature/payment
```

Switch:

```bash
git switch feature/payment
```

Now:

```text
HEAD
 ↓
feature/payment
```

---

# 6. `git checkout`

You will still see:

```bash
git checkout
```

in older tutorials and real projects.

Historically, `checkout` was used for several different purposes:

```bash
git checkout branch
git checkout <commit>
git checkout -b feature/login
```

Modern Git provides clearer commands:

```bash
git switch
git restore
```

Use:

```bash
git switch
```

for changing branches.

Use:

```bash
git restore
```

for restoring file contents.

This separation makes the commands easier to understand.

---

# 7. Branches Move When You Commit

This is extremely important.

Suppose:

```text
A → B → C
        ↑
       main
```

You create:

```bash
git switch -c feature/login
```

Now:

```text
A → B → C
        ↑
       main
        ↑
   feature/login
```

Make a commit:

```bash
git commit -m "Add login endpoint"
```

Now:

```text
A → B → C → D
        ↑     ↑
       main  feature/login
```

Notice:

```text
main → C
feature/login → D
```

The branch you are currently on moves forward.

---

# 8. Why Does `main` Not Move?

Because the commit was created while you were on:

```text
feature/login
```

Git moves the current branch reference.

It does not automatically move every branch.

Therefore:

```text
main
 ↓
C

feature/login
 ↓
D
```

This is the key to understanding Git branches internally.

---

# 9. `HEAD` and Branches

Normally:

```text
HEAD
 ↓
feature/login
 ↓
D
```

`HEAD` points to the current branch.

The branch points to the current commit.

So:

```text
HEAD → branch → commit
```

For example:

```text
HEAD
 ↓
refs/heads/feature/login
 ↓
D
```

---

# 10. Branch References Internally

Inside `.git`, local branch references are represented under:

```text
.git/refs/heads/
```

For example:

```text
.git/
└── refs/
    └── heads/
        ├── main
        └── feature/
            └── login
```

Conceptually:

```text
.git/refs/heads/main
        ↓
     commit C

.git/refs/heads/feature/login
        ↓
     commit D
```

The files contain commit IDs.

You don't normally need to edit these manually.

---

# 11. Inspect a Branch

Show the commit pointed to by a branch:

```bash
git rev-parse main
```

Example:

```text
abc123...
```

For your current branch:

```bash
git rev-parse HEAD
```

You can compare:

```bash
git rev-parse main
git rev-parse feature/login
```

If they return different hashes, the branches currently point to different commits.

---

# 12. Viewing Branches

Basic:

```bash
git branch
```

More detailed:

```bash
git branch -v
```

All local and remote branches:

```bash
git branch -a
```

Example:

```text
* main
  feature/login
  feature/payment
  remotes/origin/main
  remotes/origin/develop
```

---

# 13. Deleting a Branch

Once a feature has been merged:

```bash
git branch -d feature/login
```

The `-d` option asks Git to safely delete the branch.

If Git determines that the branch contains unmerged work, it may refuse.

You can force deletion:

```bash
git branch -D feature/login
```

Be careful with `-D`.

It can delete a branch reference even when Git believes there may be unmerged work.

---

# 14. Branch Deletion Does Not Necessarily Delete Commits Immediately

Suppose:

```text
A → B → C → D
        ↑     ↑
       main  feature
```

Delete:

```bash
git branch -d feature
```

The branch reference disappears:

```text
A → B → C → D
        ↑
       main
```

If commit D isn't reachable from another reference, it may eventually become unreachable.

Git's garbage collection can eventually remove unreachable objects.

This is why tools such as:

```bash
git reflog
```

can sometimes help recover commits.

We'll cover recovery in File 09.

---

# 15. Feature Branches

A common professional workflow is:

```text
main
 │
 ├── feature/authentication
 ├── feature/payment
 ├── feature/booking
 └── feature/notifications
```

Each developer works on a separate feature branch.

For example:

```bash
git switch -c feature/authentication
```

Work:

```bash
git add .
git commit -m "Add authentication"
```

Push:

```bash
git push -u origin feature/authentication
```

Then open a Pull Request.

---

# 16. Why Not Work Directly on `main`?

You technically can.

But in a team project, directly modifying `main` creates problems.

Imagine:

```text
Developer A → authentication
Developer B → payment
Developer C → notifications
```

If everyone commits directly to `main`:

```text
main
 ↓
A
 ↓
B
 ↓
C
 ↓
D
```

It becomes harder to:

* review changes
* isolate features
* test changes
* revert individual features
* coordinate multiple developers

Feature branches provide isolation.

---

# 17. Real Spring Boot Example

Suppose your team is building:

```text
SeatForge
```

The repository has:

```text
main
```

You need to implement authentication.

Create:

```bash
git switch -c feature/authentication
```

Your branch becomes:

```text
main
 │
 A
 │
 B
 │
 C
 │
 ↑
feature/authentication
```

You implement:

```text
JWT authentication
Spring Security configuration
Login endpoint
User authentication service
```

Commit:

```bash
git add .
git commit -m "Implement JWT authentication"
```

Now:

```text
main
 │
 A
 │
 B
 │
 C
       \
        D
        ↑
feature/authentication
```

The main branch remains untouched.

---

# 18. Multiple Commits on a Feature Branch

A feature branch can contain several logical commits:

```text
A → B → C → D → E
              ↑
       feature/authentication
```

For example:

```text
C
↓
Add User entity

D
↓
Add authentication service

E
↓
Add JWT security configuration
```

Eventually the branch is reviewed and merged.

---

# 19. Branching Is About Isolating Work

Think of branches as separate lines of development:

```text
                  feature/auth
                 /
A ── B ── C ────
                 \
                  feature/payment
```

Developers can work independently.

Git keeps the histories separate until you decide to combine them.

---

# 20. `main`, `master`, `develop`

You may encounter different branch names.

Common names:

```text
main
master
develop
```

`main` is now the common default branch name for many repositories.

There is nothing technically magical about the name `main`.

It is simply a branch reference.

---

# 21. Remote Branches

Suppose GitHub has:

```text
origin/main
origin/develop
```

These are remote-tracking references.

You may see:

```bash
git branch -a
```

Output:

```text
* main
  feature/login
  remotes/origin/main
  remotes/origin/develop
```

Important distinction:

```text
main
```

is your local branch.

```text
origin/main
```

is your local reference to the remote branch named `main` on `origin`.

This becomes much clearer when we study `fetch`, `pull`, and `push`.

---

# 22. Local Branch vs Remote-Tracking Branch

Think:

```text
Your repository:

main ───────────────→ C

origin/main ────────→ B
```

This means:

```text
Your local main = C
Your remembered remote main = B
```

Maybe someone pushed commit C to GitHub and you haven't synchronized yet.

After fetching:

```text
git fetch origin
```

your remote-tracking reference can move:

```text
main ───────────────→ C
origin/main ────────→ C
```

We'll explore this deeply in File 06.

---

# 23. Creating a Branch from a Specific Commit

You can create a branch from a specific commit:

```bash
git branch old-version <commit>
```

Then:

```bash
git switch old-version
```

This is useful when investigating historical versions.

Example:

```text
A → B → C → D
    ↑
 old-version
```

---

# 24. Branch from Another Branch

You can create:

```bash
git switch main
git switch -c feature/payment
```

The new branch starts from the current commit of `main`.

---

# 25. Branch from a Remote Branch

Suppose:

```text
origin/develop
```

exists.

You can create a local branch based on it:

```bash
git switch -c develop --track origin/develop
```

Now:

```text
develop
   ↓
origin/develop
```

They initially point to the same commit.

The tracking relationship makes later synchronization easier.

---

# 26. Tracking Branches

A local branch can track a remote branch.

For example:

```text
main
 ↓
origin/main
```

Then:

```bash
git pull
```

knows which remote branch to pull from.

You can inspect tracking information:

```bash
git branch -vv
```

Example:

```text
* main abc123 [origin/main] Add authentication
```

This tells you that local `main` is tracking `origin/main`.

---

# 27. What Does `git push -u` Do?

First push of a new branch:

```bash
git push -u origin feature/authentication
```

The `-u` means:

> Set the upstream/tracking relationship.

After that, you can often simply use:

```bash
git push
```

and:

```bash
git pull
```

because Git knows the corresponding remote branch.

---

# 28. Branch Naming Conventions

Use descriptive names.

Good:

```text
feature/user-authentication
feature/payment-api
feature/seat-booking
bugfix/jwt-expiration
hotfix/payment-failure
chore/update-dependencies
```

Avoid:

```text
test
abc
new
branch1
mybranch
final
final2
```

A branch name should communicate its purpose.

---

# 29. Common Branch Categories

A practical convention:

```text
feature/
bugfix/
hotfix/
chore/
refactor/
docs/
```

Examples:

```text
feature/add-booking
bugfix/fix-seat-lock
hotfix/payment-timeout
chore/update-spring-boot
refactor/user-service
docs/api-documentation
```

The exact convention depends on the team.

---

# 30. Feature Branch Workflow

A typical workflow:

```text
1. Update main
2. Create feature branch
3. Implement feature
4. Commit changes
5. Push branch
6. Open Pull Request
7. Review
8. Fix review comments
9. Merge
10. Delete feature branch
```

Commands:

```bash
git switch main
git pull

git switch -c feature/authentication

# work...

git status
git add .
git commit -m "Implement authentication"

git push -u origin feature/authentication
```

After the PR is merged:

```bash
git switch main
git pull
git branch -d feature/authentication
```

---

# 31. Branch Divergence

This is an important concept before learning merge/rebase.

Suppose:

```text
       D ── E     feature
      /
A ── B ── C      main
```

The branches have **diverged**.

They share:

```text
A → B
```

but then developed separately.

```text
main:
A → B → C

feature:
A → B → D → E
```

Eventually you need to integrate them.

That is where:

```text
merge
```

and:

```text
rebase
```

come in.

---

# 32. Branch Comparison

To see commits that are in one branch but not another:

```bash
git log main..feature/login
```

This means:

> Show commits reachable from `feature/login` that aren't reachable from `main`.

Useful command:

```bash
git diff main..feature/login
```

This compares changes between the branches.

---

# 33. Finding the Common Ancestor

Suppose:

```text
       D
      /
A → B
      \
       C
```

`B` is the common ancestor.

Git can find common ancestors when performing merges.

Command:

```bash
git merge-base main feature/login
```

This returns the common ancestor commit.

This becomes important in merge algorithms.

---

# 34. Fast-Forward Merge

Suppose:

```text
A → B → C
        ↑
       main

A → B → C → D
             ↑
           feature
```

There is no divergence.

You can merge:

```bash
git switch main
git merge feature
```

Git can simply move `main` forward:

```text
A → B → C → D
             ↑
            main
```

No merge commit is necessary.

This is called a:

> **Fast-forward merge**

---

# 35. Non-Fast-Forward Merge

Suppose:

```text
       D
      /
A → B → C
```

Now both branches have their own commits.

A merge may produce:

```text
       D ──┐
      /    │
A → B → C ─┴→ M
```

`M` is a merge commit.

This is covered in detail in the next file.

---

# 36. Branch Strategy for Your Team Project

For a small team of four developers, a simple workflow is enough.

Use:

```text
main
 │
 ├── feature/authentication
 ├── feature/booking
 ├── feature/payment
 └── feature/notifications
```

Recommended rules:

```text
1. Don't directly push to main.
2. Create a feature branch.
3. Make small logical commits.
4. Push the feature branch.
5. Open a Pull Request.
6. Review the code.
7. Merge after approval.
8. Delete the feature branch.
```

This gives you a clean team workflow without unnecessary Git complexity.

---

# 37. Common Beginner Mistakes

## Mistake 1 — Working directly on main

Avoid this in collaborative projects.

Prefer:

```bash
git switch -c feature/my-feature
```

---

## Mistake 2 — Creating a branch but forgetting to switch

You run:

```bash
git branch feature/login
```

but remain on:

```text
main
```

Check:

```bash
git branch
```

The `*` tells you where you are.

Or use:

```bash
git switch feature/login
```

---

## Mistake 3 — Confusing `main` with `origin/main`

These are different references:

```text
main
```

= local branch

```text
origin/main
```

= remote-tracking branch

---

## Mistake 4 — Force deleting branches carelessly

Avoid:

```bash
git branch -D feature/login
```

unless you understand what work you're discarding.

Prefer:

```bash
git branch -d feature/login
```

---

## Mistake 5 — Naming branches poorly

Avoid:

```text
new
test
abc
branch
```

Prefer:

```text
feature/add-login
bugfix/fix-jwt
```

---

# 38. Interview Questions

## Q1. What is a Git branch?

A branch is essentially a reference that points to a commit.

---

## Q2. Why are Git branches lightweight?

Because a branch is primarily a reference to a commit rather than a complete copy of the repository.

---

## Q3. What happens when you commit on a branch?

The new commit is created and the current branch reference moves to that new commit.

---

## Q4. What is HEAD?

`HEAD` represents the current position in the repository, normally pointing to the current branch.

---

## Q5. What is `origin/main`?

`origin/main` is a remote-tracking reference representing the last known state of the `main` branch on the remote named `origin`.

---

## Q6. What is a tracking branch?

A local branch configured to follow a remote branch, such as:

```text
main → origin/main
```

---

## Q7. Why use feature branches?

They isolate development work, make code review easier, reduce risk to shared branches, and allow multiple developers to work independently.

---

## Q8. What is a fast-forward merge?

A merge where the target branch can simply move its reference forward because it has not diverged from the source branch.

---

## Q9. What is a branch internally?

A branch is essentially a reference to a commit.

For a local branch:

```text
.git/refs/heads/<branch>
```

may contain the commit ID it points to, although references can also be stored in packed form.

---

## Q10. What happens when you delete a branch?

Git removes the branch reference. Commits that are still reachable through other references remain safe; commits that become unreachable may eventually be garbage-collected.

---

# 39. Hands-On Exercise

Create a repository:

```bash
mkdir branch-practice
cd branch-practice
git init
```

Create a file:

```text
app.txt
```

Add:

```text
Version 1
```

Commit:

```bash
git add .
git commit -m "Initial version"
```

Create a branch:

```bash
git switch -c feature/login
```

Modify:

```text
app.txt
```

to:

```text
Version 1
Login feature
```

Commit:

```bash
git add .
git commit -m "Add login feature"
```

Now inspect:

```bash
git log --oneline --graph --all
```

You should understand why:

```text
main
   ↓
Commit 1

feature/login
   ↓
Commit 2
```

Now switch back:

```bash
git switch main
```

Check:

```bash
cat app.txt
```

Then:

```bash
git switch feature/login
```

Check again:

```bash
cat app.txt
```

Observe how the working directory changes based on the branch you are currently on.

---

# 40. Advanced Exercise: Inspect Branch Pointers

Run:

```bash
git rev-parse main
```

Then:

```bash
git rev-parse feature/login
```

You should get different commit IDs.

Now:

```bash
git rev-parse HEAD
```

While on `feature/login`, `HEAD` should resolve to the same commit as `feature/login`.

Conceptually:

```text
HEAD
 ↓
feature/login
 ↓
Commit 2
```

Switch:

```bash
git switch main
```

Then:

```bash
git rev-parse HEAD
```

Now `HEAD` should resolve to the commit pointed to by `main`.

You have just observed Git's branch-reference model directly.

---

# 41. 20/80 Summary

The most important concepts from this file:

```text
Branch
   ↓
Reference to a commit
```

```text
HEAD
   ↓
Current branch
   ↓
Current commit
```

```text
main
feature/auth
feature/payment
```

are simply different references pointing to commits.

When you commit:

```text
Current branch
      ↓
moves to
      ↓
new commit
```

A professional workflow is:

```text
main
  ↓
create feature branch
  ↓
develop
  ↓
commit
  ↓
push
  ↓
Pull Request
  ↓
review
  ↓
merge
  ↓
delete feature branch
```

And the key internal model is:

```text
                  HEAD
                   ↓
                 Branch
                   ↓
                 Commit
                   ↓
                 Tree
                   ↓
             Blobs / Trees
```

> **Remember:** A branch is not a copy of your project. It is a movable reference to a commit.

The next file will build directly on this:

```text
05-merge-rebase-and-conflicts.md
```

There you'll learn **how Git combines branches, what happens internally during a merge, how rebase works, why conflicts happen, and how to resolve them professionally.**
