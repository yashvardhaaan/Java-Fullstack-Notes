# 06 — Remote Repositories, Fetch, Pull & Push

> **Goal:** Understand how your local Git repository communicates with GitHub, what `origin` means, how `fetch`, `pull`, and `push` differ, what tracking branches are, and what happens internally when you synchronize repositories.

---

# 1. Local Git vs Remote Git

So far, we have mostly worked with Git locally.

```text
Your Computer
└── Git Repository
```

In team development, you usually also have a remote repository:

```text
Your Computer                    GitHub

Working Directory
       ↓
    Staging
       ↓
 Local Repository
       │
       │ push
       ↓
 Remote Repository
```

The remote repository is commonly hosted on:

* GitHub
* GitLab
* Bitbucket
* Azure Repos

Git itself does not require GitHub.

---

# 2. What Is a Remote Repository?

A remote is another Git repository that your local repository knows about.

For example:

```text
Local repository
       │
       │
       └──────→ GitHub repository
```

You can see configured remotes with:

```bash
git remote
```

More information:

```bash
git remote -v
```

Example:

```text
origin  https://github.com/yashvardhaaan/SeatForge.git (fetch)
origin  https://github.com/yashvardhaaan/SeatForge.git (push)
```

---

# 3. What Is `origin`?

`origin` is the conventional name Git gives to the remote repository when you clone a repository.

For example:

```bash
git clone https://github.com/company/project.git
```

Git usually creates:

```text
origin
```

as the remote name.

Therefore:

```text
origin
↓
GitHub repository
```

Important:

> `origin` is not a special Git protocol or server.

It is simply a remote name.

You could have:

```text
origin
upstream
company
backup
```

---

# 4. Adding a Remote

Suppose you created a project locally:

```bash
git init
```

Now create a repository on GitHub.

Connect it:

```bash
git remote add origin https://github.com/user/project.git
```

Verify:

```bash
git remote -v
```

You should see something similar to:

```text
origin  https://github.com/user/project.git (fetch)
origin  https://github.com/user/project.git (push)
```

---

# 5. Fetch vs Push

There are two directions:

```text
               GitHub
                 ↑
                 │
               push
                 │
                 │
              Local
                 │
                 │
               fetch
                 ↓
               GitHub
```

More intuitively:

```text
Local Repository ──push──→ Remote Repository

Local Repository ←─fetch── Remote Repository
```

---

# 6. `git push`

`git push` sends commits from your local repository to a remote repository.

Example:

```bash
git push origin main
```

Meaning:

```text
local main
     │
     │ push
     ↓
origin/main
```

Suppose:

```text
Local:

A → B → C
        ↑
       main
```

Remote:

```text
A → B
    ↑
 origin/main
```

After:

```bash
git push origin main
```

Remote becomes:

```text
A → B → C
        ↑
   origin/main
```

---

# 7. What Does `git push` Actually Send?

A common misconception is:

> "Git pushes my entire project every time."

Not exactly.

Git determines which objects/refs need to be transferred.

Conceptually:

```text
Local repository
       │
       │
       ├── Existing objects
       │
       └── New commits
              ↓
             push
              ↓
       Remote repository
```

Git transfers the necessary objects and updates the remote branch reference.

If the remote already has objects, Git does not need to resend identical objects unnecessarily.

---

# 8. Push Is About References Too

Suppose:

```text
Local:

main → C

Remote:

main → B
```

After pushing:

```text
Remote:

main → C
```

So a push effectively involves:

```text
1. Transfer required Git objects.
2. Update the remote branch/reference.
```

This is an important internal mental model.

---

# 9. First Push of a New Branch

Suppose you create:

```bash
git switch -c feature/payment
```

Then:

```bash
git commit -m "Add payment"
```

Your branch exists locally.

GitHub doesn't automatically know about it.

Push it:

```bash
git push -u origin feature/payment
```

Now:

```text
Local:

feature/payment → C

Remote:

origin/feature/payment → C
```

And the `-u` option establishes an upstream relationship.

---

# 10. What Is an Upstream Branch?

Suppose:

```text
local branch:
feature/payment

tracks:

remote branch:
origin/feature/payment
```

