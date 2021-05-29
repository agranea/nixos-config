{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ ansible gnumake terraform terragrunt packer ];
    shellHook = ''
        export MACHINE="tjens"
    '';
}