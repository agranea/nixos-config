{ ... }:
let 
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in 
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ ansible gnumake terraform terragrunt packer fd nixfmt niv lorri direnv tflint ];
    shellHook = ''
        export MACHINE="tjens"
    '';
}