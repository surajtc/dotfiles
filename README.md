# NixOS configuration

This is the NixOS and Home Manager configuration for the `machine` host.
The `dotfiles-old/` directory is kept only as a reference for the previous setup.

## Common commands

Format all Nix files with Alejandra:

```bash
nix fmt /etc/dotfiles
```

Check the flake without switching systems:

```bash
nix flake check /etc/dotfiles
```

Build the system first:

```bash
nix build /etc/dotfiles#nixosConfigurations.machine.config.system.build.toplevel
```

Apply the configuration:

```bash
sudo nixos-rebuild switch --flake /etc/dotfiles#machine
```

The shell alias `nix-rebuild` runs the same rebuild command. `nix-format` runs
Alejandra through `nix fmt`.

## Generations and rollback

List system generations:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

Roll back to the previous generation:

```bash
sudo nixos-rebuild switch --rollback
```

Choose an older generation from the boot menu when a rebuild does not boot.

## Updating inputs

Update the lock file:

```bash
nix flake update /etc/dotfiles
```

Review the changes, format, check, and rebuild before keeping the update.

## Local Git identity

`modules/home-manager/programs/git.nix` contains a machine-local Git identity
and is marked `assume-unchanged` in this repository's local Git index so it is
not included in commits. This index flag is local to this checkout and is not
shared with other clones. To resume tracking edits to the file, run:

```bash
git update-index --no-assume-unchanged modules/home-manager/programs/git.nix
```

## Garbage collection

Remove old Nix store generations:

```bash
sudo nix-collect-garbage -d
```

This removes old generations and may remove the easiest local rollback paths.

## Repository layout

- `flake.nix` and `flake.lock` define inputs and the `machine` system.
- `hosts/laptop/` contains host-specific settings and hardware configuration.
- `users/admin/` contains the Home Manager entry point and user variables.
- `modules/nixos/` contains system-level modules.
- `modules/home-manager/` contains user, desktop, and program modules.
- `packages/`, `overlays/`, and `lib/` are extension points for future additions.

When adding files used by a flake, make sure Git tracks them:

```bash
git status
git add path/to/file.nix
```

Nix evaluates the Git-visible flake source, so ignored or untracked files may
appear as missing during evaluation.