Conceptually:

```text
feature/payment
        │
        └──── tracks ────→ origin/feature/payment
```

Then you can often simply use:

```bash
git push
```

instead of:

```bash
git push origin feature/payment
```

And:

```bash
git pull
```

instead of specifying the remote and branch every time.

---

# 11. Inspect Tracking Information

Run:

```bash
git branch -vv
```

Example:

```text
* feature/payment abc123 [origin/feature/payment] Add payment
  main            def456 [origin/main] Add authentication
```

This tells you:

* local branch
* current commit
* upstream branch
* relationship to the remote

---

# 12. `git fetch`

This is one of the most important commands to understand.

Run:

```bash
git fetch origin
```

It means:

> Download new information from the remote repository without integrating those changes into your current working branch.

Suppose GitHub has:

```text
A → B → C → D
            ↑
        origin/main
```

but your local repository knows only:

```text
A → B → C
        ↑
       main
```

After:

```bash
git fetch origin
```

your local remote-tracking reference becomes:

```text
A → B → C → D
        ↑     ↑
       main  origin/main
```

Your local `main` did not move.

---

# 13. Fetch Does Not Change Your Working Files

This is extremely important.

When you run:

```bash
git fetch origin
```

Git generally does not modify your current working files.

Before:

```text
Working Directory
       ↓
Local main → C
```

After fetch:

```text
Working Directory
       ↓
Local main → C

origin/main → D
```

You can inspect what changed before deciding how to integrate it.

---

# 14. Why Use `fetch`?

`fetch` is useful when you want to safely inspect remote changes.

For example:

```bash
git fetch origin
```

Then:

```bash
git log main..origin/main --oneline
```

This can show commits that are on the remote-tracking branch but not on your local `main`.

You can also compare:

```bash
git diff main..origin/main
```

This lets you inspect the changes before integrating them.

---

# 15. `git pull`

`git pull` is generally:

```text
git fetch
+
integration
```

The integration may be performed using merge or rebase depending on configuration/options.

Conceptually:

```text
git pull
   ↓
git fetch
   ↓
merge/rebase
```

This is why understanding `fetch` first makes `pull` much easier.

---

# 16. Why Is `git pull` Sometimes Dangerous for Beginners?

Because it does more than download information.

You might run:

```bash
git pull
```

and suddenly get:

```text
Merge conflict
```

Why?

Because Git downloaded remote changes and then attempted to integrate them into your current branch.

If you want to inspect first:

```bash
git fetch
```

Then decide whether you want:

```bash
git merge
```

or:

```bash
git rebase
```

---

# 17. Fetch vs Pull

Remember:

```text
git fetch
→ download remote changes
→ don't integrate into current branch

git pull
→ fetch
→ integrate changes
```

This distinction is a common interview question.

---

# 18. Remote-Tracking Branches

Suppose GitHub contains:

```text
main
feature/payment
feature/auth
```

Your local repository may have:

```text
origin/main
origin/feature/payment
origin/feature/auth
```

These are **remote-tracking references**.

They represent the last state your local Git knows about the remote branches.

They are not the actual branches directly living on GitHub.

Think:

```text
GitHub
   │
   │ fetch
   ↓
Your local remote-tracking references

origin/main
origin/feature/payment
origin/feature/auth
```

---

# 19. Local Branch vs Remote-Tracking Branch

These are different:

```text
main
```

is a local branch.

```text
origin/main
```

is a remote-tracking reference.

Example:

```text
Local repository:

main → C

origin/main → D
```

This means your local `main` and your last-known remote state are different.

You haven't integrated D into your local main yet.

---

# 20. Typical Team Scenario

Suppose you are working on:

```text
feature/booking
```

Meanwhile another developer pushes:

```text
feature/payment
```

You run:

```bash
git fetch origin
```

Now your local repository learns about the new remote commits.

You can inspect:

```bash
git log origin/main --oneline
```

without changing your current branch.

This is safer than blindly pulling.

---

# 21. Pulling Latest Main

Suppose your local `main` is behind:

```text
Local:

A → B → C
        ↑
       main

Remote:

A → B → C → D → E
                ↑
            origin/main
```

