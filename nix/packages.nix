{ pkgs, lib }:

let
  packages = self: {
    nix-inclusive = pkgs.callPackage "${pkgs.sources.nix-inclusive}/inclusive.nix" {};
    yarn-ex = self.callPackage ./yarn-ex.nix { pkgs = pkgs; };
  };
in lib.makeScope pkgs.newScope packages