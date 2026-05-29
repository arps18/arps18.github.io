---
title: "Git Mastery: Intermediate and Professional Workflows"
date: 2026-05-23T00:00:00+00:00
draft: false
tags: ["git", "version-control", "devtools", "workflow", "engineering"]
categories: ["engineering"]
summary: "Notes on Git internals, history cleanup, branching strategies, and recovery techniques I rely on past the basics."
ShowToc: true
TocOpen: false
---

You push a feature branch on Friday, and Monday morning the history looks like someone shuffled a deck of cards into it.

That's when Git stops being a `git commit` + `git push` reflex and turns into something you actually sit with. A few months in, the commands aren't what trip you up. The hard part is reading why the history landed the way it did, and knowing what to reach for when it tips sideways. Here's what I've picked up.

---

## 1. Understanding Git Internals

Each commit holds a pointer to the full file tree at that moment and a pointer to its parent, chaining all the way back to the repo's first commit. Diffs get computed on demand when you ask for them. `HEAD` points to wherever you currently are, and your working copy is derived from it. A branch label is a pointer to a commit SHA, so moving the label doesn't touch any underlying objects.

`reflog` is the one you're probably underusing. Every time `HEAD` moves (commit, reset, checkout, rebase), Git writes an entry. Your stomach drops when a force-push wipes a ref you actually wanted, and `reflog` is why that isn't a disaster. It's local and never pushes anywhere, so the recovery window only exists on the machine that did the damage.

Say you've committed D to `feature` when you meant `main`. `cherry-pick` replays the diff introduced by a specific commit onto wherever `HEAD` points now.

```text
          D (HEAD -> feature)
         /
A - B - C (main)
```

```bash
git checkout main
git cherry-pick D
git branch -d feature
```

D lands on `main` as a brand new commit with a brand new SHA, while the original D on `feature` becomes unreachable and eventually gets garbage-collected. Commits don't move; they get replayed as new objects with new identities…

Once that clicks, rebase, revert, and squash all stop looking like separate features and start looking like variations on the same replay primitive.

---

## 2. Cleaning Up History

### 2.1 Interactive Rebase

Five commits in and the feature still isn't done. You've got "Fix login typo", "Remove debug prints", "Refactor login", a pile of breadcrumbs from actually working through the problem. Reviewers don't need any of it.

```bash
git rebase -i HEAD~5
```

An editor opens:

```
pick abc123 Add login function
pick def456 Fix login typo
pick ghi789 Add error handling
pick jkl012 Refactor login
pick mno345 Remove debug prints
```

Change `pick` to `squash` and the commit folds into the one above it. Change it to `drop` and the commit disappears. Squash into the wrong base and you're reaching for reflog to get out.

After a squash, five commits collapse to one:

```text
Before Rebase:
A - B - C - D - E
```

```text
After Rebase (squashed):
A - B - X
```

X combines D and E into one commit. What lands in the PR is:

```
Add login feature with error handling
```

### 2.2 Commit Amend

You committed `login.py` and then noticed `auth.py` sitting there unstaged. Amend the first commit instead of stacking a second one:

```bash
git add forgotten_file.py
git commit --amend
```

The previous commit gets rewritten to include the new changes. Fine locally. Once the branch is pushed, amending rewrites history, so a force push becomes necessary and your teammates' local branches now point to a commit that no longer exists on the remote.

### 2.3 Reflog

You run `git reset --hard HEAD~3` and three commits vanish from `git log`.

Most engineers read that as deletion. It isn't. `reset --hard` only moves `HEAD`, and Git keeps the orphaned commits reachable through reflog until garbage collection runs (default 30 days for unreachable objects, 90 for reflog entries), which means every position `HEAD` has ever held is recoverable by SHA.

```bash
git reflog
```

Output:

```
abc123 HEAD@{0}: reset: moving to HEAD~3
def456 HEAD@{1}: commit: added feature
ghi789 HEAD@{2}: commit: initial commit
```

`def456` is right there. Grab it.

```bash
git reset --hard def456
```

Commits are back.

---

## 3. Branching and Collaboration

