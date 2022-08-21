{
  stdenv,
  lib,
  pkg-config,
  libsodium,
  gnumake,
  autoconf,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "mkp224o";
  version = "v1.6.1";

  src = fetchFromGitHub {
    owner = "cathugger";
    repo = pname;
    rev = version;
    sha512 = "RW7dIIFEwdm03TZYzMzqyEvHbiOtda+r5N2pzSL9GXw+AgNt+Ik7EQDcYA0sX+RTmBa3jsCYOv6tA/ReF0z0+A==";
  };

  buildInputs = [
    libsodium
    pkg-config
    gnumake
    autoconf
  ];

  configurePhase = ''
    ./autogen.sh
    ./configure
  '';
  buildPhase = ''
    make
  '';
  installPhase = ''
    cp mkp224o $out
  '';

  meta = with lib; {
    description = "Vanity address generator for tor onion v3 (ed25519) hidden services";
    homepage = "https://github.com/${src.owner}/${pname}";
    license = licenses.cc0;
    platforms = platforms.unix;
    mainProgram = "mkp224o";
  };
}
