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
    sha256 = "wYSS2IaIRVxA3fFMlYV6fERNxqpTd5k9npk5FBpgNLY=";
  };

  installPhase = ''
    mkdir -p $out/share/Kvantum/TokyoNight
    cp -a KvArcTokyoNight.kvconfig $out/share/Kvantum/TokyoNight/TokyoNight.kvconfig
    cp -a KvArcTokyoNight.svg $out/share/Kvantum/TokyoNight/TokyoNight.svg
  '';
}
