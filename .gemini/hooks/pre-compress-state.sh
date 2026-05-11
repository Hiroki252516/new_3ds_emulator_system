#!/usr/bin/env bash
set -euo pipefail

# Gemini CLI hook rule:
# - stdout must contain only the final JSON object
# - debug logs go to stderr

INPUT="$(cat)"
PROJECT_DIR="${GEMINI_PROJECT_DIR:-$(pwd)}"
LOG_DIR="$PROJECT_DIR/.agent-logs/hooks"
mkdir -p "$LOG_DIR"

TS="$(date '+%Y-%m-%d %H:%M:%S %Z')"
SESSION_ID="${GEMINI_SESSION_ID:-unknown-session}"
CWD_VALUE="${GEMINI_CWD:-unknown}"

{
  echo "[$TS] PreCompress fired"
  echo "session=$SESSION_ID"
  echo "cwd=$CWD_VALUE"
  echo "$INPUT"
  echo
} >> "$LOG_DIR/pre-compress.log"

cat <<'JSON'
{
  "decision": "allow",
  "systemMessage": "Before compression, update the current tasks/agent-state/TASK-xxx.WORKING_STATE.md with goal, changed files, commands run, failures, decisions, next step, and raw log paths only.",
  "suppressOutput": true
}
JSON
