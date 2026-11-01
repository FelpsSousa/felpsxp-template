# Security Policy

Security is a first-class requirement across the FelpsXP ecosystem.
Thank you for helping keep **{{PROJECT_NAME}}** and its users safe.

## Supported versions

| Version | Supported |
| ------- | --------- |
| `main` (latest release) | ✅ |
| older releases | ❌ |

## Reporting a vulnerability

**Do not open a public issue, discussion or pull request for security problems.**

Report privately through GitHub:
**Security → Advisories → Report a vulnerability**
(`https://github.com/{{OWNER}}/{{PROJECT_NAME}}/security/advisories/new`).

Please include:

- a description of the issue and its impact;
- steps to reproduce or a proof of concept;
- affected version, commit or URL;
- any suggested fix or mitigation.

## What to expect

This project is maintained by one person, so timelines are realistic rather than corporate:

| Step | Target |
| ---- | ------ |
| Acknowledgement | within 7 days |
| Initial assessment | within 14 days |
| Fix or mitigation for confirmed high/critical issues | as soon as possible, usually within 30 days |

You will be kept informed, and credited in the advisory unless you prefer otherwise.

## Scope

In scope: code in this repository and the services it deploys under `*.felpsxp.com`.

Out of scope: denial-of-service and volumetric attacks, social engineering, physical attacks,
findings that require a compromised device, and vulnerabilities in third-party services
(report those to the vendor).

## Safe harbor

Good-faith research that respects this policy will not be pursued legally. That means no data
destruction, no privacy violations, no service disruption, and only the minimum access needed
to demonstrate the issue. Personal data you may encounter must not be kept or shared (LGPD).

## Practices in this repository

- Secrets live only in environment variables or a secret manager; `.env` is git-ignored and
  `.env.example` documents the variables without values.
- `gitleaks` runs in pre-commit and in CI over the full history.
- Dependabot keeps dependencies and GitHub Actions current; actions are pinned to commit SHAs.
- Workflows run with least-privilege `GITHUB_TOKEN` permissions.
- Code scanning (CodeQL) and secret scanning with push protection are enabled in repository settings.
