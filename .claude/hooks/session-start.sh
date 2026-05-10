#!/bin/bash
set -euo pipefail

# Only install in remote (Claude Code on the web) sessions; local devs manage their own envs.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# Install dependencies so `astro check` and `astro build` work without prompting.
npm install --no-audit --no-fund
