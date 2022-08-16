{
  lib,
  stdenv,
  fetchFromGitHub,
  gnome-themes-extra,
  gtk-engine-murrine,
  gdk-pixbuf,
}:
stdenv.mkDerivation rec {
  pname = "tokyonight-gtk";
  version = "2022-08-11";

  src = fetchFromGitHub {
    owner = "stronk-dev";
    repo = "Tokyo-Night-Linux";
    rev = "4c0d6a67d050c3045b42b21082fbac108ce11a7a";
    sha256 = "z0xAgwYEsWctLwxzGGXcicMUrtXnKQYt9Huln5eav0w=";
  };

  buildInputs = [
    gdk-pixbuf
    gnome-themes-extra
  ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes
    cp -a usr/share/themes/TokyoNight $out/share/themes
  '';
}
