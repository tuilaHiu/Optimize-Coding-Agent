#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
AGENTS_HOME="${AGENTS_HOME:-$HOME/.agents}"
CODEX_CONFIG="$CODEX_HOME/config.toml"

info() {
  printf '[install] %s\n' "$*"
}

warn() {
  printf '[install][warn] %s\n' "$*" >&2
}

ensure_dir() {
  mkdir -p "$1"
}

copy_skill_dirs_replace() {
  local src="$1"
  local dest="$2"
  local skill
  local name

  ensure_dir "$dest"

  for skill in "$src"/*; do
    [[ -d "$skill" ]] || continue
    [[ -f "$skill/SKILL.md" ]] || {
      warn "Skipping '$skill' because it does not contain SKILL.md"
      continue
    }

    name="$(basename "$skill")"
    rm -rf "$dest/$name"
    cp -R "$skill" "$dest/$name"
  done
}

copy_agent_files_replace() {
  local src="$1"
  local dest="$2"
  local agent
  local name

  ensure_dir "$dest"

  for agent in "$src"/*.toml; do
    [[ -f "$agent" ]] || continue
    name="$(basename "$agent")"
    rm -f "$dest/$name"
    cp "$agent" "$dest/$name"
  done
}

codex_mcp_has() {
  local name="$1"

  command -v codex >/dev/null 2>&1 &&
    codex mcp list 2>/dev/null |
      awk 'NR > 1 && $1 == name { found = 1 } END { exit found ? 0 : 1 }' name="$name"
}

append_mcp_section_if_missing() {
  local name="$1"
  local body="$2"

  ensure_dir "$CODEX_HOME"
  touch "$CODEX_CONFIG"

  if grep -Fq "[mcp_servers.$name]" "$CODEX_CONFIG"; then
    info "MCP server '$name' already present in $CODEX_CONFIG"
    return 0
  fi

  {
    printf '\n[mcp_servers.%s]\n' "$name"
    printf '%s\n' "$body"
  } >>"$CODEX_CONFIG"

  info "Added MCP server '$name' to $CODEX_CONFIG"
}

add_mcp_with_codex_or_toml() {
  local name="$1"
  shift

  if codex_mcp_has "$name"; then
    info "MCP server '$name' already registered"
    return 0
  fi

  if command -v codex >/dev/null 2>&1; then
    if codex mcp add "$name" "$@"; then
      info "Registered MCP server '$name' with codex CLI"
      return 0
    fi

    warn "codex mcp add failed for '$name'; falling back to direct TOML update"
  else
    warn "codex CLI not found; falling back to direct TOML update for '$name'"
  fi

  case "$name" in
    openaiDeveloperDocs)
      append_mcp_section_if_missing "$name" 'url = "https://developers.openai.com/mcp"'
      ;;
    glab)
      append_mcp_section_if_missing "$name" 'command = "glab"
args = ["mcp", "serve"]'
      ;;
    *)
      warn "No fallback TOML template for MCP server '$name'"
      return 1
      ;;
  esac
}

install_skills_and_agents() {
  info "Installing skills into $AGENTS_HOME/skills"
  copy_skill_dirs_replace "$ROOT_DIR/.agents/skills" "$AGENTS_HOME/skills"

  info "Installing custom agents into $CODEX_HOME/agents"
  copy_agent_files_replace "$ROOT_DIR/.codex/agents" "$CODEX_HOME/agents"
}

install_mcp_servers() {
  info "Installing MCP server config"
  add_mcp_with_codex_or_toml openaiDeveloperDocs --url "https://developers.openai.com/mcp"
  add_mcp_with_codex_or_toml glab -- glab mcp serve

  if command -v glab >/dev/null 2>&1; then
    if ! glab mcp serve --help >/dev/null 2>&1; then
      warn "glab is installed but 'glab mcp serve' did not run cleanly. If glab was installed with Snap, consider installing glab from the GitLab package or binary release."
    fi
  else
    warn "glab is not installed. Install and authenticate glab before using the GitLab MCP server."
  fi
}

main() {
  install_skills_and_agents
  install_mcp_servers

  info "Done. Restart Codex so newly installed skills, agents, and MCP servers are loaded."
}

main "$@"
