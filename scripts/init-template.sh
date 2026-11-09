#!/usr/bin/env bash
# Turn a fresh copy of felpsxp-template into a real project.
#
#   ./scripts/init-template.sh --name felpsxp-news \
#       --description "Bilingual AI-summarized news portal" \
#       --fxp FXP-050 [--owner FelpsSousa] [--license mit|proprietary|none] [--github]
#
# What it does, in this order:
#   1. Replaces {{PROJECT_NAME}}, {{PROJECT_DESCRIPTION}}, {{FXP_ID}} and {{OWNER}} in every text file.
#   2. Enables the Dependabot blocks for the stacks it finds (package.json, pyproject.toml, Dockerfile).
#   3. Applies --license (default: mit), then removes TEMPLATE.md, CHANGELOG.md and this script.
#   4. Inside a git repository: creates the "chore: initialize from felpsxp-template" commit
#      (bypassing the no-commit-to-branch hook only for this first commit).
#   5. With --github (needs an authenticated `gh`): pushes that commit, then creates labels and
#      applies repository settings (squash-only merges, branch auto-delete and, on public
#      repositories, secret scanning and private vulnerability reporting) and, last, the ruleset.
#      Protection comes after the push on purpose: the ruleset would reject a direct push.
#   6. Installs the pre-commit hooks if pre-commit is available.
set -euo pipefail

name="$(basename "$(pwd)")"
description=""
fxp="FXP-xxx"
owner="FelpsSousa"
license="mit"
github=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name) name="$2"; shift 2 ;;
    --description) description="$2"; shift 2 ;;
    --fxp) fxp="$2"; shift 2 ;;
    --owner) owner="$2"; shift 2 ;;
    --license) license="$2"; shift 2 ;;
    --github) github=true; shift ;;
    -h|--help) sed -n '2,20p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$description" ]]; then
  echo "error: --description is required" >&2
  exit 1
fi
if [[ ! "$name" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "error: --name must be lowercase kebab-case (got '$name')" >&2
  exit 1
fi

case "$license" in
  mit | proprietary | none) ;;
  *) echo "error: --license must be mit, proprietary or none (got '$license')" >&2; exit 1 ;;
esac

root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$root"

echo "→ Filling placeholders for $name ($fxp)"
export TPL_NAME="$name" TPL_DESC="$description" TPL_FXP="$fxp" TPL_OWNER="$owner"
grep -rIl --exclude-dir=.git --exclude=init-template.sh --exclude=TEMPLATE.md \
  -e '{{PROJECT_NAME}}' -e '{{PROJECT_DESCRIPTION}}' -e '{{FXP_ID}}' -e '{{OWNER}}' . |
  while IFS= read -r file; do
    perl -pi -e 's/\{\{PROJECT_NAME\}\}/$ENV{TPL_NAME}/g;
                 s/\{\{PROJECT_DESCRIPTION\}\}/$ENV{TPL_DESC}/g;
                 s/\{\{FXP_ID\}\}/$ENV{TPL_FXP}/g;
                 s/\{\{OWNER\}\}/$ENV{TPL_OWNER}/g' "$file"
  done

enable_dependabot() {
  local block="$1"
  perl -0pi -e "s{^  # ${block}-start\n(.*?)^  # ${block}-end\n}{ (my \$b = \$1) =~ s/^  # ?/  /mg; \$b }msge" \
    .github/dependabot.yml
  echo "→ Dependabot: enabled ${block}"
}
[[ -f package.json ]] && enable_dependabot npm
[[ -f pyproject.toml ]] && enable_dependabot pip
[[ -f Dockerfile || -f docker/Dockerfile ]] && enable_dependabot docker

set_license_text() {
  export TPL_LICENSE_EN="$1" TPL_LICENSE_PT="$2"
  perl -ni -e 'print unless /^\[!\[License: MIT\]/' README.md
  perl -pi -e 's/^\[MIT\]\(LICENSE\).*$/$ENV{TPL_LICENSE_EN}/' README.md
  perl -pi -e 's/^\[MIT\]\(LICENSE\).*$/$ENV{TPL_LICENSE_PT}/' README.pt-BR.md
}

case "$license" in
  proprietary)
    cat >LICENSE <<EOF
Copyright (c) $(date +%Y) Felipe Sousa. All rights reserved.