Run:

```bash
git switch main
git pull
```

Git fetches:

```text
D
E
```

and integrates them.

Afterward:

```text
A → B → C → D → E
                ↑
               main
```

assuming the integration is straightforward.

---

# 22. Updating a Feature Branch

Suppose:

```text
main:

A → B → C → D

feature:

A → B → C → E → F
```

You want the latest main changes in your feature branch.

First:

```bash
git fetch origin
```

Then choose a strategy.

### Merge

```bash
git switch feature
git merge origin/main
```

### Rebase

```bash
git switch feature
git rebase origin/main
```

The choice depends on your team's workflow.

---

# 23. Why `origin/main` Instead of `main`?

This is a subtle but important concept.

Suppose you haven't updated your local `main`.

You have:

```text
main → C
origin/main → E
```

If you run:

```bash
git merge main
```

while on your feature branch, you're merging your **old local main**.

If you run:

```bash
git merge origin/main
```

you're merging the **latest remote state known after fetch**.

Therefore:

```bash
git fetch origin
git merge origin/main
```

is often a useful explicit workflow.

---

# 24. Push Rejection: Non-Fast-Forward

Suppose remote contains:

```text
A → B → C
```

Your local contains:

```text
A → B → D
```

You try:

```bash
git push
```

Git may reject it:

```text
! [rejected] main -> main (non-fast-forward)
```

Why?

Because pushing your local branch would cause the remote branch to lose the remote commit C from its branch history.

Git protects the remote history.

---

# 25. How to Fix a Non-Fast-Forward Error

First fetch:

```bash
git fetch origin
```

Then inspect:

```bash
git log --oneline --graph --all
```

You may choose:

```bash
git merge origin/main
```

or:

```bash
git rebase origin/main
```

Resolve any conflicts.

Then push again.

---

# 26. Why Does Git Reject the Push?

Imagine:

```text
Remote:

A → B → C
        ↑
      remote

Local:

A → B → D
        ↑
       local
```

If Git simply replaced remote C with D:

```text
A → B → D
```

the remote branch would lose its current history.

Git generally requires a push to be a **fast-forward update** unless you explicitly force it.

---

# 27. Force Push

You can force a remote branch:

```bash
git push --force
```

But this can overwrite remote history.

Avoid using it casually.

Prefer:

```bash
git push --force-with-lease
```

when rewriting your own branch is genuinely required.

---

# 28. `--force-with-lease`

Suppose:

```text
Remote:
A → B → C

You locally rewrote history:
A → B → D
```

You want to replace C with D.

`--force-with-lease` checks that the remote is still in the state you expect.

If another developer pushed:

```text
A → B → C → E
```

your force-with-lease may reject the push rather than overwriting E unexpectedly.

This makes it safer than:

```bash
git push --force
```

---

# 29. Never Force Push Shared Main

Avoid:

```bash
git push --force origin main
```

on a shared team branch.

You can potentially rewrite the branch history for everyone.

Force pushing may be appropriate on a personal feature branch after a rebase, but even then:

```bash
git push --force-with-lease
```

is preferable.

---

# 30. Clone

Instead of manually creating a repository and adding a remote, you often start with:

```bash
git clone https://github.com/company/project.git
```

Git:

1. Creates a directory.
2. Initializes a Git repository.
3. Downloads repository objects.
4. Creates remote-tracking references.
5. Creates a local branch based on the remote's default branch.
6. Configures the `origin` remote.

Conceptually:

```text
GitHub
   │
   │ clone
   ↓
Local repository
   ├── Working directory
   ├── .git/
   ├── origin
   └── local branch
```

---

# 31. What Happens Internally During Clone?

Conceptually:

```text
Remote repository
       ↓
Download objects
       ↓
Create local object database
       ↓
Create remote-tracking references
       ↓
Create working tree
       ↓
Set up origin
       ↓
Checkout default branch
```

So `clone` is much more than copying files.

---

# 32. `git remote -v`

Use:

```bash
git remote -v
```

Example:

```text
origin  https://github.com/company/project.git (fetch)
origin  https://github.com/company/project.git (push)
```

You can also inspect:

