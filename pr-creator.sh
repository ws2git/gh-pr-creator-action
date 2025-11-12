#!/usr/bin/env bash
set -euo pipefail

# Verificação de Parâmetros
TITLE="${1:?É necessário fornecer o TÍTULO do PR.}"
BODY="${2:?É necessário fornecer o CORPO do PR.}"
SOURCE_BRANCH="${3:?É necessário fornecer a BRANCH DE ORIGEM.}"
DEST_BRANCH="${4:?É necessário fornecer a BRANCH DE DESTINO.}"

echo "Abrindo PR: '$TITLE' de '$SOURCE_BRANCH' para '$DEST_BRANCH'"

gh pr create \
  --title "$TITLE" \
  --body "$BODY" \
  --base "$DEST_BRANCH" \
  --head "$SOURCE_BRANCH" \
  --repo "$GITHUB_REPOSITORY"
