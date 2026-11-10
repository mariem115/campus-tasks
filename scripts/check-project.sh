#!/usr/bin/env bash
set -euo pipefail
echo "== Vérification avant release =="
for f in Dockerfile compose.yaml requirements.txt requirements-dev.txt .gitignore .github/workflows/ci.yml; do
  [ -f "$f" ] || { echo "MANQUANT : $f" >&2; exit 1; }
  echo "ok  $f"
done
[ -z "$(git status --porcelain)" ] || { echo "ERREUR : modifications non commitées" >&2; exit 1; }
echo "ok  arbre de travail propre"
docker compose config -q && echo "ok  compose.yaml valide"
if git ls-files | grep -E '(^|/)\.env'; then echo "ERREUR : fichier .env versionné" >&2; exit 1; fi
echo "ok  aucun .env versionné"
python3 -m pytest -q
echo "== Projet prêt pour la release =="
