# threebrew Gemini CLI setup files

This bundle contains repository-relative files for the `new_3ds_emulator_system` repository.

It intentionally does **not** include `tasks/task-board.md`.

## Included files

- `GEMINI.md`
- `.gemini/settings.json`
- `.gemini/agents/architect.md`
- `.gemini/agents/codebase-investigator.md`
- `.gemini/agents/reviewer.md`
- `.gemini/agents/test-runner.md`
- `.gemini/agents/release-manager.md`
- `.gemini/commands/checkpoint.toml`
- `.gemini/commands/handoff.toml`
- `.gemini/commands/review-task.toml`
- `.gemini/hooks/pre-compress-state.sh`
- `.gemini/hooks/block-huge-shell-output.sh`
- `tasks/agent-state/TASK-001.WORKING_STATE.md`
- `tasks/architecture/DECISIONS.md`

## Apply

Copy the files into the repository root, preserving paths.

Then run:

```bash
chmod +x .gemini/hooks/*.sh
```

Inside Gemini CLI, reload custom commands and agents:

```text
/commands reload
/agents reload
```

If hooks are disabled or untrusted, use:

```text
/hooks panel
```

and enable the project hooks after reviewing them.
