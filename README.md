# Delegate Coding to Grok

A standalone Claude Code skill from ThirdWag for delegating non-trivial coding tasks to Grok while keeping a strict review boundary.

The skill teaches the orchestrator to write a tight delegation spec, call `/grok:rescue`, review the actual `git diff`, run gates, and either accept the diff or send a delta spec back to Grok.

## Requirements

- Claude Code with skill support.
- A working `/grok:rescue` command, typically installed via Vasi Hemanth's [grok-build-plugin](https://github.com/VasiHemanth/grok-build-plugin).

## Install

### As a Claude Code Plugin

Add the ThirdWag marketplace, then install the plugin:

```text
/plugin marketplace add ThirdWag/delegate-coding-to-grok
/plugin install delegate-coding-to-grok@thirdwag-skills
/reload-plugins
```

Then invoke the namespaced skill:

```text
/delegate-coding-to-grok:delegate
```

To check the Grok dependency first:

```text
/delegate-coding-to-grok:doctor
```

### As a Standalone Skill

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

To check the Grok dependency first:

```text
/delegate-coding-to-grok-doctor
```

## Repository Layout

```text
.claude-plugin/marketplace.json
plugins/delegate-coding-to-grok/.claude-plugin/plugin.json
plugins/delegate-coding-to-grok/skills/delegate/SKILL.md
plugins/delegate-coding-to-grok/skills/doctor/SKILL.md
skills/delegate-coding-to-grok/SKILL.md
skills/delegate-coding-to-grok-doctor/SKILL.md
```

This repository supports both Claude Code plugin installation and standalone skill installation. It does not bundle API keys, credentials, or Grok configuration.

## Compatibility and Acknowledgements

This skill is designed as a workflow layer for users of Vasi Hemanth's [grok-build-plugin](https://github.com/VasiHemanth/grok-build-plugin), which provides the `/grok:rescue` Claude Code command used by this skill.

No source code from `grok-build-plugin` is included in this repository. The plugin is licensed separately under Apache-2.0. This project remains MIT licensed.

This project is independent and is not affiliated with or endorsed by Vasi Hemanth, xAI, Anthropic, or the Grok Build project.
