# 09 — Compatibility policy

## Status values

Use these status labels:

| Status | Meaning |
|---|---|
| Not tested | No data |
| Nothing | Cannot create process or immediately fails |
| Boot | Process starts |
| Intro | Reaches logo/intro |
| Menu | Reaches title/menu |
| In-game | User can interact in gameplay |
| Playable | Major gameplay is possible with acceptable issues |
| Great | Minor issues only |
| Perfect-ish | No known major issues, not a guarantee |

## Compatibility record format

```markdown
# <Software name>

Type: homebrew / test / user-provided decrypted content
Source: self-built / public homebrew / user-provided
Commit:
Date:
Host:
Status:
Renderer:
Audio:
Input:
Notes:
Logs:
Known regressions:
```

## No false compatibility claims

A status claim must include:

- version/commit
- host environment
- what was tested
- logs or screenshots when possible
