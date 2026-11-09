#!/bin/sh

# Usage: update-all.sh [-d MAXDEPTH]
# Updates every Git clone and worktree found under the current directory.
# A directory is a repo when it contains .git (a directory for clones, a file
# for worktrees). Directories without .git are searched deeper.

MAXDEPTH=${UPDATE_ALL_DEPTH:-4}
while getopts d: opt
do
  case $opt in
    d) MAXDEPTH=$OPTARG ;;
    *) echo "Usage: $0 [-d MAXDEPTH]" >&2; exit 2 ;;
  esac
done

WORKDIR=$PWD
GCDONE=$(mktemp)
trap 'rm -f "$GCDONE"' EXIT

update_repo() {
  repo=$1
  echo "Updating $repo with Git"
  if [ -z "$(git -C "$repo" remote)" ]
  then
    echo "Skipping $repo: no Git remote configured"
    return
  fi

  gitdir=$(git -C "$repo" rev-parse --absolute-git-dir)
  log="$gitdir/update.log"
  if git -C "$repo" symbolic-ref -q HEAD > /dev/null
  then
    git -C "$repo" pull --ff-only > "$log" 2>&1
  else
    echo "Skipping pull in $repo: detached HEAD"
    : > "$log"
  fi

  # Worktrees share one object store; gc it only once.
  common=$(cd "$repo" && cd "$(git rev-parse --git-common-dir)" && pwd)
  if ! grep -qxF "$common" "$GCDONE"
  then
    echo "$common" >> "$GCDONE"
    echo "Running gc for $common"
    git -C "$repo" gc >> "$log" 2>&1
  fi
}

find "$WORKDIR" -maxdepth "$MAXDEPTH" -name .git -prune -print |
while IFS= read -r gitentry
do
  update_repo "$(dirname "$gitentry")"
  echo "Done!"
  echo ""
done

