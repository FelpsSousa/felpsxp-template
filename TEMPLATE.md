# felpsxp-template

Repositório-modelo de todos os projetos FelpsXP. Este arquivo explica como usar o modelo e
**é apagado** pelo `scripts/init-template.sh` quando um projeto novo nasce.

## O que vem pronto

| Arquivo | Para quê |
| ------- | -------- |
| `README.md` / `README.pt-BR.md` | README bilíngue com placeholders |
| `LICENSE` | MIT (troque se o projeto for fechado — veja abaixo) |
| `CONTRIBUTING.md` | fluxo issue → branch → Conventional Commits → PR squash |
| `SECURITY.md` | reporte privado via GitHub Advisories, prazos realistas para quem toca sozinho |
| `CLAUDE.md` | contexto persistente do Claude Code: princípios, stack padrão, convenções |
| `docs/adr/` | ADR-0001 (por que usamos ADRs), template MADR e índice |
| `.github/workflows/ci.yml` | pre-commit + gitleaks no histórico inteiro; jobs Node/Python só se o stack existir |
| `.github/workflows/pr-title.yml` | valida título de PR em Conventional Commits |
| `.github/dependabot.yml` | Actions semanal; blocos npm/pip/docker ligados pelo script |
| `.github/CODEOWNERS`, issue/PR templates | revisão automática e formulários |
| `.pre-commit-config.yaml` | higiene, gitleaks, detect-private-key, mensagem de commit |
| `.editorconfig`, `.gitattributes`, `.gitignore`, `.env.example` | padrões de editor, LF, segredos fora do git |

Actions fixadas por SHA de commit (com a tag no comentário); o Dependabot atualiza.

## Criar um projeto novo

```bash
gh repo create felpsxp-hq/<nome> --template felpsxp-hq/felpsxp-template --public --clone
cd <nome>
./scripts/init-template.sh --name <nome> --description "<uma linha em inglês>" --fxp FXP-0xx --github
git add -A && git commit -m "chore: initialize from felpsxp-template"
git push
```

Se o stack (`package.json`, `pyproject.toml`, `Dockerfile`) for criado depois, ligue o bloco
correspondente no `.github/dependabot.yml` à mão (descomente entre `# npm-start` e `# npm-end`).

## Configurações que o script não cobre

- **Settings → Code security:** CodeQL *default setup* e Dependabot security updates.
- Repositório privado: secret scanning pode exigir GitHub Advanced Security.
- Projeto **não open source** (ex.: `beecrowd-problem-solving`): apague o `LICENSE` e o badge.

## Por que a proteção de `main` não exige aprovação

Quem mantém sozinho não consegue aprovar o próprio PR. O ruleset exige PR, histórico linear e
os checks `Hygiene & secrets` e `Conventional Commits title`. Quando houver mais gente, ligue
`required_approving_review_count: 1` e `require_code_owner_review`.

## Manutenção do próprio template

- Mudou uma convenção? Altere aqui primeiro, depois propague para os repositórios existentes.
- `pre-commit autoupdate` de tempos em tempos; o Dependabot cuida das Actions.
