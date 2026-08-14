# 10 — Real-World Git Workflow and Interview Guide

> **Goal:** Connect everything you've learned into the workflow you will actually use as a developer.

---

# 1. Git in a Real Company

A typical development environment looks like:

```text
Developer
    ↓
Local Git Repository
    ↓
Feature Branch
    ↓
Commit
    ↓
Remote Repository
    ↓
Pull Request
    ↓
Code Review
    ↓
CI/CD
    ↓
Merge
    ↓
Deployment
```

Git is not just a command-line tool.

It is part of the entire software development workflow.

---

# 2. Typical Branch Structure

A simple company may use:

```text
main
 ├── feature/*
 ├── bugfix/*
 └── hotfix/*
```

More complex teams may use:

```text
main
develop
feature/*
release/*
hotfix/*
```

The exact strategy depends on the organization.

---

# 3. Feature Development

Suppose you are asked:

> Add JWT authentication.

Start:

```bash
git switch main
git pull --rebase origin main
```

Create:

```bash
git switch -c feature/jwt-authentication
```

Implement the feature.

Check:

```bash
git status
git diff
```

Stage:

```bash
git add .
```

Commit:

```bash
git commit -m "feat: add JWT authentication"
```

Push:

```bash
git push -u origin feature/jwt-authentication
```

Create a Pull Request.

---

# 4. Before Creating a Pull Request

Check:

```bash
git status
```

Check commits:

```bash
git log --oneline
```

Check differences from main:

```bash
git diff origin/main...HEAD
```

Run tests:

```bash
mvn test
```

or:

```bash
npm test
```

depending on the project.

---

# 5. Update Your Branch

Before merging:

```bash
git fetch origin
git rebase origin/main
```

If conflicts occur:

```bash
git status
```

Fix files.

Then:

```bash
git add .
git rebase --continue
```

After rebasing:

```bash
git push --force-with-lease
```

Use:

```bash
--force-with-lease
```

rather than blindly using:

```bash
--force
```

---

# 6. Why Force Push After Rebase?

Rebase creates new commit IDs.

Example:

Before:

```text
A---B---C
     \
      D---E
```

After rebase:

```text
A---B---C---D'---E'
```

Since D/E became D'/E', the remote branch history differs.

Therefore:

```bash
git push --force-with-lease
```

may be required.

---

# 7. Why `--force-with-lease`?

This is safer than:

```bash
git push --force
```

It checks whether the remote branch has changed unexpectedly.

Rule:

```text
Private feature branch
→ force-with-lease can be acceptable

Shared branch
→ avoid rewriting history
```

Never casually force-push:

```text
main
production
shared branches
```

---

# 8. Merge Strategy

There are several ways to merge a Pull Request.

### Merge Commit

```text
A---B---C
     \   \
      D---E---M
```

### Squash Merge

Multiple feature commits become one commit:

```text
A---B---C---F
```

### Rebase and Merge

Linear history:

```text
A---B---C---D---E
```

Teams usually standardize one approach.

---

# 9. Merge Conflict

Example:

Developer A:

```java
String name = "Yash";
```

Developer B:

```java
String name = "John";
```

Git cannot determine which change should win.

You may see:

```text
<<<<<<< HEAD
String name = "Yash";
=======
String name = "John";
>>>>>>> feature
```

You manually decide:

```java
String name = "Yashvardhan";
```

Then:

```bash
git add file.java
git commit
```

or during rebase:

```bash
git rebase --continue
```

---

# 10. Production Bug Workflow

Suppose production is broken.

You should not necessarily start from whatever feature you are currently developing.

Typical:

```bash
git switch main
git pull origin main

git switch -c hotfix/payment-crash
```

Fix:

```bash
git add .
git commit -m "fix: prevent payment crash"
git push -u origin hotfix/payment-crash
```

Then create a Pull Request.

---

# 11. Git Tags

Tags identify important points in history.

Example:

```bash
git tag v1.0.0
```

Push:

```bash
git push origin v1.0.0
```

View:

```bash
git tag
```

Useful for releases:

```text
v1.0.0
v1.1.0
v2.0.0
```

---

# 12. Semantic Versioning

Common format:

```text
MAJOR.MINOR.PATCH
```

Example:

```text
2.4.1
```

Meaning:

```text
2 = major
4 = minor
1 = patch
```

Typical interpretation:

```text
Major
breaking changes

Minor
backward-compatible features

Patch
backward-compatible bug fixes
```

---

# 13. Git and CI/CD

A professional repository may automatically run:

```text
git push
   ↓
CI
   ↓
Build
   ↓
Unit tests
   ↓
Integration tests
   ↓
Static analysis
   ↓
Security scan
   ↓
Deployment
```

