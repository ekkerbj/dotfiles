# dotfiles

Personal shell, editor, and tooling configuration files used to bootstrap and maintain a local developer environment.

## Overview

This repository contains:
- Shell configuration (`bashrc`, `qg.bashrc`)
- Editor configuration for Emacs and Vim
- Utility scripts for local automation and AI-assisted development
- A symlink installer to wire configs into the home directory

Some files are environment-specific (for example, `qg.bashrc` contains legacy work-environment settings). Review before using in a new environment.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `bashrc` | Main Bash configuration (bash-it, RVM, editor, prompt) |
| `qg.bashrc` | Environment-specific Bash config (keychain SSH agent, proxy settings) |
| `vimrc` | Vim configuration |
| `emacs` | Emacs init file |
| `emacs.d/` | Emacs configuration directory |
| `makesymlinks.sh` | Symlinks dotfiles into `~` (backs up any existing files first) |
| `bin/ralph` | AI-assisted iterative loop for completing PRD backlog tasks |
| `bin/update-all.sh` | Runs `git pull` + `git gc` on every git repo under the current directory, skipping repos without remotes |
| `bin/cleantilde.sh` | Finds and deletes Emacs backup files (`*~`) |
| `RALPH-README.md` | Recommended `prd.json` format and acceptance-test conventions for `bin/ralph` |

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Symlink bashrc, vimrc, and Xresources into ~
# Existing files are backed up to ~/dotfiles_old/
bash makesymlinks.sh

# Add bin/ scripts to PATH
echo 'export PATH="$HOME/dotfiles/bin:$PATH"' >> ~/.bashrc
```

## Ralph Loop (`bin/ralph`)

`ralph` drives an AI agent in a loop until all backlog items in `prd.json` have `"passes": true`.

```bash
# Defaults to engine=copilot, limit=10
ralph

# Explicit engine and iteration limit
ralph --engine codex 20
ralph opencode 5
```

Supported engine aliases: `copilot` / `cp`, `codex` / `cd`, `opencode` / `oc`

Requirements:
- `jq`
- `git`
- one supported engine CLI installed (`copilot`, `codex`, or `opencode`)
- `AGENTS.md`, `prd.json`, and `progress.txt` present in the working directory

See `RALPH-README.md` for the recommended behavior-first `prd.json` format with Given/When/Then acceptance tests.

## Safety and Portability

- Treat all scripts as executable code and audit before use.
- `qg.bashrc` contains site-specific hostnames and proxy URLs — update or omit before use elsewhere.
- Keep local overrides containing sensitive data out of source control.
