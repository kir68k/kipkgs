self: super:
with super; rec {
  tokyonight-gtk = callPackage ./tokyonight-gtk.nix {};
  tokyonight-kvantum = callPackage ./tokyonight-kvantum.nix {};
}