```bash
git remote show origin
```

This can provide more information about:

* tracked branches
* remote branches
* local tracking configuration
* push/pull relationships

---

# 33. Changing a Remote URL

Suppose the repository moved.

Check:

```bash
git remote -v
```

Change it:

```bash
git remote set-url origin https://github.com/company/new-project.git
```

Verify:

```bash
git remote -v
```

---

# 34. Multiple Remotes

You can have multiple remotes.

For example:

```text
origin
upstream
```

Common open-source workflow:

```text
Your fork
    ↑
  origin

Original project
    ↑
  upstream
```

You can fetch from:

```bash
git fetch upstream
```

and push to:

```bash
git push origin feature/my-feature
```

This is common when contributing to open-source projects.

---

# 35. Origin vs Upstream

Example:

```text
Original repository
        ↑
     upstream

Your fork
        ↑
      origin
```

Usually:

```text
origin
→ your fork

upstream
→ original repository
```

The names are conventions, not Git requirements.

---

# 36. Authentication

When interacting with GitHub, you need authentication.

Common approaches include:

```text
HTTPS
SSH
GitHub CLI / credential helpers
```

For SSH, your remote might look like:

```text
git@github.com:user/project.git
```

For HTTPS:

```text
https://github.com/user/project.git
```

Modern GitHub usage generally requires appropriate authentication rather than using a GitHub account password directly for Git over HTTPS.

---

# 37. Practical Team Workflow

Suppose your team has:

```text
GitHub
   │
   ├── main
   ├── feature/auth
   ├── feature/payment
   └── feature/booking
```

You start work:

```bash
git clone <repository>
cd project
```

Update main:

```bash
git switch main
git pull
```

Create your branch:

```bash
git switch -c feature/booking
```

Work:

```bash
git status
git diff
```

Commit:

```bash
git add .
git commit -m "Implement booking service"
```

Push:

```bash
git push -u origin feature/booking
```

Open a Pull Request.

After review, the branch gets merged.

Then update your local main:

```bash
git switch main
git pull
```

Delete the local feature branch:

```bash
git branch -d feature/booking
```

---

# 38. A More Controlled Workflow

Instead of blindly using `git pull`, you can do:

```bash
git fetch origin
```

Inspect:

```bash
git log main..origin/main --oneline
```

Then integrate:

```bash
git merge origin/main
```

or:

```bash
git rebase origin/main
```

This gives you more control.

---

# 39. `git pull --rebase`

You may encounter:

```bash
git pull --rebase
```

This means:

```text
fetch
+
rebase
```

instead of the typical merge-based integration.

For example:

```text
Local:

A → B → D
     \
      C → E on remote
```

A pull with rebase may result in:

```text
A → B → C → E → D'
```

rather than creating a merge commit.

Whether your team prefers this depends on its workflow.

---

# 40. Configure Pull Behavior

Git can be configured to prefer a particular pull strategy.

For example:

```bash
git config --global pull.rebase true
```

This tells Git to use rebase by default for pulls where applicable.

Another option is:

```bash
git config --global pull.rebase false
```

which uses merge-based behavior.

Don't change global settings blindly on a team machine; understand your team's workflow first.

---

# 41. Remote Branch Cleanup

Suppose a remote branch was deleted:

```text
GitHub:
feature/old-feature → deleted
```

Your local remote-tracking reference may still show:

```text
origin/feature/old-feature
```

You can clean stale references with:

```bash
git fetch --prune
```

or:

```bash
git remote prune origin
```

`fetch --prune` is commonly preferred because it fetches and cleans stale remote-tracking references together.

---

# 42. What `git fetch --prune` Does

Conceptually:

```text
GitHub
   ↓
Fetch latest remote information
   ↓
Update remote-tracking refs
   ↓
Remove refs for remote branches
that no longer exist
```

It does not delete your local feature branches automatically.

For example:

```text
local feature/old-feature
```

can still exist even if:

```text
origin/feature/old-feature
```

is removed.

---

# 43. Practical Scenario: Someone Pushed Before You

Suppose you and Developer B both start from:

```text
A → B
```

You create:

```text
B → C
```

Developer B creates:

