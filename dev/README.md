# Shared development flakes

This directory contains the development flake used by projects under
`~/Documents/CodeBase`. It is intentionally separate from the NixOS system
flake so development dependencies can evolve without coupling them to system
rebuilds.

The shell currently provides Python 3.14, Node.js, Go, Rust, and their common
development tooling. Python 3.14 is the latest stable Python feature series;
the flake follows the pinned nixpkgs revision in `flake.lock` for the exact
patch release.

## Automatic activation

Home Manager declaratively creates:

```text
~/Documents/CodeBase/.envrc
```

Its contents are:

```bash
use flake /etc/dotfiles/dev
```

After the first system rebuild, authorize it once:

```bash
direnv allow ~/Documents/CodeBase
```

Then entering `CodeBase` or any directory below it automatically loads the
development shell. Leaving the directory unloads it.

## Manual use

From any project directory, enter the same environment directly with:

```bash
nix develop /etc/dotfiles/dev
```

## Updating dependencies

Run this from the dotfiles repository:

```bash
nix flake lock --update-input nixpkgs ./dev
```

Or update all inputs:

```bash
nix flake update ./dev
```

Validate the development flake with:

```bash
nix flake check ./dev
```

When adding or removing tools, edit `dev/flake.nix`, validate it, and commit
both `dev/flake.nix` and `dev/flake.lock`.
