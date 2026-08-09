# Git — Theory & Setup

## 1. What is Git?

Git is a **distributed version control system (VCS)** used to track changes in source code and collaborate with other developers.

Git allows you to:

* Track changes
* Restore previous versions
* Work on different features using branches
* Collaborate with other developers
* Maintain a history of the project

---

## 2. What is Version Control?

Version control is a system that records changes made to files over time.

### Without Git

```text
project_final
project_final_new
project_final_latest
project_final_latest_2
```

### With Git

```text
Commit 1 → Commit 2 → Commit 3 → Commit 4
```

You can move back to an earlier version when required.

---

## 3. Git vs GitHub

| Git                   | GitHub                             |
| --------------------- | ---------------------------------- |
| Software/tool         | Online platform                    |
| Runs on your computer | Runs on the internet               |
| Tracks changes        | Hosts Git repositories             |
| Works offline         | Mainly used for collaboration      |
| `git commit`          | Pull Requests, Issues, Code Review |

**Simple idea:**

```text
Git = Version Control Tool
GitHub = Online Git Repository Platform
```

---

# 4. Git Mental Model

The most important concept to understand:

```text
Working Directory
       ↓
     git add
       ↓
Staging Area
       ↓
   git commit
       ↓
Local Repository
       ↓
   git push
       ↓
Remote Repository
       ↓
     GitHub
```

---

# 5. Important Git Concepts

## Repository

A repository is a project that Git is tracking.

It contains:

* Project files
* Git history
* Commits
* Branch information
* Configuration

A Git repository contains a hidden `.git` directory.

---

## Working Directory

The actual files you are currently working on.

Example:

```text
project/
├── src/
├── README.md
└── pom.xml
```

Changes made to these files are initially in the **working directory**.

---

## Staging Area

The staging area contains changes that you want to include in the next commit.

```bash
git add filename
```

or:

```bash
git add .
```

---

## Commit

A commit is a saved snapshot of your staged changes.

```bash
git commit -m "Add login feature"
```

A commit should describe **what changed**.

Good:

```bash
git commit -m "Add user authentication"
```

Bad:

```bash
git commit -m "changes"
```

---

## Branch

A branch is an independent line of development.

Example:

```text
main
 │
 ├── feature-login
 │
 └── feature-payment
```

Create a branch:

```bash
git branch feature-login
```

Create and switch:

```bash
git switch -c feature-login
```

---

## Remote Repository

A remote repository is a Git repository stored somewhere outside your local machine.

Example:

```text
Local Repository → GitHub Repository
```

---

## origin

`origin` is the default name commonly given to the remote repository.

Check it:

```bash
git remote -v
```

Example:

```text
origin  https://github.com/username/project.git
```

---

## HEAD

`HEAD` represents the commit/branch you are currently working from.

Usually:

```text
HEAD → main → latest commit
```

---

# 6. Installing Git

## Windows

Download and install Git from the official Git website.

After installation, open **Command Prompt / PowerShell / Git Bash**.

Check installation:

```bash
git --version
```

Example:

```text
git version 2.x.x
```

If the version appears, Git is installed successfully.

---

# 7. First-Time Git Configuration

Set your username:

```bash
git config --global user.name "Your Name"
```

Set your email:

```bash
git config --global user.email "your@email.com"
```

Check configuration:

```bash
git config --global --list
```

Check individual values:

```bash
git config user.name
git config user.email
```

---

# 8. Create Your First Git Repository

Create a project folder:

```bash
mkdir my-project
```

Move into it:

```bash
cd my-project
```

Initialize Git:

```bash
git init
```

Git will create:

```text
.git/
```

Now the folder is a Git repository.

---

# 9. Check Repository Status

Use:

```bash
git status
```

This is one of the most important Git commands.

It tells you:

* Current branch
* Modified files
* Untracked files
* Staged files
* Uncommitted changes

---

# 10. Create Your First Commit

Create a file:

```bash
echo "# My Project" > README.md
```

Check status:

```bash
git status
```

Add the file to staging:

```bash
git add README.md
```

Check status again:

```bash
git status
```

Commit:

```bash
git commit -m "Add README"
```

Check history:

```bash
git log
```

---

# 11. The Basic Git Workflow

This workflow is extremely important:

```text
1. Modify files
       ↓
2. git status
       ↓
3. git add
       ↓
4. git status
       ↓
5. git commit
       ↓
6. git push
```

Typical commands:

```bash
git status
git add .
git commit -m "Describe changes"
git push
```

---

# 12. Connecting Git to GitHub

Create a repository on GitHub.

Then connect your local repository:

```bash
git remote add origin https://github.com/USERNAME/REPOSITORY.git
```

