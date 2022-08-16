self: super:
with super; rec {
  tokyonight-gtk = callPackage ./tokyonight-gtk.nix {};
  tokyonight-kvantum = callpackge ./tokyonight-kvantum.nix {};
}
