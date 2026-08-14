# 01 — Git Fundamentals

> **Goal:** Understand what Git is, why it exists, the basic workflow, and the core concepts you must know before learning advanced Git.

---

## 1. What Is Git?

**Git is a distributed version control system (VCS).**

It is used to:

* Track changes in source code
* Maintain project history
* Work on multiple versions of a project
* Create branches
* Collaborate with other developers
* Recover previous versions
* Merge work from different developers

The important word is **distributed**.

Every developer normally has a complete local Git repository containing the project's history.

```text
                 Git Repository
                      │
        ┌─────────────┼─────────────┐
        ↓             ↓             ↓
    Developer A   Developer B   Developer C
       Local          Local          Local
       Git            Git            Git
```

You do not need a central server just to create commits.

---

# 2. Why Was Git Created?

Before version control systems, developers might manually create:

```text
project-final.zip
project-final2.zip
project-final-new.zip
project-final-final.zip
project-final-final2.zip
```

This becomes difficult to manage.

Git solves this by maintaining a structured history:

```text
Version 1
   ↓
Version 2
   ↓
Version 3
   ↓
Version 4
```

You can inspect, compare, or recover previous versions.

---

# 3. Version Control System

A VCS tracks changes to files over time.

For example:

```text
Day 1
main.java

Day 2
main.java changed

Day 3
main.java changed again
```

Git records these changes as **commits**.

```text
A → B → C
```

Each commit represents a snapshot of the project.

---

# 4. Git vs GitHub

These are different things.

## Git

Git is the version-control software.

You can use:

```bash
git init
git add
git commit
git branch
git merge
```

without GitHub.

## GitHub

GitHub is a platform for hosting Git repositories and collaborating with other developers.

```text
Git
 ↓
Local version control

GitHub
 ↓
Remote hosting + collaboration
```

Other platforms include GitLab and Bitbucket.

---

# 5. Installing Git

Check whether Git is installed:

```bash
git --version
```

Example:

```text
git version 2.x.x
```

Configure your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Check configuration:

```bash
git config --list
```

---

# 6. Git Configuration Levels

Git has three common configuration levels.

### System

Applies to the entire machine.

```bash
git config --system
```

### Global

Applies to your user account.

```bash
git config --global
```

### Local

Applies only to the current repository.

```bash
git config --local
```

Priority:

```text
Local
  ↓
Global
  ↓
System
```

More specific configuration overrides less specific configuration.

---

# 7. Creating a Repository

Suppose you have:

```text
my-project/
├── src/
├── README.md
└── pom.xml
```

Navigate into it:

```bash
cd my-project
```

Initialize Git:

```bash
git init
```

Git creates:

```text
.git/
```

Now:

```text
my-project/
├── .git/
├── src/
├── README.md
└── pom.xml
```

The `.git` directory contains Git's repository data.

---

# 8. What Is `.git`?

`.git` is the heart of the repository.

It stores information such as:

* commits
* branches
* references
* configuration
* staging/index information
* Git objects
* reflogs

Do not casually delete `.git`.

If you delete it, the directory is no longer a Git repository.

---

# 9. Working Directory

The files you actually edit are in the **working directory**.

Example:

```text
project/
├── src/
├── README.md
└── pom.xml
```

You modify:

```text
src/User.java
```

That modification exists initially only in the working directory.

---

# 10. The Three Main Areas of Git

This is one of the most important concepts.

Git can be understood using three areas:

```text
Working Directory
       ↓
     Staging Area
       ↓
    Repository
```

Or:

```text
Working Tree
     ↓ git add
Index / Staging Area
     ↓ git commit
Git Repository
```

---

# 11. Working Directory

This is where you write code.

Example:

```text
User.java
```

You modify it:

```java
String name = "Yash";
```

Git detects that the file has changed.

Check:

```bash
git status
```

---

# 12. Staging Area

The staging area lets you decide:

> "Which changes should be included in my next commit?"

Suppose you changed:

```text
User.java
Order.java
Payment.java
```

You only want to commit `User.java`.

Run:

```bash
git add User.java
```

Now:

```text
Working Directory
       ↓
   User.java
       ↓
Staging Area
```

The other files remain unstaged.

---

# 13. Repository

After staging:

```bash
git commit -m "Add user model"
```

Git creates a commit.

The flow becomes:

```text
Working Directory
       ↓
    git add
       ↓
Staging Area
       ↓
   git commit
       ↓
 Repository
```

Memorize this.

---

# 14. `git status`

One of the most important commands:

```bash
git status
```

It tells you things such as:

* current branch
* modified files
* staged files
* untracked files
* branch relationship with remote

Use it constantly.

---

# 15. Untracked Files

Suppose you create:

```text
User.java
```

Git may show:

```text
Untracked files:
    User.java
```

Git knows the file exists but is not tracking it yet.

Add it:

