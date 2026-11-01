#!/usr/bin/env bash
# Turn a fresh copy of felpsxp-template into a real project.
#
#   ./scripts/init-template.sh --name felpsxp-news \
#       --description "Bilingual AI-summarized news portal" \
#       --fxp FXP-050 [--owner FelpsSousa] [--github]
#
# What it does, in this order:
#   1. Replaces {{PROJECT_NAME}}, {{PROJECT_DESCRIPTION}}, {{FXP_ID}} and {{OWNER}} in every text file.
#   2. Enables the Dependabot blocks for the stacks it finds (package.json, pyproject.toml, Dockerfile).
#   3. Removes TEMPLATE.md and this script.
#   4. Inside a git repository: creates the "chore: initialize from felpsxp-template" commit
#      (bypassing the no-commit-to-branch hook only for this first commit).
#   5. With --github (needs an authenticated `gh`): pushes that commit, then creates labels and
#      applies repository settings (squash-only merges, branch auto-delete, secret scanning with
#      push protection, private vulnerability reporting) and, last, the ruleset protecting main.
#      Protection comes after the push on purpose: the ruleset would reject a direct push.
#   6. Installs the pre-commit hooks if pre-commit is available.
set -euo pipefail

name="$(basename "$(pwd)")"
description=""
fxp="FXP-xxx"
owner="FelpsSousa"
github=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name) name="$2"; shift 2 ;;
    --description) description="$2"; shift 2 ;;
    --fxp) fxp="$2"; shift 2 ;;
    --owner) owner="$2"; shift 2 ;;
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

rm -f TEMPLATE.md
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
  gh api -X PUT "repos/$repo/private-vulnerability-reporting" >/dev/null ||
    echo "  ! could not enable private vulnerability reporting (enable it in Settings → Security)"
  gh api -X PATCH "repos/$repo" --input - >/dev/null <<'JSON' ||
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON
    echo "  ! could not enable secret scanning (private repos may need GitHub Advanced Security)"

  # Protect main: PRs only, linear history, required checks. No required approvals,
  # because a solo maintainer cannot approve their own PR.
  gh api -X POST "repos/$repo/rulesets" --input - >/dev/null <<'JSON' ||
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
    echo "  ! could not create the ruleset (it may already exist)"
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
  3. Write ADR-0002 with the project's first real decision.
  4. From now on, work on branches and open PRs; main only changes through them.
EOF
