{
  lib,
  stdenv,
  fetchFromGitHub,
  inter,
  nerd-font-patcher,
}:
stdenv.mkDerivation {
  pname = "inter-nerd-font";
  version = inter.version;

  src = inter;

  nativeBuildInputs = [nerd-font-patcher];

  buildPhase = ''
    find $src/share/fonts/opentype -name '*.otf' -print0 | xargs -0 -I{} \
      nerd-font-patcher --complete --careful --outputdir . {}
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp *Nerd*Font*.otf $out/share/fonts/opentype/
  '';

  meta = with lib; {
    description = "Inter font patched with Nerd Fonts symbols";
    homepage = "https://rsms.me/inter/";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
