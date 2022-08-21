self: super:
with super; rec {
  tokyonight-gtk =      callPackage ./tokyonight-gtk.nix {};
  tokyonight-kvantum =  callPackage ./tokyonight-kvantum.nix {};
  mkp224o =             callPackage ./mkp224o.nix {};
  nerdfetch =           callPackage ./nerdfetch.nix {};
  spotify-adblock =     callPackage ./spotify-adblock.nix {};
  spotify-deb =         callPackage ./spotify-deb.nix {};
}
