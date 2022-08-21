{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
}:
stdenvNoCC.mkDerivation rec {
  pname = "nerdfetch";
  version = "2022-05-21";

  src = fetchFromGitHub {
    owner = "ThatOneCalculator";
    repo = "NerdFetch";
    rev = "d8fc087b949206c880effe86555badacf8d435ea";
    sha512 = "dEkxBx5t+bD9RBa75KGE1RiE37lCH7femr4Toept56dPLtupU9f0aqLbpPkLGIbdvpz7IbybKNWhiMdR6rr6Xg==";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp nerdfetch $out/bin
  '';

  meta = with lib; {
    description = "A POSIX *nix fetch script using NerdFonts";
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = licenses.mit;
    platforms = platforms.unix;
    mainProgram = "nerdfetch";
  };
}
