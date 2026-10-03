{
  bash,
  lib,
  src,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "tela-circle-icon-theme";
  version = "unstable";

  inherit src;

  nativeBuildInputs = [bash];

  # The upstream theme ships a few optional aliases whose targets are absent
  # from the standard variant. Keep the upstream layout intact.
  dontCheckForBrokenSymlinks = true;

  installPhase = ''
    runHook preInstall

    # The upstream default is the standard folder variant. We deliberately do
    # not pass -c, which selects the circular folder variant.
    sed -i '/gtk-update-icon-cache/d' install.sh
    bash ./install.sh -d "$out/share/icons" standard

    runHook postInstall
  '';

  meta = {
    description = "Tela icon theme with standard (non-circular) folder icons";
    homepage = "https://github.com/vinceliuice/Tela-circle-icon-theme";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
