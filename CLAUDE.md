# CLAUDE.md

Persistent context for Claude Code in **{{PROJECT_NAME}}**. Read this before any change.
Keep it short and current: update it in the same PR whenever setup, commands or conventions change.

## Project

- **What:** {{PROJECT_DESCRIPTION}}
- **Registry ID:** `{{FXP_ID}}` in the FelpsXP master registry (Registro Mestre).
  Claude Code cannot update the registry; when status, scope or stack changes, say so at the
  end of the session so Felps can sync it.
- **Owner:** Felipe "Felps" Sousa (@FelpsSousa) · repository owner `{{OWNER}}` (the `felpsxp-hq` org is reserved for later).
- **Ecosystem:** one module of the FelpsXP digital ecosystem. Modules are independent and
  pluggable, integrating with the shared CORE (auth/IAM, database, API gateway, design system,
  event bus) instead of reimplementing it.

## How we work

- **Architecture before code.** Anything costly to reverse (architecture, data model, public
  contract, framework or major dependency, security model) needs an ADR in `docs/adr/` first;
  see ADR-0001. Propose it, wait for agreement, then implement.
- **One thing at a time.** Small, focused changes; finish one step before starting the next.
- **Planning happens in Claude chat; execution happens here.** If a task needs an
  architectural decision that is not recorded, stop and ask instead of choosing silently.
- **Security first.** Never commit secrets; every new env var goes in `.env.example` with no
  value. Validate input at boundaries, apply least privilege, and treat personal data
  according to LGPD.
- **Language:** code, comments, commits, ADRs and public docs in English. Felps talks in
  Brazilian Portuguese; reply in Portuguese in chat.

## Writing style

Applies to everything written in this repository and in replies to Felps, in English and in
Portuguese.

- Never use em dashes or en dashes. Use a comma, a colon, a semicolon, parentheses or a new
  sentence instead. A pre-commit hook blocks them in Markdown and text files.
- No AI-sounding prose: no stock openings, empty catchphrases, "it's not X, it's Y" constructions
  or lists of clichés. Say the specific thing.
- Write with care in both languages: rich vocabulary, correct punctuation (commas, semicolons,
  colons, quotation marks) and sound grammar. Prefer fluent, descriptive prose to fragments.

## Conventions

- **Commits and PR titles:** Conventional Commits
  (`feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert|security`). PRs are squash-merged.
- **Branches:** `<type>/<short-kebab-description>` from `main`. Never commit to `main` directly.
- **Hooks:** `pre-commit install` once; `pre-commit run --all-files` before pushing.
- **Subdomains:** each module is served at `<module>.felpsxp.com`; SSO relies on a cookie
  scoped to the root domain, so never invent another namespace without an ADR.
- **Default stack** (deviations need an ADR):
  - Frontend: Next.js + TypeScript + Tailwind CSS; Recharts for charts; Expo for mobile.
  - Backend: FastAPI (Python) or NestJS (TypeScript).
  - Data: PostgreSQL via Supabase (persistence + Realtime); time-series with native
    partitioning + `pg_partman` (TimescaleDB is **not** used); Redis for cache.
  - Messaging between modules: RabbitMQ.
  - Infra: Cloudflare DNS, Vercel for web, Docker on the self-hosted server,
    Grafana + Prometheus for observability, Resend for transactional e-mail.

## Commands

<!-- Fill in when the stack exists. Keep this table accurate. -->

| Task | Command |
| ---- | ------- |
| Install | <!-- pnpm install / uv sync --> |
| Dev server | <!-- pnpm dev / uv run fastapi dev --> |
| Lint | <!-- pnpm lint / uv run ruff check . --> |
| Test | <!-- pnpm test / uv run pytest --> |
| All checks | `pre-commit run --all-files` |

## Map

- `docs/adr/`: decisions (source of truth for *why*)
- `.github/`: CI, Dependabot, templates, CODEOWNERS
- <!-- add main source folders here -->

## Do not

- Do not add dependencies, services or infrastructure without saying why (and an ADR if major).
- Do not edit accepted ADRs; supersede them.
- Do not disable hooks, CI checks or security settings to make something pass.
- Do not publish real network topology, credentials or personal data in code, tests or docs.
