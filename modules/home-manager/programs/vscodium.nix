{pkgs, ...}:
let
  openVsxExtension = {
    publisher,
    name,
    version,
    url,
    hash,
  }:
    pkgs.stdenvNoCC.mkDerivation {
      pname = "vscode-extension-${publisher}-${name}";
      inherit version;
      vscodeExtPublisher = publisher;
      vscodeExtName = name;
      vscodeExtUniqueId = "${publisher}.${name}";
      src = pkgs.fetchurl {inherit url hash;};
      nativeBuildInputs = [pkgs.unzip];
      unpackPhase = "unzip $src -d .";
      installPhase = ''
        mkdir -p $out/share/vscode/extensions/${publisher}.${name}
        cp -r extension/. $out/share/vscode/extensions/${publisher}.${name}/
      '';
    };

  reactSnippets = openVsxExtension {
    publisher = "dsznajder";
    name = "es7-react-js-snippets";
    version = "4.4.3";
    url = "https://open-vsx.org/api/dsznajder/es7-react-js-snippets/4.4.3/file/dsznajder.es7-react-js-snippets-4.4.3.vsix";
    hash = "sha256-S3J7JXPyjdQ1bdpyb6xY5gKPZhnNtgFaKU9GJPxP/j8=";
  };

  thunderClient = openVsxExtension {
    publisher = "rangav";
    name = "vscode-thunder-client";
    version = "2.41.5";
    url = "https://open-vsx.org/api/rangav/vscode-thunder-client/2.41.5/file/rangav.vscode-thunder-client-2.41.5.vsix";
    hash = "sha256-sP4H1pqXyRsHaQvhtV4BkYK5mgL5zKv/eQWDvv/RLls=";
  };

  codex = openVsxExtension {
    publisher = "openai";
    name = "chatgpt";
    version = "26.5908.31748";
    url = "https://open-vsx.org/api/openai/chatgpt/linux-x64/26.5908.31748/file/openai.chatgpt-26.5908.31748@linux-x64.vsix";
    hash = "sha256-ejWbk7IA5EBusZhYpI+n4tpu1VfTV5rY7Gtj7k01S0U=";
  };
in {
  home.packages = with pkgs; [
    nil
    pyright
    gopls
    rust-analyzer
  ];

  programs.vscodium = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # UI and Nix
        pkief.material-icon-theme
        jnoortheen.nix-ide

        # React / web development
        bradlc.vscode-tailwindcss
        biomejs.biome
        esbenp.prettier-vscode
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        reactSnippets
        thunderClient
        codex

        # Language support
        ms-python.python
        golang.go
        rust-lang.rust-analyzer
      ];

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