### 3.1 Feature Branch Workflow

Two engineers committing to `main` at the same time is how you get a repo that neither of them recognizes by end of day. Branching isolates a unit of work behind its own ref so it can evolve without disturbing anything else on the trunk.

```bash
git checkout -b feature/login
# develop the login feature
git commit -m "Add login"
git push origin feature/login
```

When it's ready, you fold it back in:

```bash
git checkout main
git merge feature/login
```

The picture looks something like this:

```text
main
|
|---- feature/login
|---- feature/payment
```

`feature/payment` never has to wait on `feature/login`. Each branch carries its own commit history from the point it diverged, so a commit on one branch doesn't appear on the other until a merge actually integrates them. Reviewers benefit from the same property, because a PR against `main` covers one concern instead of a pile of unrelated changes arriving together.

### 3.2 Rebase vs Merge

You cut a branch off `main`, work on it for two days, and by the time you're ready to merge, three other commits have landed on `main`. Now you've got to integrate those changes somehow.

Two options, and they produce very different histories.

**Merge** keeps the timeline honest. It records exactly when things happened and drops in a merge commit to stitch the two branches together.

```text
Merge:
A - B - C (main)
     \
      D - E (feature)
           \
            M (merge commit)
```

**Rebase** replays your commits as if you'd started from the tip of `main` all along. Linear and clean, though those commits are new objects now; `D'` and `E'` aren't the same as `D` and `E`. Same diff, different SHAs, different parents. That's the part people miss until it bites them.

```text
Rebase:
A - B - C - D' - E' (main)
```

That rewrite is what makes rebase dangerous on shared branches. If a teammate based their work on your `D` and you rebase, their `D` becomes an orphan commit and their history diverges from yours in a way that's painful to untangle later.

So the rule I follow: never rebase a public shared branch. Use rebase on your own private branch before you merge it back, and use merge for everything that other people are pulling from. No exceptions.

```bash
git checkout feature/login
git rebase main
```

---

## 4. Recovery and Debugging

### 4.1 Git Bisect

I had a regression sitting somewhere in 500 commits between the last green release and `HEAD`, and no theory about which one did it. `git bisect` runs a binary search through that history. You mark where `good` ends and `bad` begins, Git checks out the middle commit, you run the repro and tell it which side of the split that commit sits on, then it halves the window again. 500 commits collapses into about 9 steps.

Here's where people quietly wreck their own bisect sessions. If you mark a commit `good` or `bad` without actually running the repro, bisect will happily converge on an innocent SHA, and you won't notice anything was off until you've already shipped a bogus fix. The log is only as trustworthy as the verdicts you feed it, so run the real test every step. Bisect lands you on a single SHA, the one that introduced the regression. The commit itself.

Start it like this…

```bash
git bisect start
git bisect bad
git bisect good abc123
```

Run the repro. Mark it. Repeat.

### 4.2 Git Blame

Blame's job is reconstructing why a line exists. When the test suite tells you something is broken, `blame` tells you who decided it should look the way it does.

```bash
git blame auth.py
```

Every line comes back annotated with who touched it last and which commit it came from. The word "last" in that output does a good amount of work, because if someone reformatted the file six months ago, `blame` will point at them and skip right past the person who actually wrote the logic. Treat blame output as a lead. The commit it points at might just be the formatter, with the actual decision-maker buried two reformats deep.

Spot a weird conditional and run `blame` to get the commit hash. Then `git show <hash>` gives you the full diff and message around why that decision landed.

### 4.3 Recover Deleted Branch

```bash
git reflog
# find commit hash
git checkout -b recovered <commit_hash>
```

Deleting a branch only removes its pointer; the underlying commit objects stay in the store. Garbage collection won't touch them for weeks by default, so your recovery window is wide open.

`reflog` tracks every position HEAD has occupied locally. Find the hash from just before the deletion and check it out as a fresh branch. Most "destructive" Git operations aren't actually destructive.

The branch is back.

---

## 5. Stash and Worktrees

### 5.1 Git Stash

