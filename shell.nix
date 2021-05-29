{ ... }:
let 
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  opam2nix = import sources.opam2nix {};
in 
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ cachix ansible gnumake terraform terragrunt packer fd nixfmt niv lorri direnv tflint ripgrep opam2nix ];
    shellHook = ''
        export MACHINE="tjens"
        cachix use losercache
    '';
}