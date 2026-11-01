# {{PROJECT_NAME}}

> {{PROJECT_DESCRIPTION}}

**English** · [Português (BR)](README.pt-BR.md)

[![CI](https://github.com/{{OWNER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{OWNER}}/{{PROJECT_NAME}}/actions/workflows/ci.yml)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196.svg)](https://www.conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Part of the **FelpsXP digital ecosystem** · Registry ID: `{{FXP_ID}}`

---

## Overview

<!-- What problem this project solves, for whom, and how it fits into the FelpsXP ecosystem
     (which CORE services it uses: auth, database, event bus, design system). -->

## Architecture

<!-- High-level diagram (C4 level 1/2) and the main components.
     Every significant decision lives in docs/adr/; link the relevant ADRs here. -->

| Layer    | Choice |
| -------- | ------ |
| Frontend | <!-- e.g. Next.js + Tailwind CSS --> |
| Backend  | <!-- e.g. FastAPI / NestJS --> |
| Data     | <!-- e.g. Supabase (PostgreSQL + pg_partman) --> |
| Hosting  | <!-- e.g. Vercel / self-hosted Docker --> |

See [Architecture Decision Records](docs/adr/README.md).

## Getting started

### Prerequisites

- Git, and [pre-commit](https://pre-commit.com) (`pipx install pre-commit`)
- <!-- Node.js + pnpm and/or Python + uv, with versions -->

### Setup

```bash
git clone https://github.com/{{OWNER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
pre-commit install          # installs pre-commit and commit-msg hooks
cp .env.example .env        # never commit .env
# <install dependencies>
```

### Common commands

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
├── scripts/          # helper scripts
├── CLAUDE.md         # persistent context for Claude Code
└── ...
```

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). Commits and PR titles follow
[Conventional Commits](https://www.conventionalcommits.org).

## Security

Please do **not** open public issues for vulnerabilities. See [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
