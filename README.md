# Delegate Coding to Grok

A standalone Claude Code skill from ThirdWag for delegating non-trivial coding tasks to Grok while keeping a strict review boundary.

The skill teaches the orchestrator to write a tight delegation spec, call `/grok:rescue`, review the actual `git diff`, run gates, and either accept the diff or send a delta spec back to Grok.

## Requirements

- Claude Code with skill support.
- A working `/grok:rescue` command from your Grok Claude plugin or equivalent local setup.

## Install

Clone the repository and run the installer:

```bash
git clone https://github.com/ThirdWag/delegate-coding-to-grok.git
cd delegate-coding-to-grok
./install.sh
```

Or copy the skill manually:

```bash
mkdir -p ~/.claude/skills
cp -R skills/delegate-coding-to-grok ~/.claude/skills/
```

Restart Claude Code if it was already running, then invoke:

```text
/delegate-coding-to-grok
```

## Repository Layout

```text
skills/delegate-coding-to-grok/SKILL.md
```

This is a standalone skill, not a Claude Code plugin. It does not bundle API keys, credentials, or Grok configuration.

## Acknowledgements

This skill was inspired by the Grok delegation workflow enabled by Vasi Hemanth's [grok-build-plugin](https://github.com/VasiHemanth/grok-build-plugin), which provides Claude Code commands such as `/grok:rescue`.
