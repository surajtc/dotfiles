TODO:

Garbage collection:

```
nix-env --list-generations

nix-collect-garbage  --delete-old

nix-collect-garbage  --delete-generations 1 2 3

# recommeneded to sometimes run as sudo to collect additional garbage
sudo nix-collect-garbage -d

# As a separation of concerns - you will need to run this command to clean out boot
sudo /run/current-system/bin/switch-to-configuration boot
```

Update flake:

```
nix-channel --update

nix flake update
```

Neovim format current buffer

```
:%!alejandra -qq
```

"Intent-to-Add" Method
This tells Git the file exists (making it visible to Nix) without staging its contents for a commit.

Stage the file as an intent:

```
git add -N ./hosts/machine/vars.nix
```

Hide it from future git commit -a commands:
To ensure you don't accidentally commit it later, tell Git to assume the file hasn't changed:
bash

```
git update-index --assume-unchanged ./hosts/machine/vars.nix
```

Use code with caution.
Note: The file must still be in your .gitignore to prevent it from being listed in untracked files by default.
