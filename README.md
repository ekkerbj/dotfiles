# dotfiles

Personal shell tooling and configuration files used to bootstrap and maintain a local developer environment.

## Overview

This repository is a curated set of:
- command-line helper scripts
- Git, Groovy, and Maven configuration
- workflow utilities for local automation

Some scripts are environment-specific (for example, internal hosts, legacy systems, or team-specific workflows). Review scripts before running them in a new environment.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `bin/` | Executable helper scripts and automation commands |
| `git/git.config` | Git configuration baseline |
| `groovy/grapeConfig.xml` | Groovy Grape dependency configuration |
| `maven/settings.xml` | Maven settings used by local builds |
| `RALPH-README.md` | Recommended `prd.json` format and acceptance-test conventions for `bin/ralph` |

## Quick Start

1. Clone the repository.
2. Add selected scripts to `PATH`.
3. Link or copy configuration files as needed.

Example setup:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Add scripts to PATH for current shell session
export PATH="$PWD/bin:$PATH"

# Optional: persist PATH in shell profile
echo 'export PATH="$HOME/dotfiles/bin:$PATH"' >> ~/.bashrc
```

## Script Usage Notes

- Scripts in `bin/` are not a single cohesive application; they are utility commands.
- Some scripts may require external tools or credentials.
- Prefer running unfamiliar scripts with `bash -x` in a safe environment first.

## Ralph Loop (`bin/ralph`)

`ralph` runs an iterative loop for AI-assisted task completion and checks `prd.json` for remaining work.

Basic usage:

```bash
# Defaults to engine=copilot, limit=10
./bin/ralph

# Explicit engine and iteration limit
./bin/ralph --engine codex 20
```

Requirements:
- `jq`
- `git`
- one supported engine CLI installed (`copilot`, `codex`, or `opencode`)

Related documentation:
- See `RALPH-README.md` for recommended behavior-first `prd.json` structure using Given/When/Then acceptance tests.

## Safety and Portability

- Treat all scripts as executable code and audit before use.
- Validate hostnames, paths, and credentials before running deployment or environment scripts.
- Keep local overrides out of source control when they contain sensitive data.
