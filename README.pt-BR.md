# {{PROJECT_NAME}}

> {{PROJECT_DESCRIPTION}}

[English](README.md) · **Português (BR)**

Parte do **ecossistema digital FelpsXP** · ID no registro: `{{FXP_ID}}`

---

## Visão geral

<!-- Que problema o projeto resolve, para quem, e como se encaixa no ecossistema FelpsXP
     (quais serviços do CORE usa: auth, banco, event bus, design system). -->

## Arquitetura

<!-- Diagrama de alto nível (C4 nível 1/2) e componentes principais.
     Toda decisão relevante fica em docs/adr/; linke os ADRs aqui. -->

Veja os [Architecture Decision Records](docs/adr/README.md) (em inglês).

## Como rodar

```bash
git clone https://github.com/{{OWNER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
pre-commit install          # instala os hooks de pre-commit e commit-msg
cp .env.example .env        # nunca commite o .env
# <instalar dependências>
```

## Contribuindo

Leia o [CONTRIBUTING.md](CONTRIBUTING.md). Commits e títulos de PR seguem
[Conventional Commits](https://www.conventionalcommits.org/pt-br/).

## Segurança

Não abra issue pública para vulnerabilidades. Veja o [SECURITY.md](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