```text
B → D
```

Developer B pushes first:

```text
Remote:
A → B → D
```

You try:

```bash
git push
```

Git rejects your push.

You should:

```bash
git fetch origin
```

Then inspect:

```bash
git log --oneline --graph --all
```

Then integrate:

```bash
git rebase origin/main
```

or:

```bash
git merge origin/main
```

Resolve conflicts if necessary.

Then push.

---

# 44. Practical Scenario: New Developer Joins the Team

Give them repository access.

They run:

```bash
git clone <repository>
```

Then:

```bash
cd project
git branch -a
```

They see:

```text
main
remotes/origin/main
remotes/origin/develop
```

Create their feature branch:

```bash
git switch -c feature/profile
```

Work:

```bash
git add .
git commit -m "Add user profile"
```

Push:

```bash
git push -u origin feature/profile
```

Now the team can see the branch on GitHub.

---

# 45. Practical Scenario: Your Feature Branch Is Old

Suppose your feature branch was created two weeks ago.

Main has changed significantly:

```text
main:
A → B → C → D → E → F → G

feature:
A → B → X → Y
```

Before opening a PR, you may update it:

```bash
git fetch origin
git rebase origin/main
```

or:

```bash
git fetch origin
git merge origin/main
```

Then test everything again.

---

# 46. Practical Scenario: Pull Causes Conflict

You run:

```bash
git pull
```

and get:

```text
CONFLICT
```

Don't immediately run random commands.

First:

```bash
git status
```

Understand:

```text
What operation is happening?
Which files conflict?
```

Resolve the files.

If merge:

```bash
git add <files>
git commit
```

If rebase:

```bash
git add <files>
git rebase --continue
```

If you want to cancel:

```bash
git merge --abort
```

or:

```bash
git rebase --abort
```

---

# 47. Common Beginner Mistakes

## Mistake 1 — Thinking `origin/main` is GitHub itself

It isn't.

```text
origin
→ remote name

origin/main
→ local remote-tracking reference
```

---

## Mistake 2 — Thinking `git fetch` changes your code

Normally:

```text
git fetch
```

downloads remote information without integrating it into your current working branch.

---

## Mistake 3 — Thinking `git pull` is only download

It generally performs:

```text
fetch
+
merge/rebase
```

---

## Mistake 4 — Blindly running `git push --force`

This can rewrite remote history.

Prefer:

```bash
git push --force-with-lease
```

when force pushing is actually necessary.

---

## Mistake 5 — Ignoring push rejection

If Git says:

```text
non-fast-forward
```

don't immediately force push.

First:

```bash
git fetch
```

Then understand the divergence.

---

# 48. Interview Questions

## Q1. What is a remote repository?

A Git repository located elsewhere, typically on a server such as GitHub, that your local repository can synchronize with.

---

## Q2. What is `origin`?

The conventional name assigned to the default remote when a repository is cloned.

---

## Q3. Difference between `fetch` and `pull`?

```text
fetch
→ downloads remote changes
→ does not integrate them into your current branch

pull
→ fetches
→ integrates changes through merge/rebase
```

---

## Q4. What does `git push` do?

It transfers required Git objects to the remote and updates the specified remote branch/reference if the update is allowed.

---

## Q5. What is `origin/main`?

A local remote-tracking reference representing the last fetched state of the remote `main` branch on `origin`.

---

## Q6. What is an upstream branch?

The remote branch associated with a local branch for operations such as push and pull.

Example:

```text
main → origin/main
```

---

## Q7. Why can a push be rejected as non-fast-forward?

Because the remote branch contains commits that aren't ancestors of your local branch, so updating the remote directly would discard or bypass existing remote history.

---

## Q8. What is the difference between `git push` and `git fetch`?

```text
push
→ local → remote

fetch
→ remote → local repository's remote-tracking refs
```

---

## Q9. What happens during `git clone`?

Git creates a local repository, downloads the required repository data, configures the remote, creates remote-tracking references, and checks out the default branch.

---

## Q10. What is `git fetch --prune`?

It fetches updated remote information and removes stale remote-tracking references for branches that no longer exist on the remote.

---

