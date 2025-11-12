#!/bin/bash
set -e

TITLE="$1"
BODY="$2"
SOURCE_BRANCH="$3"
DEST_BRANCH="$4"

echo "Abrindo PR: '$TITLE' de '$SOURCE_BRANCH' para '$DEST_BRANCH'"

gh pr create \
  --title "$TITLE" \
  --body "$BODY" \
  --base "$DEST_BRANCH" \
  --head "$SOURCE_BRANCH" \
  --repo "$GITHUB_REPOSITORY"
