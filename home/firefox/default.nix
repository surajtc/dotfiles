{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          # "browser.startup.homepage" = "https://searx.aicampground.com";
          # "browser.search.defaultenginename" = "Searx";
          # "browser.search.order.1" = "Searx";
          "browser.compactmode.show" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "full-screen-api.ignore-widgets" = true;
          "extensions.pocket.enabled" = false;
        };
        # search = {
        #   force = true;
        #   default = "Google";
        #   order = ["Google" "Searx"];
        #   engines = {
        #     "Nix Packages" = {
        #       urls = [
        #         {
        #           template = "https://search.nixos.org/packages";
        #           params = [
        #             {
        #               name = "type";
        #               value = "packages";
        #             }
        #             {
        #               name = "query";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #       icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        #       definedAliases = [":np"];
        #     };
        #     "NixOS Wiki" = {
        #       urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
        #       iconUpdateURL = "https://nixos.wiki/favicon.png";
        #       updateInterval = 24 * 60 * 60 * 1000; # every day
        #       definedAliases = [":nw"];
        #     };
        #     "Searx" = {
        #       urls = [{template = "https://searx.aicampground.com/?q={searchTerms}";}];
        #       iconUpdateURL = "https://nixos.wiki/favicon.png";
        #       updateInterval = 24 * 60 * 60 * 1000; # every day
        #       definedAliases = ["@searx"];
        #     };
        #     "Bing".metaData.hidden = true;
        #     "Google".metaData.alias = ":g"; # builtin engines only support specifying one additional alias
        #   };
        # };

        # https://github.com/mimipile/firefoxCSS/tree/main

        userChrome = ''
          /* Menu button */
          #PanelUI-button {
            -moz-box-ordinal-group: 0 !important;
            order: -2 !important;
            margin: 2px !important;
            /* display: none !important; /* uncomment this line to hide the menu button */
          }

          /* Window control buttons (min, resize and close) */
          .titlebar-buttonbox-container {
            display: none !important;
            margin-right: 12px !important;
          }

          /* Page back and foward buttons */
          #back-button,
          #forward-button
          {
            display: none !important
          }

          /* Extensions button */
          #unified-extensions-button {
            display: none !important
          }

          /* Extension name inside URL bar */
          #identity-box.extensionPage #identity-icon-label {
            visibility: collapse !important
          }

          /* All tabs (v-like) button */
          #alltabs-button {
            display: none !important
          }

          /* URL bar icons */
          #identity-permission-box,
          #star-button-box,
          #identity-icon-box,
          #picture-in-picture-button,
          #tracking-protection-icon-container,
          #reader-mode-button,
          #translations-button
          {
            display: none !important
          }

          /* "This time search with:..." */
          #urlbar .search-one-offs {
            display: none !important
          }

          /* Space before and after tabs */
          .titlebar-spacer {
            display: none;
          }

          /* --- ~END~ element visibility section --- */

          /* Navbar size calc */
          :root{
          --tab-border-radius: 4px !important; /*  Tab border radius -- Changes the tabs rounding  *//*  Default: 6px  */
          --NavbarWidth: 40; /*  Default values: 36 - 43  */
          --TabsHeight: 30; /*  Minimum: 30  *//*  Default: 36  */
          --TabsBorder: 8; /*  Doesnt do anything on small layout  *//*  Default: 8  */
          --NavbarHeightSmall: calc(var(--TabsHeight) + var(--TabsBorder))  /*  Only on small layout  *//*  Default: calc(var(--TabsHeight) + var(--TabsBorder))  *//*  Default as a number: 44  */}

          @media screen and (min-width:1325px)    /*  Only the tabs space will grow from here  */
          {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px)!important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(1325px / 100 * var(--NavbarWidth)) !important} #nav-bar{margin-right: calc(100vw - calc(1325px / 100 * var(--NavbarWidth))) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important}}

          @media screen and (min-width:950px) and (max-width:1324px)    /*  Both the tabs space and the navbar will grow  */
          {:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px) !important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(var(--NavbarWidth) * 1vw) !important} #nav-bar{margin-right: calc(100vw - calc(var(--NavbarWidth) * 1vw)) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}

          @media screen and (max-width:949px)    /*  The window is not enough wide for a one line layout  */
          {:root #nav-bar{padding: 0 5px 0 5px!important; height: calc(var(--NavbarHeightSmall) * 1px) !important} toolbarspring{display: none !important;} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}
          #nav-bar, #PersonalToolbar{background-color: #0000 !important;background-image: none !important; box-shadow: none !important} #nav-bar{margin-left: 3px;} .tab-background, .tab-stack { min-height: calc(var(--TabsHeight) * 1px) !important}

          /*  Removes urlbar border/background  */
          #urlbar-background {
            border: none !important;
            outline: none !important;
            transition: .15s !important;
          }

          /*  Removes the background from the urlbar while not in use  */
          #urlbar:not(:hover):not([breakout][breakout-extend]) > #urlbar-background {
            box-shadow: none !important;
            background: #0000 !important;
          }

          /*  Removes annoying border  */
          #navigator-toolbox {
            border: none !important
          }

          /* Fades window while not in focus */
          #navigator-toolbox-background:-moz-window-inactive {
            filter: contrast(90%)
          }

          /* Remove fullscreen warning border */
          #fullscreen-warning {
            border: none !important;
            background: -moz-Dialog !important;
          }

          /*  Tabs close button  */
          .tabbrowser-tab:not(:hover) .tab-close-button {
            opacity: 0% !important;
            transition: 0.3s !important;
            display: -moz-box !important;
          }
          .tab-close-button[selected]:not(:hover) {
            opacity: 45% !important;
            transition: 0.3s !important;
            display: -moz-box !important;
          }
          .tabbrowser-tab:hover .tab-close-button {
            opacity: 50%;
            transition: 0.3s !important;
            background: none !important;
            cursor: pointer;
            display: -moz-box !important;
          }
          .tab-close-button:hover {
            opacity: 100% !important;
            transition: 0.3s !important;
            background: none !important;
            cursor: pointer;
            display: -moz-box !important;
          }
          .tab-close-button[selected]:hover { opacity: 100% !important;
            transition: 0.3s !important;
            background: none !important;
            cursor: pointer;
            display: -moz-box !important;
          }
        '';
      };
    };
  };
}
