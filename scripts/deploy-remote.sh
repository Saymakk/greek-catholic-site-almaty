#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -f ".env.remote" ]]; then
  echo "Missing .env.remote in project root."
  exit 1
fi

cp .env.remote .env
echo "Copied .env.remote -> .env"

echo "Pulling latest changes..."
git pull

echo "Rebuilding and restarting app containers..."
docker compose --env-file .env build
docker compose --env-file .env up -d

echo "Done. Remote DB mode is active."