## Q11. Why is `git push --force-with-lease` safer than `git push --force`?

Because it checks that the remote branch is still at the expected state before replacing its history, reducing the risk of overwriting someone else's newer work.

---

# 49. Hands-On Exercise

Create a GitHub repository for practice.

On your computer:

```bash
mkdir remote-practice
cd remote-practice
git init
```

Create:

```text
app.txt
```

Add:

```text
Remote Git Practice
```

Commit:

```bash
git add .
git commit -m "Initial commit"
```

Add your GitHub remote:

```bash
git remote add origin <your-repository-url>
```

Check:

```bash
git remote -v
```

Push:

```bash
git branch -M main
git push -u origin main
```

---

# 50. Practice `fetch`

Make a change directly through GitHub or from another clone.

Then locally:

```bash
git fetch origin
```

Check:

```bash
git branch -a
```

Then:

```bash
git log --oneline --all
```

Observe the remote-tracking branch.

---

# 51. Practice `pull`

Now run:

```bash
git pull
```

Check:

```bash
git status
```

Your local working branch should now contain the remote changes.

---

# 52. Practice a Feature Branch

Create:

```bash
git switch -c feature/test
```

Modify a file:

```text
app.txt
```

Commit:

```bash
git add .
git commit -m "Add test feature"
```

Push:

```bash
git push -u origin feature/test
```

Check GitHub.

You should now see:

```text
main
feature/test
```

---

# 53. Practice Non-Fast-Forward

Use two clones of the same repository.

Developer A:

```bash
git clone <repo> project-a
```

Developer B:

```bash
git clone <repo> project-b
```

Both start at:

```text
A → B
```

Developer A commits:

```text
A → B → C
```

and pushes.

Developer B independently creates:

```text
A → B → D
```

and tries:

```bash
git push
```

The push should be rejected.

Now practice:

```bash
git fetch origin
```

Inspect:

```bash
git log --oneline --graph --all
```

Then resolve the divergence using either:

```bash
git merge origin/main
```

or:

```bash
git rebase origin/main
```

---

# 54. The Complete Remote Git Mental Model

Remember this:

```text
                    GitHub
                      │
             Remote Repository
                      │
                fetch / pull
                      ↓
          Remote-Tracking References
             origin/main
             origin/feature
                      │
                      ↓
              Local Repository
                      │
               local branches
                      │
                      ↓
               Working Directory
```

And pushing:

```text
Working Directory
        ↓
      add
        ↓
     commit
        ↓
 Local Repository
        ↓
      push
        ↓
Remote Repository
```

---

# 55. The Most Important Commands

## Remote management

```bash
git remote -v
git remote add origin <url>
git remote remove origin
git remote set-url origin <url>
git remote show origin
```

## Clone

```bash
git clone <url>
```

## Fetch

```bash
git fetch
git fetch origin
git fetch --prune
```

## Pull

```bash
git pull
git pull --rebase
```

## Push

```bash
git push
git push origin main
git push -u origin feature/login
git push --force-with-lease
```

## Branch tracking

```bash
git branch -vv
git branch -a
```

---

# 56. 20/80 Summary

The most important mental model:

```text
LOCAL                              REMOTE

main ────────────────┐
                     │
                     │ push
                     ↓
                  origin/main
                     ↑
                     │
                     │ fetch
                     │
```

Remember:

```text
git clone
→ create local copy of a Git repository

git remote
→ manage remote connections

git fetch
→ download remote information without integrating it

git pull
→ fetch + integrate

git push
→ send local commits/objects to remote and update its refs

origin
→ conventional remote name

origin/main
→ local remote-tracking reference

-u / --set-upstream
→ establish local ↔ remote branch tracking

--force-with-lease
→ safer forced update after history rewriting
```

The most important interview answer:

> **`git fetch` updates your local knowledge of the remote repository without changing your current branch. `git pull` performs a fetch and then integrates those changes, typically through merge or rebase. `git push` transfers the required objects from your local repository and updates the remote reference when the update is allowed.**

The next file:

```text
07-undoing-changes-reset-revert-restore-stash.md
```

will cover one of the most important practical Git topics: **how to safely undo almost anything without destroying your work.**
