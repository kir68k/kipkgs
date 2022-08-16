{
  description = "Ki's personal package collection";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    kipkgs = self.packages.${system};
  in {
    devShells.${system} = import ./shells {
      inherit pkgs;
    };

    packages.${system} = ((import ./pkgs) {} pkgs);

    overlays.default = final: prev: (import ./pkgs) final prev;
  };
}
