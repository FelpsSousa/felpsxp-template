# {{PROJECT_NAME}}

> {{PROJECT_DESCRIPTION}}

**English** · [Português (BR)](README.pt-BR.md)

[![CI](https://github.com/{{OWNER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{OWNER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196.svg)](https://www.conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Part of the **FelpsXP digital ecosystem** · Registry ID: `{{FXP_ID}}`

---

## What this is

<!-- Three to five sentences: the problem, who it is for, what exists today and what does not.
     Say the status plainly (prototype, in daily use, live) and how the project fits the
     ecosystem (which CORE services it uses: auth, database, event bus, design system). -->

## Highlights

<!-- The three to six things a reader should know, grouped. Link each one to the ADR, test or
     document that proves it. Remove a group that does not apply. -->

**Architecture**

- <!-- A decision and why, with a link to its ADR -->

**Security**

- <!-- A control that exists and is tested, not a plan -->

**Quality**

- <!-- Tests, accessibility, performance: what runs on every pull request -->

## Stack

| Area     | Choice |
| -------- | ------ |
| Frontend | <!-- e.g. Next.js + Tailwind CSS --> |
| Backend  | <!-- e.g. FastAPI / NestJS --> |
| Data     | <!-- e.g. PostgreSQL via Supabase --> |
| Hosting  | <!-- e.g. Vercel / Docker on the home server --> |

Deviations from the ecosystem defaults are recorded in the
[Architecture Decision Records](docs/adr/README.md).

## Getting started

### Prerequisites

- Git, and [pre-commit](https://pre-commit.com) (`pipx install pre-commit`)
- <!-- Node.js + pnpm and/or Python + uv, with versions -->

### Setup

```bash
git clone https://github.com/{{OWNER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
pre-commit install          # installs the pre-commit and commit-msg hooks
cp .env.example .env        # fill it in locally; never commit it
# <install dependencies>
```

### Commands

| Command | What it does |
| ------- | ------------ |
| <!-- `pnpm dev` --> | <!-- start the dev server --> |
| <!-- `pnpm test` --> | <!-- run the test suite --> |
| `pre-commit run --all-files` | run every hygiene and secret check |

## Project structure

```text
.
├── .github/          # CI, Dependabot, CODEOWNERS, issue and PR templates
├── docs/adr/         # Architecture Decision Records
├── docs/runbooks/    # operational procedures
├── CLAUDE.md         # persistent context for Claude Code
└── ...
```

## Documentation

- [Architecture Decision Records](docs/adr/README.md): every decision that is costly to reverse.
- [Runbooks](docs/runbooks/README.md) and [postmortems](docs/postmortems/README.md).
- [AI.md](AI.md): where AI assistance is used in this repository, and where it never decides.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Commits and PR titles follow
[Conventional Commits](https://www.conventionalcommits.org); `main` only changes through
squash-merged pull requests.

## Security

Please do **not** open public issues for vulnerabilities. See [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