This software and its accompanying documentation are proprietary and
confidential. No part of this repository may be copied, modified,
distributed, sublicensed, or used in any form without prior written
permission from the copyright holder.
EOF
    set_license_text "Private and proprietary. See [LICENSE](LICENSE)." \
      "Privado e proprietário. Veja o [LICENSE](LICENSE)."
    echo "→ License: proprietary"
    ;;
  none)
    rm -f LICENSE
    set_license_text "No license is granted: all rights reserved." \
      "Nenhuma licença é concedida: todos os direitos reservados."
    echo "→ License: none (LICENSE removed)"
    ;;
esac

rm -f TEMPLATE.md CHANGELOG.md
rm -f -- "$0"
rmdir scripts 2>/dev/null || true

committed=false
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git add -A
  # The no-commit-to-branch hook would block this first commit on main; skip it only here.
  SKIP=no-commit-to-branch git commit -q -m "chore: initialize from felpsxp-template" &&
    committed=true && echo "→ Created the initial commit"
fi

if $github; then
  command -v gh >/dev/null || { echo "error: gh CLI not found" >&2; exit 1; }
  repo="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
  visibility="$(gh repo view --json visibility -q .visibility)"

  # The reason a setting failed is only in the API error, so report that instead of guessing.
  explain() {
    if grep -q 'Upgrade to GitHub Pro' <<<"$2"; then
      echo "  ! $1: not available on this plan for a private repository"
    else
      echo "  ! $1: $(head -n 1 <<<"$2")"
    fi
  }

  if $committed; then
    echo "→ Pushing the initial commit"
    git push -q origin HEAD
  fi
  echo "→ Configuring $repo"

  while IFS='|' read -r label color desc; do
    gh label create "$label" --color "$color" --description "$desc" --force >/dev/null
  done <<'LABELS'
type: bug|d73a4a|Something is not working
type: feature|a2eeef|New capability or improvement
status: triage|fbca04|Needs triage
dependencies|0366d6|Dependency updates
area: ci|5319e7|CI and automation
area: js|f1e05a|JavaScript / TypeScript
area: python|3572a5|Python
area: docker|0db7ed|Containers
security|b60205|Security related
LABELS

  gh repo edit "$repo" \
    --enable-squash-merge --enable-merge-commit=false --enable-rebase-merge=false \
    --delete-branch-on-merge >/dev/null
  gh api -X PATCH "repos/$repo" -f squash_merge_commit_title=PR_TITLE \
    -f squash_merge_commit_message=PR_BODY >/dev/null
  if [[ "$visibility" == "PUBLIC" ]]; then
    out="$(gh api -X PUT "repos/$repo/private-vulnerability-reporting" 2>&1)" ||
      explain "private vulnerability reporting" "$out"
    out="$(gh api -X PATCH "repos/$repo" --input - 2>&1 <<'JSON'
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON
    )" || explain "secret scanning" "$out"
  else
    echo "→ Private repository: GitHub secret scanning is not applied; gitleaks covers it in pre-commit and CI"
  fi

  # Protect main: PRs only, linear history, required checks. No required approvals,
  # because a solo maintainer cannot approve their own PR.
  protected=false
  if out="$(gh api -X POST "repos/$repo/rulesets" --input - 2>&1 <<'JSON'
{
  "name": "protect-main",
  "target": "branch",
  "enforcement": "active",
  "conditions": { "ref_name": { "include": ["~DEFAULT_BRANCH"], "exclude": [] } },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "required_linear_history" },
    { "type": "pull_request", "parameters": {
        "required_approving_review_count": 0,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_review_thread_resolution": true } },
    { "type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": false,
        "required_status_checks": [
          { "context": "Hygiene & secrets" },
          { "context": "Conventional Commits title" } ] } }
  ]
}
JSON
  )"; then
    protected=true
  else
    explain "ruleset protect-main" "$out"
  fi
  $protected || echo "  ! main is NOT protected: AI.md must not claim branch protection until it is"
fi


if command -v pre-commit >/dev/null; then
  pre-commit install
else
  echo "→ Install pre-commit (pipx install pre-commit), then run: pre-commit install"
fi

cat <<EOF

✔ $name is ready. Next:
  1. Settings → Code security: enable CodeQL "default setup" and Dependabot security updates.
  2. Fill in README.md, README.pt-BR.md and CLAUDE.md (overview, stack, commands).
  3. Write ADR-0002 with the project's first real decision, and make AI.md true for this project.
  4. From now on, work on branches and open PRs; main only changes through them.
EOF
