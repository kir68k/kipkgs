self: super:
with super; rec {
  tokyonight-gtk = callPackage ./tokyonight-gtk.nix {};
  tokyonight-kvantum = callPackage ./tokyonight-kvantum.nix {};
  nerdfetch = callPackage ./nerdfetch.nix {};
  spotify-adblock = callPackage ./spotify-adblock.nix {};
  spotify-deb = callPackage ./spotify-deb.nix {};
}
