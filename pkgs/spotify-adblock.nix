{
  lib,
  fetchFromGitHub,
  rustPlatform,
  gnumake,
  spotify-unwrapped,
  makeDesktopItem,
  autoPatchelfHook,
  self,
}:
rustPlatform.buildRustPackage rec {
  pname = "spotify-adblock";
  version = "v1.0.2";

  src = fetchFromGitHub {
    owner = "abba23";
    repo = pname;
    rev = version;
    sha256 = "YGD3ymBZ2yT3vrcPRS9YXcljGNczJ1vCvAXz/k16r9Y=";
  };

  cargoSha256 = "28PQ3fsdqc8bWH3XfOW9QxYM/yN5F1lpYx9VpAvlbQA=";

  nativeBuildInputs = [
    autoPatchelfHook
    gnumake
  ];

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/etc/${pname}
    install -D --mode=644 --strip target/x86_64-unknown-linux-gnu/release/libspotifyadblock.so $out/lib/${pname}.so
    install -D --mode=644 config.toml $out/etc/${pname}/config.toml
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "spotify-adblock";
      desktopName = "Spotify (Adblock)";
      genericName = "Music player";
      exec = "env LD_LIBRARY_PATH=${spotify-unwrapped}/lib/spotify LD_PRELOAD=${self}/lib/libspotifyadblock.so ${spotify-unwrapped}/bin/spotify %U";
      terminal = false;
      categories = ["Audio" "Music" "Player" "AudioVideo"];
    })
  ];

  meta = with lib; {
    description = "Preloaded library which blocks spotify's ad domains, effectively blocking any ads";
    homepage = "https://github.com/${src.owner}/${pname}";
    license = licenses.gpl3;
    platforms = ["x86_64-linux"];
    architectures = ["amd64" "x86"];
  };
}