For example:

```text
GitHub Actions
Jenkins
GitLab CI
Azure DevOps
```

The exact platform varies.

---

# 14. Pull Request + CI

A PR may display:

```text
✓ Build passed
✓ Unit tests passed
✓ Integration tests passed
✓ Checkstyle passed
✓ Security scan passed

2 reviewers approved
```

Only then can the PR be merged.

---

# 15. `.gitignore`

Never commit unnecessary/generated files.

Example:

```gitignore
target/
.idea/
*.iml
.env
node_modules/
.DS_Store
```

For Spring Boot:

```gitignore
target/
.idea/
*.iml
```

Do not commit:

```text
passwords
API keys
JWT secrets
database credentials
.env
private certificates
```

---

# 16. Secrets

Bad:

```properties
spring.datasource.password=myPassword123
```

Better:

```properties
spring.datasource.password=${DB_PASSWORD}
```

Store the actual secret in:

* environment variables
* secret managers
* CI/CD secrets

---

# 17. Accidentally Committed a Secret

If a password/API key is committed:

### Step 1

Immediately rotate/revoke the secret.

Do not assume deleting the file fixes the problem.

### Step 2

Remove it from current files.

### Step 3

If necessary, rewrite repository history using an appropriate history-rewriting tool.

Important:

> Removing a secret from the latest commit does not necessarily remove it from Git history.

---

# 18. Common Git Mistakes

## Mistake 1

Working directly on main.

Better:

```bash
git switch -c feature/my-feature
```

---

## Mistake 2

Huge commits.

Better:

```text
small logical commits
```

---

## Mistake 3

Using:

```bash
git add .
```

without checking changes.

Better:

```bash
git status
git diff
git add .
```

---

## Mistake 4

Force-pushing shared branches.

Avoid.

---

## Mistake 5

Committing secrets.

Never.

---

## Mistake 6

Using meaningless commits.

Bad:

```text
fix
update
changes
final
```

Better:

```text
fix: prevent duplicate order creation
```

---

# 19. Useful Daily Commands

```bash
git status
```

What changed?

```bash
git diff
```

What did I modify?

```bash
git add .
```

Stage changes.

```bash
git commit -m "message"
```

Create snapshot.

```bash
git pull --rebase
```

Update current branch.

```bash
git push
```

Send commits to remote.

```bash
git log --oneline --graph --decorate
```

Visualize history.

```bash
git branch
```

List branches.

```bash
git switch <branch>
```

Change branches.

```bash
git fetch
```

Download remote information.

---

# 20. Debugging Git History

When confused:

```bash
git status
```

Then:

```bash
git log --oneline --graph --decorate --all
```

Then:

```bash
git reflog
```

Then inspect:

```bash
git show <commit>
```

This sequence solves many Git problems.

---

# 21. Interview Scenario: "I Deleted a Commit"

Answer:

> First I would check `git reflog` to locate the previous commit reference. If the commit still exists, I can recover it by creating a branch from that commit or resetting the branch to it.

Example:

```bash
git reflog
git branch recovery <commit>
```

---

# 22. Interview Scenario: "I Committed to the Wrong Branch"

If the commit is local:

```bash
git switch correct-branch
git cherry-pick <commit>
```

Then remove it from the wrong branch if appropriate.

---

# 23. Interview Scenario: "How Do You Undo a Production Commit?"

Prefer:

```bash
git revert <commit>
```

because production history is shared.

Avoid casually doing:

```bash
git reset --hard
git push --force
```

---

# 24. Interview Scenario: "Git vs SVN"

Git:

```text
Distributed
Fast
Local history
Offline commits
Branching is lightweight
```

SVN:

```text
Centralized
Server-dependent workflow
```

---

# 25. Interview Scenario: "Why Is Git Fast?"

Important reasons include:

* much of the work happens locally
* objects are content-addressed
* snapshots are efficiently represented
* data is compressed
* Git transfers only required objects in many operations
* branches are lightweight references

---

# 26. Interview Scenario: "How Does Git Store History?"

Simplified:

```text
Commit
  ↓
Tree
  ↓
Blob
```

Commits point to parent commits:

```text
A ← B ← C ← D
```

Branches point to commits:

```text
main → D
```

HEAD points to the current branch/reference:

```text
HEAD → main → D
```

---

# 27. Interview Scenario: "What Happens During Commit?"

Simplified:

```text
Working Directory
       ↓
git add
       ↓
Index
       ↓
git commit
       ↓
Tree created
       ↓
Commit object created
       ↓
Branch reference moves
```

This is one of the most important Git internals questions.

---

# 28. Interview Scenario: "Merge vs Rebase"