Halfway through a login feature. Auth flow wired up, session logic half-done, then production throws an alert and you need `main` right now. Can't commit half-baked code, can't leave it either.

```bash
git stash save "WIP login feature"
git switch main
# fix hotfix
git commit -m "Hotfix"
git switch feature/login
git stash pop
```

`git stash` parks your working tree on a temporary shelf. The tree goes clean, you jump to `main`, patch the fire, come back, and `stash pop` drops the WIP right where you left it. I got this wrong the first time and stashed without a message, then burned ten minutes guessing which stash held the auth work.

Stashes stay local. They don't travel with the repo, so don't treat them as backup.

### 5.2 Git Worktrees

The stash-and-switch loop falls apart once you're juggling a half-finished refactor and somebody pings you to check a deploy config on `main`. Shelving messy work just to peek at another branch wastes minutes you don't have.

`git worktree` checks out multiple working trees from the same repo at once. The feature branch sits in one folder, the hotfix sits in another, and a change in one folder is invisible from the other because the working copies are fully independent.

```bash
git worktree add ../hotfix main
```

This isn't a branch switch under the hood. The object store (commits, blobs, refs) is shared across every worktree, while the checked-out files live in separate directories with separate `HEAD` pointers. One `cd` away from `main`, zero stashing, no context loss when an interrupt lands mid-refactor.

### 5.3 Sparse Checkout

Two files in `frontend/` need a tweak, but Git pulls the whole monorepo, indexes every directory, and floods `git status` with churn from services you've never opened.

```bash
git sparse-checkout init
git sparse-checkout set frontend/
```

Only `frontend/` lands on disk. Everything else stays in the object store, invisible to your working tree, so clones go faster and status output narrows down to code you actually touch. Pair this with worktrees once your monorepo crosses a few gigabytes, and the day you'd normally spend wrestling Git turns into a day you spend writing code.

---

## 6. Cherry-Pick

You'd been heads-down on `feature/login` for a week when someone shipped a critical auth fix to `main`. Two lines. Waiting for the eventual merge wasn't an option; you wanted those two lines on your branch immediately.

`cherry-pick` does exactly that.

```bash
git checkout feature/login
git cherry-pick <commit_hash>
```

It doesn't pull in the branch; it just replays the diff from that one commit onto wherever `HEAD` points, so you get the fix and nothing else. The commit hash on your branch ends up different, though the change itself is identical.

Let's dig deeper into the failure mode… if that commit touched a file you've also modified, you'll hit a conflict. Resolution works like a merge conflict, except it tends to catch you off guard because you weren't expecting friction from a single-commit operation.

Keep your commits small and focused. `cherry-pick` replays one commit at a time, so a tightly-scoped commit transplants cleanly while a sprawling one drags unrelated changes along with the fix.

---

## 7. Hooks and Automation

Git fires hooks at well-defined lifecycle points; the two that matter most for guardrails are `pre-commit` and `pre-push`. The scripts sit in `.git/hooks/` as plain shell, executable bit and all, so you can write them in whatever you'd write a shell script in.

`pre-commit` runs before Git writes the commit object. `pre-push` is its counterpart on the outbound side, gating whatever's about to leave your machine. If either exits non-zero Git aborts, no commit object gets written and no ref gets updated, so the exit code is the entire contract you're working against.

One gotcha worth internalizing before you ship a hook to your team. `pre-commit` sees the staged index, which can diverge from your working tree if you've staged half a file and left the rest dirty. Your tests run green against the staged version, you commit, you push, and the code you actually have on disk is something else entirely… the workaround is to stash unstaged changes inside the hook itself, run your checks against a clean index, and pop the stash on the way out. It's ugly but it's the only honest way to test what you're really committing.

Hooks aren't tracked by Git, which means a fresh clone has none of them. Check yours into `scripts/hooks/` and have your setup script symlink them into `.git/hooks/` so every contributor inherits the same guardrails on day one. Then drop something like this into `.git/hooks/pre-commit`:

```bash
#!/bin/sh
npm test || exit 1
```

---

## 8. Force Push Safely

