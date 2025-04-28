# https://github.com/oskardotglobal/.dotfiles/blob/nix/overlays/spotx.nix
final: prev: let
  spotx = prev.fetchurl {
    url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/21481cea97bac720590c2aad8b1fc2c58c9ec8f9/spotx.sh";
    hash = "sha256-1k1sEEnT1SE6RAWrfd1qFY1gFrUVNh7zUQJLu3DODlU=";
  };
in {
  spotify = prev.spotify.overrideAttrs (old: {
    nativeBuildInputs =
      (old.nativeBuildInputs or [])
      ++ (with prev; [
        util-linux
        perl
        unzip
        zip
        curl
      ]);

    unpackPhase =
      builtins.replaceStrings
      ["runHook postUnpack"]
      [
        ''
          patchShebangs --build ${spotx}
          runHook postUnpack
        ''
      ]
      (old.unpackPhase or "");

    installPhase =
      builtins.replaceStrings
      ["runHook postInstall"]
      [
        ''
          bash ${spotx} -f -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      (old.installPhase or "");
  });
}
