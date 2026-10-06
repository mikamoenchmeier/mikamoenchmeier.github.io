#!/bin/bash
# Moves finished work one step up:
#   tools/promote.sh beta          development → beta   (beta.mikamoenchmeier.com)
#   tools/promote.sh main v2.2     beta → main          (the live website), tagged v2.2
set -e
say() { printf "\n\033[1;33m==> %s\033[0m\n" "$1"; }
cd "$(git rev-parse --show-toplevel)"

TARGET="$1"; TAG="$2"
case "$TARGET" in
  beta) FROM=development ;;
  main) FROM=beta; [ -n "$TAG" ] || { echo "Give the new version too, e.g.: tools/promote.sh main v2.2"; exit 1; }
        git fetch -q --tags; git rev-parse -q --verify "refs/tags/$TAG" >/dev/null && { echo "Tag $TAG already exists."; exit 1; } ;;
  *) echo "Usage: tools/promote.sh beta   or   tools/promote.sh main v2.2"; exit 1 ;;
esac
[ -z "$(git status --porcelain)" ] || { echo "You have uncommitted changes. Commit or discard them first."; exit 1; }

say "Checking what's new on $FROM"
git fetch -q origin
git push -q origin "$FROM" 2>/dev/null || true
NEW=$(git log --oneline "origin/$TARGET..origin/$FROM" --no-merges)
[ -n "$NEW" ] || { echo "Nothing new on $FROM to promote."; exit 0; }
echo "$NEW"

say "Opening a pull request $FROM → $TARGET"
gh pr create --base "$TARGET" --head "$FROM" --title "Promote $FROM → $TARGET${TAG:+ ($TAG)}" --body "$(printf 'Changes:\n%s\n' "$NEW")" >/dev/null

say "Waiting for the Cloudflare build check"
for i in $(seq 1 20); do
  out=$(gh pr checks "$FROM" 2>&1 || true)
  echo "$out" | grep -qi "no checks reported" || break
  sleep 10
done
gh pr checks "$FROM" --watch || { echo "The build failed. Fix it on $FROM, push, and run this again (the pull request stays open)."; exit 1; }

say "Merging"
for i in 1 2 3 4 5 6; do
  gh pr merge "$FROM" --merge && break
  [ $i -eq 6 ] && { echo "GitHub still won't merge. Run: gh pr view $FROM --json mergeStateStatus,reviewDecision"; exit 1; }
  echo "   GitHub isn't ready yet, retrying in 20 seconds…"; sleep 20
done

if [ "$TARGET" = main ]; then
  say "Tagging $TAG"
  git fetch -q origin
  git tag -a "$TAG" -m "$TAG" origin/main
  git push -q origin "$TAG"
fi

"$(dirname "$0")/sync.sh"