Check:

```bash
git remote -v
```

---

# 13. Push Local Repository to GitHub

Rename the current branch to `main`:

```bash
git branch -M main
```

Push:

```bash
git push -u origin main
```

After the first push, you can usually use:

```bash
git push
```

---

# 14. Clone an Existing Repository

If a project already exists on GitHub:

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

Move into the project:

```bash
cd REPOSITORY
```

Check:

```bash
git status
```

---

# 15. Pull Changes

Download and integrate changes from the remote repository:

```bash
git pull
```

Typical workflow:

```text
GitHub
   ↓
git pull
   ↓
Local Repository
   ↓
Modify files
   ↓
git add
   ↓
git commit
   ↓
git push
   ↓
GitHub
```

---

# 16. Branch Commands

See branches:

```bash
git branch
```

Create branch:

```bash
git branch feature-login
```

Switch branch:

```bash
git switch feature-login
```

Create + switch:

```bash
git switch -c feature-login
```

Switch back:

```bash
git switch main
```

Delete local branch:

```bash
git branch -d feature-login
```

---

# 17. Merge Branch

Suppose you have:

```text
main
feature-login
```

First switch to main:

```bash
git switch main
```

Merge the feature:

```bash
git merge feature-login
```

Then push:

```bash
git push
```

---

# 18. View Commit History

Basic:

```bash
git log
```

Compact:

```bash
git log --oneline
```

Graph:

```bash
git log --oneline --graph --all
```

---

# 19. See Changes

See unstaged changes:

```bash
git diff
```

See staged changes:

```bash
git diff --staged
```

---

# 20. Unstage a File

If you accidentally run:

```bash
git add file.txt
```

You can remove it from staging:

```bash
git restore --staged file.txt
```

The file itself is not deleted.

---

# 21. Discard Local Changes

To discard changes to a file:

```bash
git restore file.txt
```

**Be careful:** this removes your uncommitted changes to that file.

---

# 22. Git .gitignore

`.gitignore` tells Git which files/folders should not be tracked.

Example:

```gitignore
target/
.idea/
*.class
.env
node_modules/
```

For Java/Spring Boot projects, commonly:

```gitignore
target/
.idea/
*.iml
.env
```

Never commit secrets such as:

```text
passwords
API keys
database credentials
.env files
private keys
```

---

# 23. Useful Remote Commands

Show remotes:

```bash
git remote -v
```

Add remote:

```bash
git remote add origin URL
```

Change remote:

```bash
git remote set-url origin URL
```

Remove remote:

```bash
git remote remove origin
```

---

# 24. Useful Git Commands — Quick Reference

| Command                     | Purpose              |
| --------------------------- | -------------------- |
| `git init`                  | Create repository    |
| `git clone URL`             | Download repository  |
| `git status`                | Check current state  |
| `git add .`                 | Stage changes        |
| `git commit -m "message"`   | Create commit        |
| `git log`                   | View history         |
| `git diff`                  | View changes         |
| `git branch`                | List branches        |
| `git switch branch`         | Switch branch        |
| `git switch -c branch`      | Create + switch      |
| `git merge branch`          | Merge branch         |
| `git remote -v`             | View remotes         |
| `git pull`                  | Get remote changes   |
| `git push`                  | Upload commits       |
| `git restore file`          | Discard file changes |
| `git restore --staged file` | Unstage file         |

---

# 25. Complete First-Time Setup

The complete process looks like this:

```bash
# 1. Configure Git
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# 2. Create project
mkdir my-project
cd my-project

# 3. Initialize Git
git init

# 4. Create a file
echo "# My Project" > README.md

# 5. Check status
git status

# 6. Stage
git add .

# 7. Commit
git commit -m "Initial commit"

# 8. Rename branch
git branch -M main

# 9. Connect GitHub repository
git remote add origin https://github.com/USERNAME/my-project.git

# 10. Push
git push -u origin main
```

---

# 26. The 80/20 Git Mental Model

Remember this:

```text
                    Git
                     │
          ┌──────────┴──────────┐
          ↓                     ↓
    Local Repository        Remote Repository
          │                     │
          │                   GitHub
          │                     ↑
          ↓                     │
   Working Directory            │
          ↓                     │
      git add                   │
          ↓                     │
      Staging Area              │
          ↓                     │
     git commit                 │
          ↓                     │
   Local Repository             │
          │                     │
          └──── git push ───────┘
```

The commands you should know first are:

```bash
git init
git clone
git status
git add
git commit
git log
git branch
git switch
git merge
git pull
git push
git remote
git restore
```

**Master these before learning advanced Git.**
