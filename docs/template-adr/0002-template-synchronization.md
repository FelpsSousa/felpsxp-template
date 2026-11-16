# ADR-0002: Synchronize the template and its repositories in both directions

- **Status:** Proposed
- **Date:** 2026-11-09
- **Deciders:** Felipe Sousa (@FelpsSousa)
- **Related:** [ADR-0001](../adr/0001-record-architecture-decisions.md)

This record lives in `docs/template-adr/`, which the init script removes, because it decides how
the template itself works. The number continues from ADR-0001 so it reads as the template's own
second decision, without colliding with the first real ADR of each project.

## Context

The template keeps improving, and so do the projects. Nothing connects the two. A project created
from the template loses the link at birth: `gh repo create --template` squashes the history and
drops the tags, and the init script deletes itself. Older repositories never had the link.

The cost is already visible. The AI disclosure policy was applied by hand to seven places. Practices
that started in a project, such as the dependency audit, reached the template only because an
audit happened to compare them.

Repositories also differ in ways a mechanism has to respect. In some, Claude Code opens the pull
requests; in others, such as `felpsxp-architecture` and `beecrowd-problem-solving`, the owner types
every git command. Node monorepos keep husky and commitlint, while the others use pre-commit: the
rule is shared, the tool is not.

## Decision drivers

- A change in the template must reach a repository as a pull request that can be reviewed.
- No new secret with access to private repositories.
- No new dependency in the daily workflow.
- A file that belongs to a project must never be overwritten.
- It must work where the owner runs every git command.

## Options considered

### Option A: Copier

- ✅ Real three-way merge with `copier update`, and a mature tool
- ❌ Rewrites every placeholder in Jinja and replaces the init script that already works
- ❌ Adds Python tooling to the flow of repositories that do not use Python

### Option B: actions-template-sync

- ✅ Opens the pull requests by itself, on a schedule
- ❌ Needs a token with access to the private repositories, stored as a secret in each one
- ❌ Has no answer for repositories where the owner types every command

### Option C: a manifest and a script kept in the template

- ✅ No new dependency and no secret, in the same bash and `gh` as the init script
- ✅ Can stop at a patch where the owner runs git
- ❌ Merges are simple replacements, so the manifest has to be right
- ❌ One more script to maintain

## Decision

We will use Option C, in five parts.

1. **Version stamp.** The template ships `.felpsxp/template.json` with its source and version,
   because a generated project cannot read the template's tags. The init script adds the adoption
   date. Existing repositories get the file when they adopt the template.
2. **Manifest.** `.felpsxp/manifest.yml`, in the template, sorts files into three classes:
   - *managed*: replaced on every sync (`pr-title.yml`, issue and PR templates, `.editorconfig`);
   - *seeded*: created once and owned by the project from then on (README, `AI.md`, `.env.example`);
   - *blocks*: only the text between `felpsxp:begin NAME` and `felpsxp:end NAME` markers is replaced.

   A project can list exclusions in its own stamp, which is how a Node monorepo opts out of the
   pre-commit file.
3. **Downstream.** `scripts/sync-from-template.sh <repository path>` runs from a checkout of the
   template, so it needs no copy in the projects. It compares the stamp with the latest tag, applies
   the manifest on a branch named `chore/sync-template-vX.Y.Z`, and opens a pull request quoting the
   changelog for that range. `--dry-run` only shows the diff, and `--patch` writes a patch and runs no
   git command, for repositories where the owner types them.
4. **Upstream.** A "Template proposal" issue form in this repository, so that a practice proven in a
   project has somewhere to land. Each project's `CLAUDE.md` asks that candidates be pointed out at
   the end of a session.
5. **Versions.** Semantic tags and `CHANGELOG.md`. The sync reads both.

## Consequences

**Positive**

- A rule changes once and arrives everywhere as a reviewable pull request.
- The difference between a repository and the template becomes something a command can show.

**Negative**

- Replacing a managed file discards local edits, so a project that needs to differ must say so in
  its exclusions.
- If a project drifts too far from the manifest, the sync produces a noisy first pull request.
- Copier remains the better tool at a larger scale. Reconsider it past about ten repositories.

**Follow-ups**

- [ ] `.felpsxp/manifest.yml`, the stamp in the template and in the init script
- [ ] `scripts/sync-from-template.sh`, tested on throwaway repositories
- [ ] Markers around the shared sections of `CLAUDE.md` and `CONTRIBUTING.md`
- [ ] Adopt in beecrowd, architecture, sentinel, finance, platform and hub, one at a time
