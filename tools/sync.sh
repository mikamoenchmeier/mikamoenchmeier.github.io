#!/bin/bash
# Keeps the three branches lined up after a merge: main → beta → development.
set -e
say() { printf "\n\033[1;33m==> %s\033[0m\n" "$1"; }
cd "$(git rev-parse --show-toplevel)"
[ -z "$(git status --porcelain)" ] || { echo "You have uncommitted changes. Commit or discard them first."; exit 1; }

say "Syncing branches"
git fetch -q --prune origin
git switch -q main && git merge -q --ff-only origin/main
git switch -q beta && git merge -q --ff-only origin/beta && git merge -q --no-edit main && git push -q origin beta
git switch -q development && git merge -q --ff-only origin/development && git merge -q --no-edit beta && git push -q origin development
echo "   main, beta and development are lined up. You're on 'development'."
