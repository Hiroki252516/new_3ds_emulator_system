#!/usr/bin/env bash
set -euo pipefail

# Blocks likely unbounded shell commands before they create huge tool results.
# stdout must contain JSON only. Debug goes to stderr.

INPUT="$(cat)"

extract_command_with_python() {
  python3 - <<'INNERPY' 2>/dev/null || true
import json, sys
try:
    data = json.loads(sys.stdin.read())
except Exception:
    sys.exit(0)
paths = [
    ("tool_input", "command"),
    ("toolInput", "command"),
    ("args", "command"),
    ("tool_args", "command"),
    ("toolArgs", "command"),
    ("command",),
]
for path in paths:
    cur = data
    ok = True
    for key in path:
        if isinstance(cur, dict) and key in cur:
            cur = cur[key]
        else:
            ok = False
            break
    if ok and isinstance(cur, str) and cur.strip():
        print(cur.strip())
        sys.exit(0)
INNERPY
}

COMMAND=""
if command -v python3 >/dev/null 2>&1; then
  COMMAND="$(printf '%s' "$INPUT" | extract_command_with_python || true)"
fi

if [ -z "${COMMAND:-}" ] && command -v jq >/dev/null 2>&1; then
  COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // .toolInput.command // .args.command // .tool_args.command // .toolArgs.command // .command // empty' 2>/dev/null || true)"
fi

# If command cannot be parsed, allow. The tool output truncation setting is still a fallback.
if [ -z "${COMMAND:-}" ]; then
  cat <<'JSON'
{"decision":"allow","suppressOutput":true}
JSON
  exit 0
fi

echo "[block-huge-shell-output] command=$COMMAND" >&2

DANGEROUS_PATTERNS='(ctest|cmake --build|npm test|pnpm test|yarn test|pytest|cargo test|go test|docker logs|docker compose logs|kubectl logs|cat .*[.]log|grep -R|find \.|ls -R|du -a)'
SAFE_LIMITERS='(tail|head|tee|--max-count|-m [0-9]+|rg |git diff --stat|git diff --name-only|git status --short|ctest .*--output-on-failure)'

if printf '%s' "$COMMAND" | grep -Eq "$DANGEROUS_PATTERNS"; then
  if ! printf '%s' "$COMMAND" | grep -Eq "$SAFE_LIMITERS"; then
    cat <<'JSON'
{
  "decision": "deny",
  "systemMessage": "This command may produce huge output. Save full output to .agent-logs/<task-id>/ and return only a bounded summary, for example: command 2>&1 | tee .agent-logs/<task-id>/run.log | tail -200"
}
JSON
    exit 0
  fi
fi

cat <<'JSON'
{"decision":"allow","suppressOutput":true}
JSON