```bash
git add User.java
```

Now it becomes staged.

---

# 16. Modified Files

Suppose Git already tracks:

```text
User.java
```

You modify it.

Git may show:

```text
Changes not staged for commit:
    modified: User.java
```

Stage it:

```bash
git add User.java
```

---

# 17. Staged Files

After:

```bash
git add User.java
```

Git shows:

```text
Changes to be committed:
    modified: User.java
```

Now the change is staged.

Commit it:

```bash
git commit -m "Update user model"
```

---

# 18. `git add`

Stage a specific file:

```bash
git add User.java
```

Stage multiple files:

```bash
git add User.java Order.java
```

Stage a directory:

```bash
git add src/
```

Stage everything:

```bash
git add .
```

### Important

`git add` does **not** mean:

> Save permanently.

It means:

> Put the current version of these changes into the staging area for the next commit.

---

# 19. `git commit`

Create a commit:

```bash
git commit -m "Add user authentication"
```

A commit is a permanent-ish snapshot in the repository history.

Example:

```text
A
↓
B
↓
C
```

Each letter represents a commit.

---

# 20. Commit Message

Bad:

```bash
git commit -m "changes"
```

Bad:

```bash
git commit -m "update"
```

Better:

```bash
git commit -m "Add JWT authentication"
```

Even better for teams:

```bash
git commit -m "feat: add JWT authentication"
```

A good commit message explains **what changed**.

---

# 21. `git log`

View commit history:

```bash
git log
```

A shorter version:

```bash
git log --oneline
```

Example:

```text
8f31a2d Add JWT authentication
4b72c91 Add user entity
9ac812e Initialize project
```

Visualize branches:

```bash
git log --oneline --graph --decorate --all
```

---

# 22. `git diff`

See unstaged changes:

```bash
git diff
```

See staged changes:

```bash
git diff --staged
```

This distinction is important.

```text
git diff
    ↓
Working Directory vs Staging Area

git diff --staged
    ↓
Staging Area vs Last Commit
```

---

# 23. Basic Git Workflow

The most common workflow is:

```text
1. Modify files
       ↓
2. git status
       ↓
3. git diff
       ↓
4. git add
       ↓
5. git diff --staged
       ↓
6. git commit
       ↓
7. git log
```

Example:

```bash
git status

git diff

git add .

git diff --staged

git commit -m "feat: add user registration"

git log --oneline
```

---

# 24. What Is a Commit Really?

A commit is not simply:

> "A changed file."

Conceptually, a commit contains information about a snapshot:

```text
Commit
├── tree
├── parent
├── author
├── committer
└── message
```

The tree represents the project structure at that point.

This becomes important when learning Git internals.

---

# 25. Git Stores Objects

Git's internal object model primarily contains:

```text
Blob
Tree
Commit
Tag
```

### Blob

Stores file content.

### Tree

Represents directory structure.

### Commit

Points to a tree and parent commit(s).

### Tag

Can identify an important object, commonly a release commit.

Think:

```text
Commit
   ↓
 Tree
   ↓
Blob
```

---

# 26. What Is a Branch?

A branch allows you to develop independently.

Suppose:

```text
main
 |
 A---B---C
```

Create:

```text
feature/login
```

Now:

```text
main
 |
 A---B---C

feature/login
 |
 A---B---C
```

Make commits:

```text
main
 |
 A---B---C

feature/login
          \
           D---E
```

Your feature work does not immediately affect `main`.

---

# 27. Creating a Branch

Modern command:

```bash
git switch -c feature/login
```

Older command:

```bash
git checkout -b feature/login
```

List branches:

```bash
git branch
```

Switch branch:

```bash
git switch main
```

---

# 28. What Is HEAD?

`HEAD` represents your current checkout position.

Normally:

```text
HEAD
 ↓
main
 ↓
C
```

When you switch:

```bash
git switch feature/login
```

you get:

```text
HEAD
 ↓
feature/login
 ↓
E
```

This becomes extremely important when learning reset, rebase, detached HEAD, and reflog.

---

# 29. Local Repository vs Remote Repository

Your local repository:

```text
Your Computer
     ↓
.git
```

A remote repository:

```text
GitHub
   ↓
Remote Repository
```

You can connect them:

```bash
git remote add origin <repository-url>
```

Check:

```bash
git remote -v
```

---

# 30. Push

Send local commits to a remote:

```bash
git push origin main
```

Conceptually:

```text
Local Repository
      ↓
    push
      ↓
GitHub Repository
```

---

# 31. Pull

Get remote changes and integrate them:

```bash
git pull
```

Conceptually:

```text
Remote Repository
      ↓
    fetch
      ↓
    integrate
```

A simplified mental model is:

```text
git pull
=
git fetch
+
git merge
```

Depending on configuration, pull can integrate using rebase instead.

---

# 32. Fetch

