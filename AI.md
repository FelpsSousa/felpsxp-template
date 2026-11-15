# AI in this repository's process

I use AI assistance deliberately, as part of a professional workflow, not as a shortcut
around understanding the code. This file says exactly where and how, so there is nothing
to guess. It is the only place this is disclosed: commits and pull requests carry no
attribution footer.

## Tooling

Claude Code, running against this repository's own `CLAUDE.md` for context. No other
AI-generated code enters this repository without going through the same review below.

## Where it assists

- Drafting and tightening prose: ADRs, module documentation, commit and PR descriptions.
- Proposing implementation approaches and catching obvious mistakes before they ship.
- Preparing commits and pull requests for my review.
- Explaining unfamiliar parts of the codebase back to me, so I keep full ownership of it.

## Where it never decides

- Architecture and design decisions: recorded as ADRs that only I accept.
- What reaches `main`: nothing merges without my own review, understanding and acceptance
  of it.

## What enforces this

Pre-commit hooks, CI checks and the branch protection on `main` apply the same way
regardless of who or what proposed a change. Nothing here gets a pass for being
AI-assisted, and nothing needs one: the standard is the code and the decision, not
the origin.
