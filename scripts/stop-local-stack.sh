#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "Stopping app containers..."
docker compose --env-file .env down || true

echo "Stopping local Supabase..."
supabase stop --project-id greek-catholic-almaty-site || true
