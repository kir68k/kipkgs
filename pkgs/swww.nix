{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  libxkbcommon,
  lz4,
  rustfmt,
}:
rustPlatform.buildRustPackage rec {
  pname = "swww";
  version = "v0.4.2";

  src = fetchFromGitHub {
    owner = "Horus645";
    repo = pname;
    rev = version;
    sha512 = "7mesT1Vymh6kOKaXX5x5q8EDEkR/rUNTO5vYDRTnXb3ylwk9bVzWoKBNIoEewb9ZjknGCD9VgPFqwIpLLsiTxw==";
  };

  cargoSha256 = "MtTKyvq+romp516GYk2p0obhdZjG1+/Cbt42qhaJFxI=";

  nativeBuildInputs = [pkg-config rustfmt];

  buildInputs = [
    libxkbcommon
    lz4
  ];

  # swww has tests to see if the command works, if for whatever reason it doesn't
  # But, at least inside the Nix environment, it can't create a socket and the build fails due to error
  # I don't know how much these tests are needed, command seems to work without them... (2022-08-27)
  postPatch = ''
    substituteInPlace Cargo.toml \
    --replace '[[test]]' "" \
    --replace 'name = "integration_tests"' "" \
    --replace 'harness = false' ""
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/x86_64-unknown-linux-gnu/release/swww $out/bin
  '';

  meta = with lib; {
    description = "A Solution to your Wayland Wallpaper Woes";
    homepage = "https://github.com/${src.owner}/${pname}";
    license = licenses.gpl3;
    platforms = ["x86_64-linux"];
  };
}
