{ ... }:

let
  sources = import ./sources.nix { inherit pkgs; };
  overlay = self: super: {
    packages = self.callPackages ./packages.nix {};
    nodejs = super.nodejs-14_x;
    inherit sources;
  };
  pkgs = import sources.nixpkgs {
    overlays = [ overlay ];
  };
in
  pkgs