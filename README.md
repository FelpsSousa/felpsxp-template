# felpsxp-template

> The repository template behind every FelpsXP project: bilingual docs, Conventional Commits,
> pre-commit hygiene, secret scanning, CI, Dependabot, ADRs, an AI disclosure, and one script
> that turns a fresh copy into a working project.

**English** · [Português (BR)](README.pt-BR.md)

[![CI](https://github.com/FelpsSousa/felpsxp-template/actions/workflows/ci.yml/badge.svg)](https://github.com/FelpsSousa/felpsxp-template/actions/workflows/ci.yml)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196.svg)](https://www.conventionalcommits.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Part of the **FelpsXP digital ecosystem** · Registry ID: `FXP-027`

---

## Why a template

Every FelpsXP repository starts from the same baseline, so a rule is written once and applies
everywhere: how commits are named, which hooks run, what CI checks, how decisions are recorded,
how AI assistance is disclosed. A new project is ready for its first pull request a few minutes
after `gh repo create`, and a reader who knows one repository knows them all.

Projects born from it include [felpsxp-hub](https://github.com/FelpsSousa/felpsxp-hub) (public)
and the private felpsxp-logs, felpsxp-sentinel and felpsxp-control.

## What a new project gets

| File | For what |
| ---- | -------- |
| `skeleton/README.md`, `skeleton/README.pt-BR.md` | the project's bilingual README, installed and filled in by the init script |
| `LICENSE` | MIT by default; `--license proprietary` or `--license none` for closed projects |
| `CONTRIBUTING.md` | issue, branch, Conventional Commits, squash-merged pull request |
| `SECURITY.md` | private reporting through GitHub Advisories, with realistic deadlines for a solo maintainer |
| `CLAUDE.md` | persistent context for Claude Code: principles, writing style, default stack, conventions |
| `AI.md` | the single AI disclosure; the project adjusts it so every sentence is true |
| `.claude/settings.json` | turns off Claude Code's attribution footer in commits and pull requests |
| `docs/adr/` | ADR-0001 (why we record decisions), the MADR template and the index |
| `docs/runbooks/`, `docs/postmortems/` | procedures and incidents, with a postmortem template |
| `docs/showcase/` | the checklist of what may, and what may never, go public |
| `docs/security/web-headers.md` | baseline security headers for a web app |
| `.github/workflows/ci.yml` | pre-commit and gitleaks over the whole history; Node and Python jobs, with dependency audits, when the stack exists |
| `.github/workflows/pr-title.yml` | pull request titles in Conventional Commits |
| `.github/dependabot.yml` | Actions weekly; the npm, pip and Docker blocks are enabled by the script |
| `.github/CODEOWNERS`, issue and PR templates | automatic review requests and forms |
| `.pre-commit-config.yaml` | hygiene, gitleaks, private keys, commit message format, and a block on dashes in Markdown |
| `.editorconfig`, `.gitattributes`, `.gitignore`, `.env.example`, `.nvmrc` | editor defaults, LF endings, secrets out of git, the Node version CI uses |

Actions are pinned by commit SHA, with the tag in a comment; Dependabot keeps them current.

## Create a project

```bash
gh repo create FelpsSousa/<name> --template FelpsSousa/felpsxp-template --public --clone
cd <name>
./scripts/init-template.sh --name <name> --description "<one line, in English>" --fxp FXP-0xx --github
```

`init-template.sh`, in this order:

1. fills in the project name, description, registry ID and owner in every file;
2. moves the README skeletons into place, replacing this file and its Portuguese version;
3. enables the Dependabot blocks for the stacks it finds (`package.json`, `pyproject.toml`, `Dockerfile`);
4. applies the license (`--license mit`, the default, `proprietary` or `none`);
5. removes what belongs to the template only: the changelog, the template ADRs, the proposal form and itself;
6. creates the commit `chore: initialize from felpsxp-template`;
7. with `--github`: pushes that commit, creates the labels, sets squash-only merges with branch auto-delete, enables secret scanning and private vulnerability reporting on public repositories, and protects `main` with a ruleset (pull requests only, linear history, required checks);
8. installs the pre-commit hooks.

Protection comes after the push on purpose: the ruleset would reject a direct push. The other
options are `--owner` (default `FelpsSousa`; `felpsxp-hq` once the organization exists) and
`--license`.

## After the script

1. **Settings, Code security:** enable CodeQL default setup and Dependabot security updates.
2. Fill in `README.md`, `README.pt-BR.md` and `CLAUDE.md` (overview, stack, commands).
3. Write ADR-0002 with the project's first real decision, and make `AI.md` true for it.
4. From then on, work on branches and open pull requests; `main` only changes through them.

## What the script cannot apply

- On a **private repository on the Free plan**, GitHub does not accept the ruleset: `main` stays
  unprotected, the script says so, and `AI.md` must not claim branch protection until it exists.
  Secret scanning needs GitHub Advanced Security there; gitleaks covers it in pre-commit and CI.
- If the stack (`package.json`, `pyproject.toml`, `Dockerfile`) arrives later, enable the matching
  Dependabot block by hand (uncomment between `# npm-start` and `# npm-end`).

## Why `main` does not require approvals

A solo maintainer cannot approve their own pull request. The ruleset requires a pull request,
linear history and the `Hygiene & secrets` and `Conventional Commits title` checks. When more
people join, turn on `required_approving_review_count: 1` and `require_code_owner_review`.

## Keeping projects in sync

A change in a convention lands here first and then reaches the repositories as pull requests.
[Template ADR-0002](docs/template-adr/0002-template-synchronization.md) decides how: a version
stamp in each project, a manifest of managed, seeded and block-synced files, and a sync script
that opens the pull request (in progress). Until then, releases are tags with a
[changelog](CHANGELOG.md), and `pre-commit autoupdate` runs now and then.

## Repository layout

```text
.
├── .github/              # CI, Dependabot, CODEOWNERS, issue and PR templates
├── docs/adr/             # ADR-0001, the MADR template and the index (kept by projects)
├── docs/template-adr/    # decisions about the template itself (removed by the script)
├── docs/                 # runbooks, postmortems, showcase and security baselines
├── scripts/init-template.sh
├── skeleton/             # README.md and README.pt-BR.md of a new project
├── CLAUDE.md, AI.md, CONTRIBUTING.md, SECURITY.md
└── CHANGELOG.md          # versions of the template (removed by the script)
```

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md). A practice proven in a project comes back here through
the "Template proposal" issue form.

## Security

Please do **not** open public issues for vulnerabilities. See [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
