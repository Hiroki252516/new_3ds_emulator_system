#!/usr/bin/env bash
set -Eeuo pipefail

MAX_ITERATIONS="${MAX_ITERATIONS:-200}"
SLEEP_SECONDS="${SLEEP_SECONDS:-10}"
APPROVAL_MODE="${APPROVAL_MODE:-auto_edit}"
PROMPT_FILE="${PROMPT_FILE:-tasks/AUTONOMOUS_SUPERVISOR_PROMPT.md}"
LOG_DIR="${LOG_DIR:-.agent-logs/supervisor}"

mkdir -p "$LOG_DIR"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: required command not found: $1" >&2
    exit 127
  fi
}

require_command git
require_command gemini

if [ ! -f "$PROMPT_FILE" ]; then
  echo "ERROR: prompt file not found: $PROMPT_FILE" >&2
  exit 42
fi

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
  echo "ERROR: not inside a git repository" >&2
  exit 42
fi

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

echo "Repository: $REPO_ROOT"
echo "Prompt file: $PROMPT_FILE"
echo "Approval mode: $APPROVAL_MODE"
echo "Max iterations: $MAX_ITERATIONS"
echo "Sleep seconds: $SLEEP_SECONDS"
echo

extract_response() {
  local json_file="$1"

  python3 - "$json_file" <<'PY' 2>/dev/null || true
import json
import sys

path = sys.argv[1]
try:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
except Exception as e:
    print("")
    sys.exit(0)

response = data.get("response", "")
error = data.get("error")

if response:
    print(response)

if error:
    print("\n[ERROR]")
    print(json.dumps(error, ensure_ascii=False, indent=2))
PY
}

for i in $(seq 1 "$MAX_ITERATIONS"); do
  echo "=== Autonomous supervisor iteration $i ==="

  ITERATION_JSON="$LOG_DIR/iteration-$i.json"
  ITERATION_RESPONSE="$LOG_DIR/iteration-$i.response.md"
  ITERATION_STDERR="$LOG_DIR/iteration-$i.stderr.log"

  PROMPT="$(cat "$PROMPT_FILE")

This is autonomous supervisor iteration $i.

Continue autonomous development from the current repository state.

Do exactly one bounded unit of progress. Depending on the current state, that may be one of:

- select or continue the next READY task
- create or use a task worktree/branch
- implement one small coherent change
- run the narrowest relevant tests
- update WORKING_STATE files
- commit if appropriate
- prepare or update a PR-ready handoff
- review and fix a task branch
- update task status when evidence supports it

Hard rules:

- Do not work directly on main.
- Do not merge into main.
- Do not bypass branch protection.
- Do not mark a task DONE unless Global Definition of Done is satisfied.
- Do not mark REVIEW_READY unless REVIEW_READY Criteria are satisfied.
- Do not paste raw logs into docs, tasks, or the response.
- Save raw logs under .agent-logs/<task-id>/.
- Stop if blocked by credentials, permissions, missing tools, or external human decisions.

If all completion criteria are satisfied, create tasks/FINAL_COMPLETION_REPORT.md and include this exact marker in your final response:

AUTONOMOUS_DEVELOPMENT_COMPLETE

If blocked, create or update tasks/BLOCKED_REPORT.md and include this exact marker in your final response:

AUTONOMOUS_DEVELOPMENT_BLOCKED

Otherwise, finish this iteration with this exact marker in your final response:

AUTONOMOUS_DEVELOPMENT_CONTINUE
"

  set +e
  gemini \
    --approval-mode="$APPROVAL_MODE" \
    --output-format=json \
    -p "$PROMPT" \
    > "$ITERATION_JSON" \
    2> "$ITERATION_STDERR"

  GEMINI_STATUS=$?
  set -e

  extract_response "$ITERATION_JSON" > "$ITERATION_RESPONSE"

  if [ "$GEMINI_STATUS" -ne 0 ]; then
    echo "Gemini CLI exited with status $GEMINI_STATUS"
    echo "See:"
    echo "  $ITERATION_JSON"
    echo "  $ITERATION_STDERR"

    if [ "$GEMINI_STATUS" -eq 53 ]; then
      echo "Turn limit exceeded. Continuing after state-file checkpoint opportunity."
    else
      echo "Stopping because Gemini CLI returned a non-recoverable status."
      exit "$GEMINI_STATUS"
    fi
  fi

  echo "Response summary saved to: $ITERATION_RESPONSE"

  if grep -q "AUTONOMOUS_DEVELOPMENT_COMPLETE" "$ITERATION_RESPONSE" "$ITERATION_JSON" 2>/dev/null; then
    echo "Autonomous development completed."
    exit 0
  fi

  if grep -q "AUTONOMOUS_DEVELOPMENT_BLOCKED" "$ITERATION_RESPONSE" "$ITERATION_JSON" 2>/dev/null; then
    echo "Autonomous development blocked."
    echo "Check tasks/BLOCKED_REPORT.md and $ITERATION_RESPONSE"
    exit 2
  fi

  if grep -q "AUTONOMOUS_DEVELOPMENT_CONTINUE" "$ITERATION_RESPONSE" "$ITERATION_JSON" 2>/dev/null; then
    echo "Continuing after $SLEEP_SECONDS seconds..."
  else
    echo "WARNING: No recognized marker found."
    echo "Treating this as continue, but review: $ITERATION_RESPONSE"
  fi

  sleep "$SLEEP_SECONDS"
done

echo "Reached max iterations without completion."
echo "Check logs under $LOG_DIR"
exit 3
