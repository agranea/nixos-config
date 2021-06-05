{ pkgs, ... }:
pkgs.yarn2nix-moretea.mkYarnWorkspace {
  src = ../pkgs/yarn-ex;
  buildPhase = ''
    yarn build
  '';
}