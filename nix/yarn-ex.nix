{ pkgs, ... }:
pkgs.yarn2nix-moretea.mkYarnWorkspace {
  src = ../pkgs/yarn-ex;
  buildPhase = ''
    yarn build
  '';
  packageOverrides = {
    agra-friend = {
      distPhase = ''
        mv $out/libexec/@agra/friend/deps/@agra/friend/dist $out
        rm -rf $out/libexec
        rm -rf $out/bin
        pushd $out
        ${pkgs.zip}/bin/zip release.zip dist/
        rm -rf $out/dist
        popd
      '';
    };
  };
}