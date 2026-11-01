# ADR-0001: Record architecture decisions

- **Status:** Accepted
- **Date:** 2026-10-18
- **Deciders:** Felipe Sousa (@FelpsSousa)
- **Scope:** every repository created from `felpsxp-template`

## Context

The FelpsXP ecosystem is a set of independent, pluggable projects that share a common
CORE (auth, database, gateway, design system, event bus). It is built by one person,
across many sessions, with AI assistance (Claude chat for architecture, Claude Code for
execution).

Two problems follow from that:

1. **Lost reasoning.** Months later, nobody (including the author or an AI assistant
   reading the repo cold) remembers *why* a choice was made, so it gets revisited and
   reworked. Avoiding rework is a core value of the ecosystem.
2. **Public evidence.** Repositories double as a portfolio. Recruiters and collaborators
   should see how decisions were reached, not only the resulting code.

## Decision

Every repository records its significant decisions as **Architecture Decision Records**
in `docs/adr/`.

- **What needs an ADR:** anything that is costly to reverse or that shapes other work:
  architecture, data model and storage, public APIs and contracts, framework or major
  dependency choices, security and privacy model, hosting and deployment, cross-module
  integration with CORE.
- **Format:** a lightweight MADR-style template ([`template.md`](template.md)): context,
  decision drivers, options considered, decision, consequences.
- **Files:** `docs/adr/NNNN-title-in-kebab-case.md`, numbered sequentially per repository,
  starting at `0001`. Numbers are never reused.
- **Lifecycle:** `Proposed` → `Accepted` (or `Rejected`) → optionally `Deprecated` or
  `Superseded by ADR-NNNN`. Accepted ADRs are immutable; a change of mind is a new ADR that
  supersedes the old one, and only the old one's status line is edited.
- **Review:** an ADR is merged through a pull request like code, so the discussion is kept.
- **Language:** English, because repositories are public portfolio material.
- **Ecosystem-wide decisions** (those that bind more than one project, such as the
  `<module>.felpsxp.com` subdomain convention for SSO) live in `felpsxp-architecture`.
  Project ADRs link to them instead of duplicating them.
- **Index:** [`README.md`](README.md) in this folder lists every ADR with its status.

## Consequences

**Positive**

- Decisions and their trade-offs survive context switches, months away and new sessions.
- AI assistants get reliable context: `CLAUDE.md` points to this folder as the source of truth.
- The repository shows engineering judgement to anyone evaluating it.

**Negative**

- Writing an ADR adds a small upfront cost before code.
- The index must be kept in sync by hand (checked during PR review).

**Neutral**

- Small, easily reversible choices stay out of ADRs; they belong in code comments or PR
  descriptions.

## References

- Michael Nygard, *Documenting Architecture Decisions* (2011)
- [MADR: Markdown Architectural Decision Records](https://adr.github.io/madr/)
