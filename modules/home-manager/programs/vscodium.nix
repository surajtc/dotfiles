{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    pyright
    gopls
    rust-analyzer
  ];

  # Use the Microsoft Marketplace from VSCodium's Extensions view. Extension
  # versions are intentionally no longer managed by Home Manager.
  xdg.configFile."VSCodium/product.json".text = builtins.toJSON {
    extensionsGallery = {
      serviceUrl = "https://marketplace.visualstudio.com/_apis/public/gallery";
      cacheUrl = "https://vscode.blob.core.windows.net/gallery/index";
      itemUrl = "https://marketplace.visualstudio.com/items";
    };
  };

  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Nixpkgs-managed extensions.
        pkief.material-icon-theme
        jnoortheen.nix-ide
        bradlc.vscode-tailwindcss
        biomejs.biome
        esbenp.prettier-vscode
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        ms-python.python
        golang.go
        rust-lang.rust-analyzer
      ];

      # Install these from the store:
      #   r5n.es-js-snippets
      #   rangav.vscode-thunder-client
      #   openai.chatgpt
      userSettings = {
        # Preserve the existing terminal workflow from the previous local
        # VSCodium settings file while Home Manager takes ownership of it.
        "workbench.startupEditor" = "none";
        "terminal.integrated.profiles.linux" = {
          bash = {
            path = "bash";
            icon = "terminal-bash";
          };
          zsh = {
            path = "/etc/profiles/per-user/admin/bin/zsh";
          };
          fish = {
            path = "fish";
          };
          tmux = {
            path = "tmux";
            icon = "terminal-tmux";
          };
          pwsh = {
            path = "pwsh";
            icon = "terminal-powershell";
          };
        };
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "update.mode" = "none";
        "telemetry.telemetryLevel" = "off";
        "workbench.iconTheme" = "material-icon-theme";
        "window.titleBarStyle" = "custom";
        "window.controlsStyle" = "hidden";
        "window.customTitleBarVisibility" = "never";

        "editor.autoClosingBrackets" = "always";
        "editor.autoClosingQuotes" = "always";
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = true;
        "editor.formatOnSave" = false;

        "auto-close-tag.enableAutoCloseTag" = true;
        "auto-rename-tag.activationOnLanguage" = [
          "html"
          "javascriptreact"
          "typescriptreact"
          "xml"
        ];

        # Biome is the formatter for JS/TS/React; Prettier remains available
        # for formats Biome does not handle.
        "[javascript]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };
        "[javascriptreact]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };

        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[markdown]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        # Keep language servers Nix-managed instead of letting extensions
        # download tools into the user profile.
        "go.toolsManagement.autoUpdate" = false;
        "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
      };
    };
  };
}
