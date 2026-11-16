# {{PROJECT_NAME}}

> {{PROJECT_DESCRIPTION}}

[English](README.md) · **Português (BR)**

Parte do **ecossistema digital FelpsXP** · ID no registro: `{{FXP_ID}}`

---

## O que é

<!-- Três a cinco frases: o problema, para quem, o que existe hoje e o que ainda não existe.
     Diga o estado sem rodeios (protótipo, em uso diário, no ar) e como o projeto se encaixa no
     ecossistema (quais serviços do CORE usa: auth, banco, event bus, design system). -->

## Destaques

<!-- As três a seis coisas que quem lê precisa saber, em grupos. Linke cada uma ao ADR, ao teste
     ou ao documento que a comprova. Remova o grupo que não se aplica. -->

**Arquitetura**

- <!-- Uma decisão e o porquê, com o link para o ADR -->

**Segurança**

- <!-- Um controle que existe e é testado, não um plano -->

**Qualidade**

- <!-- Testes, acessibilidade, desempenho: o que roda em cada pull request -->

## Stack

| Área     | Escolha |
| -------- | ------- |
| Frontend | <!-- ex.: Next.js + Tailwind CSS --> |
| Backend  | <!-- ex.: FastAPI / NestJS --> |
| Dados    | <!-- ex.: PostgreSQL via Supabase --> |
| Hospedagem | <!-- ex.: Vercel / Docker no servidor de casa --> |

Desvios do padrão do ecossistema ficam registrados nos
[Architecture Decision Records](docs/adr/README.md) (em inglês).

## Como rodar

### Pré-requisitos

- Git e [pre-commit](https://pre-commit.com) (`pipx install pre-commit`)
- <!-- Node.js + pnpm e/ou Python + uv, com versões -->

### Instalação

```bash
git clone https://github.com/{{OWNER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
pre-commit install          # instala os hooks de pre-commit e commit-msg
cp .env.example .env        # preencha localmente; nunca commite
# <instalar dependências>
```

### Comandos

| Comando | O que faz |
| ------- | --------- |
| <!-- `pnpm dev` --> | <!-- sobe o servidor de desenvolvimento --> |
| <!-- `pnpm test` --> | <!-- roda os testes --> |
| `pre-commit run --all-files` | roda todas as verificações de higiene e segredos |

## Documentação

- [Architecture Decision Records](docs/adr/README.md): toda decisão cara de reverter.
- [Runbooks](docs/runbooks/README.md) e [postmortems](docs/postmortems/README.md).
- [AI.md](AI.md): onde a IA ajuda neste repositório e onde ela nunca decide.

## Contribuindo

Leia o [CONTRIBUTING.md](CONTRIBUTING.md). Commits e títulos de PR seguem
[Conventional Commits](https://www.conventionalcommits.org/pt-br/); a `main` só muda por
pull request com squash.

## Segurança

Não abra issue pública para vulnerabilidades. Veja o [SECURITY.md](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Felipe Sousa · FelpsXP