I finished a clean rebase, history finally reading top to bottom like a real story, and then `git push` came back with the diverged-branch error. My first instinct was `--force`, ship it, move on. That instinct is how teammates lose a morning of work.

Plain `--force` doesn't consult the remote at all. It steamrolls whatever's sitting there, so if a teammate pushed a commit after your last fetch, their work is gone with no warning, silently overwritten while you sip your coffee. You won't even know until someone pings you the next morning asking where their changes went.

Sit with that for a second, because it isn't hypothetical. Teams have lost hours this way, and the person who force-pushed usually has no idea it happened. The push succeeds, everything looks fine on their end, and the damage only surfaces when someone else notices their commit missing from the remote.

`--force-with-lease` checks whether the remote ref still matches what you last saw locally, so if a teammate snuck a push in while you were rebasing, your push fails loudly at the protocol level. That's exactly what you want when you're rewriting shared history. You still get the rewrite, you just don't bulldoze anyone on the way there.

Do note: plain `--force` skips that safety check entirely.

```bash
git push --force-with-lease
```

Use it by default.

---

## 9. Diff and Log Magic

`--word-diff` operates at the token level instead of the line level, so a one-character rename stops drowning in red and green noise. You see `[-old-]` replaced by `{+new+}` inline, and once you've seen a variable rename or a condition tweak land this way, line-level diffs lose the precision they used to have.

```bash
git diff --word-diff           # shows changes at the word level
git diff main..feature         # compare branches
git log --graph --oneline --decorate --all  # visualize commit graph
```

`git diff main..feature` isn't symmetric. Flip the order and you'll get a different diff, and it's a silent one to get wrong.

Stack `--graph --oneline --decorate --all` and the branch topology finally shows up on screen. No more guessing branch shape from PR titles or scrolling through linear logs that hide merges. One readable picture. The next time someone asks how a feature actually landed on main, the answer's already on your terminal before they finish the question.

---

## 10. Daily Professional Workflow

Every morning, before touching a single file, run `git fetch origin` to sync your local view of what the remote actually looks like. Then `git rebase origin/main` on whatever feature branch you're on. Do this religiously.

After that, just work. Commit often and commit messily if you need to, because you'll squash it later anyway. The point is to not lose context while you're in the flow.

Before you open the PR, rebase interactively and clean up the history. Squash the `wip` commits, reword anything embarrassing, and make the diff tell a coherent story. Reviewers read history too.

Push with `--force-with-lease`; reserve plain `--force` for situations where you've verified no one else has touched the branch. Never `--force` on a shared branch itself. Plain `--force` will silently overwrite a teammate's commit if they pushed after your last fetch, whereas `--force-with-lease` refuses the push and aborts with a stale-ref error.

Open the PR, wait for review, merge, and clean up. Same loop tomorrow.

---

## Closing Notes

`reset --hard` on the wrong branch is how Git actually clicks for most people. You read the docs, nod along, and then one day every command you half-remembered becomes very real, very urgent.

The commands here aren't a checklist to memorize. `git bisect` won't come up every week, but when a subtle bug is hiding somewhere in the last eighty commits, you'll be glad you know it. Worktrees sound niche until you're mid-refactor and a critical fix lands in your lap.

Write commit messages like you're explaining them to yourself six months from now. `Fix null pointer in auth middleware when session token is missing` saves a full context reload, while `Fix bug` saves nothing. Spend the extra fifteen seconds.

Rebase before every PR, because a clean linear history keeps `git log` readable and makes reviewing faster, and while you're at it, stop treating your local branch history as sacred. Use `rebase -i` to squash the typo commits, reorder the logical chunks, and drop the dead ends before it becomes someone else's problem to review. By the way, the first time I taught myself this workflow I rebased a shared branch and force-pushed over a teammate's commit at 11pm. I got this wrong in the loudest possible way, and that's when `--force-with-lease` became muscle memory.

`git reflog` is your undo history. Git almost never deletes anything immediately, so before you start recreating work from scratch, check reflog first. It surfaces every `HEAD` move Git has recorded, including the ones that felt unrecoverable:

```bash
git reflog
git reset --hard HEAD@{4}
```