Download information from the remote without changing your current working branch:

```bash
git fetch
```

This is safer for inspecting remote changes.

You can then decide whether to:

```bash
git merge
```

or:

```bash
git rebase
```

---

# 33. Clone

If a repository already exists remotely:

```bash
git clone <repository-url>
```

Git downloads the repository and creates a local working copy.

Typical flow:

```text
GitHub Repository
       ↓
   git clone
       ↓
Local Repository
```

---

# 34. `.gitignore`

`.gitignore` tells Git which files/directories should normally not be tracked.

Example:

```gitignore
target/
.idea/
*.iml
node_modules/
.env
```

Common things to ignore:

* build output
* IDE files
* dependency directories
* temporary files
* local environment files

---

# 35. Git Does Not Automatically Track Everything

Creating a file does not automatically mean Git will commit it.

Example:

```text
Create file
   ↓
Untracked
   ↓
git add
   ↓
Staged
   ↓
git commit
   ↓
Tracked in repository history
```

---

# 36. Git Snapshot Mental Model

Do not think of Git only as:

> "Git stores differences."

A better mental model is:

> **Git records snapshots of project states and connects them through history.**

Example:

```text
Commit A
  ↓
Project state at A

Commit B
  ↓
Project state at B

Commit C
  ↓
Project state at C
```

Git can efficiently store/reuse data internally, but the conceptual model is snapshots.

---

# 37. Git's Distributed Nature

Suppose GitHub disappears temporarily.

You can still do many operations locally:

```bash
git log
git branch
git diff
git commit
git merge
git rebase
```

because your repository contains its own history.

You mainly need the network for operations involving the remote.

---

# 38. First Practical Exercise

Create a practice repository:

```bash
mkdir git-practice
cd git-practice
git init
```

Create a file:

```bash
echo "# Git Practice" > README.md
```

Check:

```bash
git status
```

Stage:

```bash
git add README.md
```

Check:

```bash
git status
```

Commit:

```bash
git commit -m "docs: add README"
```

Check history:

```bash
git log --oneline
```

---

# 39. Modify the File

Change:

```text
README.md
```

Then:

```bash
git status
```

See the change:

```bash
git diff
```

Stage:

```bash
git add README.md
```

Inspect staged changes:

```bash
git diff --staged
```

Commit:

```bash
git commit -m "docs: update README"
```

View:

```bash
git log --oneline
```

You should now have:

```text
A---B
```

---

# 40. The Most Important Commands

Memorize these first:

```bash
git init
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
```

Do not try to memorize 100 Git commands initially.

Master these first.

---

# 41. Command → Purpose

| Command      | Purpose                     |
| ------------ | --------------------------- |
| `git init`   | Create a repository         |
| `git clone`  | Copy a remote repository    |
| `git status` | Show current state          |
| `git add`    | Stage changes               |
| `git commit` | Create a snapshot           |
| `git log`    | View history                |
| `git diff`   | Inspect changes             |
| `git branch` | Manage branches             |
| `git switch` | Change/create branches      |
| `git fetch`  | Download remote information |
| `git pull`   | Fetch + integrate           |
| `git push`   | Upload commits              |

---

# 42. The Most Important Mental Model

If you remember only one thing from this file:

```text
             GIT WORKFLOW

        Working Directory
                │
              edit
                ↓
        git add
                │
                ↓
         Staging Area
                │
             commit
                ↓
        Git Repository
                │
             push
                ↓
       Remote Repository
```

And for history:

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

# 43. Interview Questions

### What is Git?

Git is a distributed version control system used to track changes and manage project history.

### What is a repository?

A repository contains project files together with Git's version-control data.

### What is staging?

Staging is selecting the changes that will be included in the next commit.

### What does `git add` do?

It updates the staging area with the selected version of files.

### What does `git commit` do?

It creates a new commit representing the staged project state.

### What is a branch?

A branch is essentially a movable reference pointing to a commit.

### What is HEAD?

HEAD identifies the current checkout position.

### What is GitHub?

GitHub is a platform for hosting Git repositories and enabling collaboration.

### What is the difference between Git and GitHub?

Git is the version-control system; GitHub is a hosting and collaboration platform.

### What is the difference between fetch and pull?

`fetch` downloads remote information without integrating it into your current branch. `pull` fetches and then integrates the changes.

---

# 44. 20/80 Summary

For Git fundamentals, master these concepts:

```text
1. Git
2. Repository
3. Working Directory
4. Staging Area
5. Commit
6. Branch
7. HEAD
8. Remote
9. GitHub
10. Fetch
11. Pull
12. Push
13. Clone
14. Diff
15. Git history
16. .git directory
17. .gitignore
18. Blob
19. Tree
20. Commit object
```

Once these are clear, the next topics—**commits & Git internals, branching, merge/rebase, remote workflow, undo/recovery, and team workflow**—become much easier.
