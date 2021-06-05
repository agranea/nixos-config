{ pkgs, ... }:
let
  dist-for-pkg = name: ''
    mv $out/libexec/${name}/deps/${name}/dist $out
    rm -rf $out/libexec
    rm -rf $out/bin
    pushd $out
    ${pkgs.zip}/bin/zip release.zip dist/
    rm -rf $out/dist
    popd
  '';
in
pkgs.yarn2nix-moretea.mkYarnWorkspace {
  src = ../pkgs/yarn-ex;
  buildPhase = ''
    yarn build
  '';
  packageOverrides = {
    agra-friend = {
      #distPhase = dist-for-pkg "@agra/friend";
      buildPhase = ''
        cp -r $src/* .
        ${pkgs.tree}/bin/tree -L 4 .
        ${pkgs.esbuild}/bin/esbuild ./src/index.ts --bundle --platform=node --outdir=$out
      '';
    };
  };
}