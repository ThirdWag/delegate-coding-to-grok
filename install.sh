#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$repo_root/skills/delegate-coding-to-grok"
target_dir="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/delegate-coding-to-grok"

if [[ ! -f "$source_dir/SKILL.md" ]]; then
  echo "Missing $source_dir/SKILL.md" >&2
  exit 1
fi

mkdir -p "$(dirname "$target_dir")"
rm -rf "$target_dir"
cp -R "$source_dir" "$target_dir"

echo "Installed delegate-coding-to-grok to $target_dir"
