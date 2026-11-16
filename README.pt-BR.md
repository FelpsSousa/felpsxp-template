# felpsxp-template

> O repositório-modelo de todos os projetos FelpsXP: documentação bilíngue, Conventional Commits,
> higiene com pre-commit, varredura de segredos, CI, Dependabot, ADRs, divulgação do uso de IA e
> um script que transforma uma cópia nova em projeto pronto.

[English](README.md) · **Português (BR)**

Parte do **ecossistema digital FelpsXP** · ID no registro: `FXP-027`

---

## Por que um modelo

Todo repositório FelpsXP nasce da mesma base, então cada regra é escrita uma vez e vale em todos:
como os commits se chamam, quais hooks rodam, o que o CI verifica, como as decisões são registradas,
como o uso de IA é declarado. Um projeto novo está pronto para o primeiro pull request poucos
minutos depois do `gh repo create`, e quem conhece um repositório conhece todos.

Nasceram dele o [felpsxp-hub](https://github.com/FelpsSousa/felpsxp-hub) (público) e os privados
felpsxp-logs, felpsxp-sentinel e felpsxp-control.

## O que vem pronto

| Arquivo | Para quê |
| ------- | -------- |
| `skeleton/README.md`, `skeleton/README.pt-BR.md` | o README bilíngue do projeto, instalado e preenchido pelo script |
| `LICENSE` | MIT por padrão; `--license proprietary` ou `--license none` para projetos fechados |
| `CONTRIBUTING.md` | fluxo issue, branch, Conventional Commits, PR com squash |
| `SECURITY.md` | reporte privado via GitHub Advisories, com prazos realistas para quem mantém sozinho |
| `CLAUDE.md` | contexto persistente do Claude Code: princípios, regra de escrita, stack padrão, convenções |
| `AI.md` | divulgação única do uso de IA; o projeto ajusta para que cada frase seja verdade |
| `.claude/settings.json` | desliga na ferramenta o rodapé de atribuição do Claude Code em commits e PRs |
| `docs/adr/` | ADR-0001 (por que registramos decisões), template MADR e índice |
| `docs/runbooks/`, `docs/postmortems/` | procedimentos e incidentes, com modelo de postmortem |
| `docs/showcase/` | checklist do que pode e do que nunca pode ir para o público |
| `docs/security/web-headers.md` | linha de base de cabeçalhos de segurança para app web |
| `.github/workflows/ci.yml` | pre-commit e gitleaks no histórico inteiro; jobs Node e Python, com auditoria de dependências, quando o stack existe |
| `.github/workflows/pr-title.yml` | título de PR em Conventional Commits |
| `.github/dependabot.yml` | Actions semanal; os blocos npm, pip e Docker são ligados pelo script |
| `.github/CODEOWNERS`, templates de issue e PR | revisão automática e formulários |
| `.pre-commit-config.yaml` | higiene, gitleaks, chaves privadas, formato da mensagem de commit e bloqueio de travessões em Markdown |
| `.editorconfig`, `.gitattributes`, `.gitignore`, `.env.example`, `.nvmrc` | padrões de editor, LF, segredos fora do git, versão do Node usada pelo CI |

As Actions são fixadas por SHA de commit, com a tag no comentário; o Dependabot atualiza.

## Criar um projeto

```bash
gh repo create FelpsSousa/<nome> --template FelpsSousa/felpsxp-template --public --clone
cd <nome>
./scripts/init-template.sh --name <nome> --description "<uma linha em inglês>" --fxp FXP-0xx --github
```

O `init-template.sh`, nesta ordem:

1. preenche nome, descrição, ID no registro e dono em todos os arquivos;
2. move os esqueletos de README para o lugar, substituindo este arquivo e a versão em inglês;
3. liga os blocos do Dependabot para os stacks que encontrar (`package.json`, `pyproject.toml`, `Dockerfile`);
4. aplica a licença (`--license mit`, o padrão, `proprietary` ou `none`);
5. remove o que é só do modelo: o changelog, os ADRs do modelo, o formulário de proposta e ele mesmo;
6. cria o commit `chore: initialize from felpsxp-template`;
7. com `--github`: faz o push, cria as labels, configura merge só por squash com exclusão automática de branch, liga secret scanning e reporte privado de vulnerabilidade em repositórios públicos e protege a `main` com um ruleset (só pull request, histórico linear, checks obrigatórios);
8. instala os hooks do pre-commit.

A proteção vem depois do push de propósito: o ruleset rejeitaria um push direto. As outras opções
são `--owner` (padrão `FelpsSousa`; `felpsxp-hq` quando a organização existir) e `--license`.

## Depois do script

1. **Settings, Code security:** ligue o CodeQL *default setup* e os Dependabot security updates.
2. Preencha `README.md`, `README.pt-BR.md` e `CLAUDE.md` (visão geral, stack, comandos).
3. Escreva o ADR-0002 com a primeira decisão real do projeto e deixe o `AI.md` verdadeiro para ele.
4. Daí em diante, trabalhe em branches e abra pull requests; a `main` só muda por eles.

## O que o script não consegue aplicar

- Em **repositório privado no plano Free**, o GitHub não aceita o ruleset: a `main` fica sem
  proteção, o script avisa, e o `AI.md` não pode afirmar proteção de branch até ela existir. O
  secret scanning exige GitHub Advanced Security nesse caso; o gitleaks cobre no pre-commit e no CI.
- Se o stack (`package.json`, `pyproject.toml`, `Dockerfile`) chegar depois, ligue o bloco do
  Dependabot à mão (descomente entre `# npm-start` e `# npm-end`).

## Por que a `main` não exige aprovação

Quem mantém sozinho não consegue aprovar o próprio pull request. O ruleset exige pull request,
histórico linear e os checks `Hygiene & secrets` e `Conventional Commits title`. Quando houver mais
gente, ligue `required_approving_review_count: 1` e `require_code_owner_review`.

## Mantendo os projetos em sincronia

Uma convenção muda aqui primeiro e chega aos repositórios como pull request. O
[ADR-0002 do modelo](docs/template-adr/0002-template-synchronization.md) decide como: um carimbo de
versão em cada projeto, um manifesto de arquivos gerenciados, semeados e sincronizados por bloco, e
um script que abre o pull request (em andamento). Até lá, as versões são tags com
[changelog](CHANGELOG.md), e o `pre-commit autoupdate` roda de tempos em tempos.

## Estrutura do repositório

```text
.
├── .github/              # CI, Dependabot, CODEOWNERS, templates de issue e PR
├── docs/adr/             # ADR-0001, template MADR e índice (ficam nos projetos)
├── docs/template-adr/    # decisões sobre o próprio modelo (o script remove)
├── docs/                 # runbooks, postmortems, showcase e linhas de base de segurança
├── scripts/init-template.sh
├── skeleton/             # README.md e README.pt-BR.md de um projeto novo
├── CLAUDE.md, AI.md, CONTRIBUTING.md, SECURITY.md
└── CHANGELOG.md          # versões do modelo (o script remove)
```

## Contribuindo

Leia o [CONTRIBUTING.md](CONTRIBUTING.md). Uma prática comprovada num projeto volta para cá pelo
formulário de issue "Template proposal".

## Segurança

Não abra issue pública para vulnerabilidades. Veja o [SECURITY.md](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
