#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -f ".env.local" ]]; then
  echo "Missing .env.local in project root."
  exit 1
fi

cp .env.local .env
echo "Copied .env.local -> .env"

echo "Starting local Supabase..."
supabase start

echo "Starting app containers..."
docker compose --env-file .env up -d