### Merge

Preserves branch history.

```text
A---B---C
     \   \
      D---E---M
```

### Rebase

Replays commits on a new base.

```text
A---B---C---D'---E'
```

Rule:

```text
Shared history
→ prefer merge / avoid rewriting

Private branch
→ rebase can be useful
```

---

# 29. Interview Scenario: "Fetch vs Pull"

### Fetch

```bash
git fetch
```

Downloads remote changes.

Does not integrate them into your current branch.

### Pull

```bash
git pull
```

Fetches and integrates.

Conceptually:

```text
pull
 =
fetch + merge/rebase
```

---

# 30. Interview Scenario: "Reset vs Revert"

### Reset

Moves a branch reference.

```bash
git reset
```

Can rewrite local history.

### Revert

Creates an inverse commit.

```bash
git revert
```

Safer for shared history.

---

# 31. Interview Scenario: "What Is Staging?"

The staging area allows you to construct the next commit.

Suppose:

```text
fileA changed
fileB changed
fileC changed
```

You can stage only A:

```bash
git add fileA
```

Then commit:

```bash
git commit -m "Update user API"
```

Therefore:

```text
Working Directory
      ↓
     Index
      ↓
   Commit
```

---

# 32. Interview Scenario: "What Is HEAD?"

`HEAD` represents the current checkout position.

Usually:

```text
HEAD
 ↓
main
 ↓
commit
```

Detached:

```text
HEAD
 ↓
commit
```

---

# 33. Interview Scenario: "What Is a Branch?"

A branch is essentially a movable reference pointing to a commit.

```text
main
 ↓
C
```

After commit:

```text
main
 ↓
D
```

The pointer moved.

---

# 34. Git Mental Model

The most important model:

```text
                REMOTE
                  ↑
                push
                  │
WORKING → INDEX → COMMIT → BRANCH
   │         │       │        │
   │       add     commit    ref
   │
 modify
```

And internally:

```text
Branch
  ↓
Commit
  ↓
Tree
  ↓
Blob
```

---

# 35. The 20/80 Git Commands

If you remember only these:

```bash
git clone
git status
git add
git commit
git log
git diff
git branch
git switch
git fetch
git pull
git push
git merge
git rebase
git stash
git restore
git reset
git revert
git cherry-pick
git reflog
git tag
```

You can handle most real-world Git work.

---

# 36. The Professional Workflow to Memorize

```bash
# Start
git clone <repo>
cd <repo>

# Update
git switch main
git pull --rebase origin main

# Feature
git switch -c feature/my-feature

# Develop
git status
git diff

# Stage
git add .

# Commit
git commit -m "feat: implement my feature"

# Update before PR
git fetch origin
git rebase origin/main

# Push
git push -u origin feature/my-feature

# GitHub
# Create Pull Request
# Code Review
# CI
# Approval
# Merge

# Cleanup
git switch main
git pull origin main
git branch -d feature/my-feature
```

---

# 37. Final Git Mental Map

```text
                         GIT
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
    Working Tree       Staging           Repository
        │                 │                 │
      edit              add              commit
        │                 │                 │
        └─────────────────┼─────────────────┘
                          │
                       Branches
                          │
                       Remote
                          │
                       GitHub
                          │
                    Pull Request
                          │
                     Code Review
                          │
                         CI
                          │
                        Merge
                          │
                      Deployment
```

---

# 38. Final Interview Cheat Sheet

### Git

Distributed version control system.

### Repository

Directory containing project files and Git metadata.

### Commit

Snapshot of the project state.

### Branch

Movable reference to a commit.

### HEAD

Current checkout reference.

### Index

Staging area for the next commit.

### Blob

Stores file content.

### Tree

Stores directory structure.

### Commit

Points to a tree and parent commit(s).

### Remote

Another repository location.

### Fetch

Download remote information.

### Pull

Fetch + integrate.

### Push

Send local commits to remote.

### Merge

Combine histories.

### Rebase

Replay commits onto another base.

### Reset

Move branch/reference and optionally modify index/worktree.

### Restore

Restore file/index state.

### Revert

Create an inverse commit.

### Stash

Temporarily save uncommitted changes.

### Reflog

Record local reference movements.

### Cherry-pick

Apply a specific commit elsewhere.

### Tag

Permanent-ish name for an important commit.

### Pull Request

Platform-level mechanism for reviewing and merging changes.

---

# 39. The One Sentence to Remember

> **Git tracks snapshots locally, branches are references to commits, commits point to trees and blobs, and GitHub adds collaboration through remotes, Pull Requests, reviews, and CI/CD.**

If you understand that sentence deeply, most Git commands stop being memorization and become logical consequences of how Git works.
