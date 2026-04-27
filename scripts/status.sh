#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ -f ".env" ]]; then
  SERVER_TARGET="$(grep -E '^SUPABASE_TARGET=' .env | cut -d'=' -f2- || true)"
  CLIENT_TARGET="$(grep -E '^NEXT_PUBLIC_SUPABASE_TARGET=' .env | cut -d'=' -f2- || true)"
  echo "Current .env server target: ${SERVER_TARGET:-<missing>}"
  echo "Current .env client target: ${CLIENT_TARGET:-<missing>}"
else
  echo ".env not found in project root."
fi

echo
echo "Supabase local status:"
if supabase status >/dev/null 2>&1; then
  supabase status
else
  echo "Supabase local stack is not running (or not initialized)."
fi

echo
echo "Docker compose app status:"
docker compose --env-file .env ps || true
