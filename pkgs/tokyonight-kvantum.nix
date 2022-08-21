{
  lib,
  stdenv,
  fetchFromGitLab,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "tokyonight-kvantum";
  version = "2022-06-03";

  src = fetchFromGitLab {
    owner = "ObsidianChickenz";
    repo = "kvantum-tokyo-night-theme";
    rev = "07e50353fdfca491a8b879c97d0c07482621eecc";
    sha512 = "1oiWBgoJuhxNOcKUGH+PQ5okE3MJer0ahceiSOn8DMcS76wXUIqILUjCbO3Vp8ShO5/UyEayNeLg1mIThejgYw==";
  };

  installPhase = ''
    mkdir -p $out/share/Kvantum/TokyoNight
    cp -a KvArcTokyoNight.kvconfig $out/share/Kvantum/TokyoNight/TokyoNight.kvconfig
    cp -a KvArcTokyoNight.svg $out/share/Kvantum/TokyoNight/TokyoNight.svg
  '';

  meta = with lib; {
    description = "TokyoNight theme for the Kvantum engine // Qt5";
    homepage = "https://gitlab.com/${src.owner}/${src.repo}/";
    license = licenses.gpl3;
    platforms = platforms.unix; # Not for mac but I assume this works fine on *BSD
  };
}
