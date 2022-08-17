{ lib
, stdenvNoCC
, fetchFromGitHub
, makeWrapper
}:

stdenvNoCC.mkDerivation rec {
  pname = "nerdfetch";
  version = "2022-05-21";

  src = fetchFromGitHub {
    owner = "ThatOneCalculator";
    repo = "NerdFetch";
    rev = "d8fc087b949206c880effe86555badacf8d435ea";
    sha256 = "d5d+e1cd2h+W+pbYMdubipFPvv/06PzPMGVLkGK+pGA=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp nerdfetch $out/bin
  '';

  meta = with lib; {
    description = "A POSIX *nix fetch script using NerdFonts";
    homepage = "https://github.com/ThatOneCalculator/NerdFetch";
    license = "The BASED License";
    platforms = platforms.all; # Assuming that this works on Mac
    mainProgram = "nerdfetch";
  };
}
