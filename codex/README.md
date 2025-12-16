# WORKFLOW FOR CODEX CLI

# Copy Guide for AGENTS.md and prompts

## 1) Copy the shared files from `~/.codex` into this repo
```bash
# ensure the destination folder exists
mkdir -p ./codex

# copy the agent instructions and the prompts folder from ~/.codex
cp ~/.codex/AGENTS.md ./codex/AGENTS.md
cp -r ~/.codex/prompts ./codex/prompts
```

## 2) Copy the repo versions back into `~/.codex`
```bash
# make sure ~/.codex exists
mkdir -p ~/.codex

# copy this repo's versions to your home config
cp ./codex/AGENTS.md ~/.codex/AGENTS.md
cp -r ./codex/prompts ~/.codex/prompts
```

Notes:
- `cp -r` will overwrite existing files; add `-i` if you want interactive prompts.
- The `prompts` folder is treated as a directory copy; adjust the path if your layout differs.
