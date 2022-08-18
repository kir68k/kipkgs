{
  lib,
  stdenv,
  dpkg,
  gcc-unwrapped,
  fetchurl,
  xorg,
  xwayland,
  alsa-lib,
  makeWrapper,
  autoPatchelfHook,
  wrapGAppsHook,
  openssl,
  freetype,
  binutils,
  glib,
  pango,
  cairo,
  atk,
  gdk-pixbuf,
  gtk3,
  cups,
  nspr,
  nss,
  libpng,
  libnotify,
  libgcrypt,
  systemd,
  fontconfig,
  dbus,
  glibc,
  expat,
  ffmpeg,
  curlWithGnuTls,
  zlib,
  gnome,
  at-spi2-atk,
  at-spi2-core,
  libpulseaudio,
  libdrm,
  mesa,
  libxkbcommon,
  callPackage,
  commandLineArgs ? "",
  spotify-adblock ? (callPackage ./spotify-adblock.nix {}),
}: let
  version = "1.1.84.716.gc5f8b819";
in
  stdenv.mkDerivation rec {
    pname = "spotify-deb";
    inherit version;

    src = fetchurl {
      url = "http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_${version}_amd64.deb";
      sha512 = "2chvxc1ww7bgss63657iwlszqvrj09y9wrb9jcm0y2n09bm3kf6nxlpvvyl4qha062y1b7hb27fs0zqd3v5syhi0xkc46krmql5zhiw";
    };

    nativeBuildInputs = [autoPatchelfHook makeWrapper dpkg];

    buildInputs = [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curlWithGnuTls
      dbus
      expat
      ffmpeg
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libgcrypt
      libnotify
      libpng
      libpulseaudio
      libxkbcommon
      mesa
      nss
      pango
      stdenv.cc.cc
      systemd
      xwayland
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libxshmfence
      xorg.libXtst
    ];

    #dontStrip = true;
    #dontWrapGApps = true;

    unpackPhase = "true";

    installPhase = ''
      runHook preInstall

      libdir=$out/lib/spotify
      mkdir -p $out
      mkdir -p $libdir
      dpkg -x $src $out
      cp -av $out/usr/* $out/
      rm -rf $out/usr

      ln -s ${lib.getLib openssl}/lib/libssl.so $libdir/libssl.so.1.0.0
      ln -s ${lib.getLib openssl}/lib/libcrypto.so $libdir/libcrypto.so.1.0.0
      ln -s ${nspr.out}/lib/libnspr4.so $libdir/libnspr4.so
      ln -s ${nspr.out}/lib/libplc4.so $libdir/libplc4.so

      rpath="$out/share/spotify:$libdir"

      #patchelf \
      #  --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      #  --set-rpath $rpath $out/share/spotify/spotify

      librarypath="${lib.makeLibraryPath buildInputs}:$libdir"
      wrapProgram  $out/share/spotify/spotify \
        ''${gappsWrapperArgs[@]} \
        --prefix LD_PRELOAD : "${spotify-adblock.out}/lib/spotify-adblock.so" \
        --prefix LD_LIBRARY_PATH : "$librarypath" \
        --prefix PATH : "${gnome.zenity}/bin"

      sed -i "s:^Icon=.*:Icon=spotify-client:" "$out/share/spotify/spotify.desktop"

      mkdir -p $out/share/applications
      cp $out/share/spotify/spotify.desktop $out/share/applications/

      for i in 16 22 24 32 48 64 128 256 512; do
        ixi="$i"x"$i"
        mkdir -p $out/share/icons/hicolor/$ixi/apps
        ln -s $out/share/spotify/icons/spotify-linux-$i.png \
          $out/share/icons/hicolor/$ixi/apps/spotify-client.png
      done

      runHook postInstall
    '';

    meta = with lib; {
      description = "Proprietary music service [DEBIAN PACKAGE]";
      homepage = "https://www.spotify.com/";
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      license = licenses.unfree;
    };
  }
