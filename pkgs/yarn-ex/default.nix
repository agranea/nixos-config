let 
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {}; 
  inherit (pkgs.yarn2nix-moretea) mkYarnWorkspace;
in
mkYarnWorkspace {
    src = ./.;
}
