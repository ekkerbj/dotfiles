#!/bin/bash
# Tests for update-all.sh. Usage: bin/test-update-all.sh
set -u
SCRIPT="$(cd "$(dirname "$0")" && pwd)/update-all.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t
fail=0

check() { # description, condition result
  if [ "$2" = 0 ]; then echo "PASS: $1"; else echo "FAIL: $1"; fail=1; fi
}

# upstream with one commit
git init -q "$TMP/seed" && git -C "$TMP/seed" commit -q --allow-empty -m one
git clone -q --bare "$TMP/seed" "$TMP/remote.git"

ROOT="$TMP/root"
mkdir -p "$ROOT/holder" "$ROOT/plain dir" "$ROOT/norem"
git clone -q "$TMP/remote.git" "$ROOT/holder/main"
git -C "$ROOT/holder/main" worktree add -q -b feat ../feature-x
git -C "$ROOT/holder/feature-x" branch -q -u origin/master 2>/dev/null ||
  git -C "$ROOT/holder/feature-x" branch -q -u origin/main 2>/dev/null
git clone -q "$TMP/remote.git" "$ROOT/plain dir/clone"
git init -q "$ROOT/norem/repo"

# push a new commit upstream
git -C "$TMP/seed" commit -q --allow-empty -m two
git -C "$TMP/seed" push -q "$TMP/remote.git" HEAD

OUT=$(cd "$ROOT" && sh "$SCRIPT" 2>&1)

head_of() { git -C "$1" rev-parse HEAD; }
new=$(head_of "$TMP/seed")

[ "$(head_of "$ROOT/holder/main")" = "$new" ]; check "nested clone updated" $?
[ "$(head_of "$ROOT/holder/feature-x")" = "$new" ]; check "worktree updated" $?
[ "$(head_of "$ROOT/plain dir/clone")" = "$new" ]; check "path with space updated" $?
echo "$OUT" | grep -q "Skipping .*norem/repo"; check "no-remote repo skipped" $?
! echo "$OUT" | grep -q "Updating $ROOT/holder$"; check "holder not treated as repo" $?
[ "$(echo "$OUT" | grep -c "Running gc")" = 2 ]; check "gc once per object store" $?
[ ! -e "$ROOT/holder/main/update.log" ]; check "no log in working tree" $?

exit $fail
