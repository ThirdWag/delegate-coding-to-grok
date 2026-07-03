---
name: delegate-coding-to-grok-doctor
description: Use when checking whether Delegate Coding to Grok is ready to use, especially when /grok:rescue may be missing or Grok is not configured. Explains how to run /grok:setup and install VasiHemanth/grok-build-plugin if the Grok command is unavailable.
---

# Delegate Coding to Grok Doctor

Check whether the Grok delegation command is available before using the delegate workflow.

## Preflight

Ask the user to run:

```text
/grok:setup
```

Interpret the result:

- If `/grok:setup` works and reports Grok is installed and authenticated, tell the user to continue with `/delegate-coding-to-grok`.
- If `/grok:setup` is not recognized, tell the user that the Grok plugin is not installed or not loaded.
- If `/grok:setup` reports Grok is missing or not authenticated, tell the user to follow that setup output before using delegation.

## Missing Plugin

If `/grok:setup` or `/grok:rescue` is unavailable, tell the user to install Vasi Hemanth's Grok plugin:

```text
/plugin marketplace add VasiHemanth/grok-build-plugin
/plugin install grok@grok-build-plugin
/reload-plugins
/grok:setup
```

After setup passes, tell the user to run:

```text
/delegate-coding-to-grok
```

## Rules

- Do not attempt delegation until `/grok:setup` succeeds.
- Do not claim `/grok:rescue` is available unless the user's Claude session recognizes the Grok plugin commands.
- If the user wants a read-only investigation, remind them they can use `/grok:rescue --read-only` directly.
