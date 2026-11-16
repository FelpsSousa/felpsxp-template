# Changelog

Versions of `felpsxp-template` itself. Projects created from it do not inherit this file: the
init script removes it.

## Unreleased

- The root README now describes the template itself, in both languages, and the project READMEs
  move to `skeleton/`, installed by the init script; `TEMPLATE.md` is folded into the READMEs.
- Project README skeleton with "What this is", "Highlights", "Stack" and "Documentation" sections,
  after the shape that worked in felpsxp-hub.
- The `mixed-line-ending` hook skips `.ps1`, `.cmd` and `.bat`, which `.gitattributes` checks out
  with CRLF (it failed on felpsxp-control's first PowerShell scripts).
- AI disclosure: `AI.md`, a `CLAUDE.md` section, `.claude/settings.json`, and checks that keep
  attribution footers out of commits and pull requests (#3).
- CI audits dependencies in the Node and Python jobs; the writing-style hook also catches dashes
  written as HTML entities (#4).
- CI runs one job per project root instead of only looking at the repository root (#5).
- `init-template.sh` takes `--license mit|proprietary|none` and reports honestly the settings it
  could not apply (#6).
- Skeletons for runbooks, postmortems and public showcase material, and a baseline of web security
  headers.

## 0.1.0 (2026-11-01)

First release: bilingual README, CLAUDE, CONTRIBUTING, SECURITY, ADR-0001, CI with pre-commit and
gitleaks, Dependabot, Actions pinned by SHA, and the init script.
