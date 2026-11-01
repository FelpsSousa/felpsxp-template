# Contributing

Thanks for your interest in **{{PROJECT_NAME}}**, part of the FelpsXP ecosystem.
This guide describes how work flows from idea to `main`.

> Português: o fluxo abaixo vale para todos os repositórios FelpsXP. Documentação
> pública fica em inglês; planejamento e conversa podem ser em português.

## Principles

1. **Architecture before code.** A change that alters structure, data model, a public
   contract or a dependency choice starts with an ADR in [`docs/adr/`](docs/adr/README.md).
2. **One thing at a time.** Small, focused PRs. One concern per PR.
3. **Write with care.** Follow the writing style in [CLAUDE.md](CLAUDE.md#writing-style):
   no em or en dashes, no filler, correct grammar in English and Portuguese.
4. **Security first.** No secrets in the repo, least privilege everywhere, personal data
   handled according to LGPD.

## Workflow

1. **Open or pick an issue** using the templates. Larger work references its ADR.
2. **Create a branch** from `main`:

   ```text
   <type>/<short-kebab-description>
   feat/news-rss-ingestion
   fix/login-cookie-domain
   docs/adr-0002-database
   ```

3. **Install the hooks once**; they run formatting, secret scanning and commit-message checks:

   ```bash
   pre-commit install
   ```

4. **Commit** following [Conventional Commits](https://www.conventionalcommits.org):

   ```text
   <type>(<optional scope>): <description in imperative, lowercase>

   [optional body: what and why, not how]

   [optional footer: BREAKING CHANGE: ..., Refs: #12]
   ```

   | Type       | Use for |
   | ---------- | ------- |
   | `feat`     | a new feature |
   | `fix`      | a bug fix |
   | `docs`     | documentation only (including ADRs) |
   | `refactor` | code change that neither fixes a bug nor adds a feature |
   | `perf`     | performance improvement |
   | `style`    | formatting only, no logic change |
   | `test`     | adding or fixing tests |
   | `build`    | build system or dependencies |
   | `ci`       | CI configuration |
   | `chore`    | maintenance that touches no production code |
   | `revert`   | reverting a previous commit |
   | `security` | security hardening or vulnerability fix |

   A breaking change adds `!` after the type (`feat(api)!: ...`) and a
   `BREAKING CHANGE:` footer.

5. **Open a pull request.** The PR **title** must also be a Conventional Commit, because
   PRs are **squash-merged** and the title becomes the commit on `main`. Fill in the template.
6. **CI must be green** before merging; CODEOWNERS are requested for review automatically.
7. **Delete the branch** after merge.

## Architecture Decision Records

- Copy [`docs/adr/template.md`](docs/adr/template.md) to `docs/adr/NNNN-title-in-kebab-case.md`
  with the next number.
- Open it as `Proposed`, discuss in the PR, merge as `Accepted`.
- Never rewrite an accepted ADR: supersede it with a new one and update the old status.
- Decisions that affect the whole ecosystem belong in `felpsxp-architecture`; link them here.

## Code standards

- Follow `.editorconfig` (UTF-8, LF, 2 spaces; 4 for Python).
- Tests accompany behaviour changes. Bug fixes come with a regression test.
- Configuration goes through environment variables; document every new one in `.env.example`.
- Keep dependencies few and justified; Dependabot keeps them current.

## Reporting security issues

Never in public issues. Follow [SECURITY.md](SECURITY.md).
