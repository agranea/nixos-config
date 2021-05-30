{ ... }:
let 
  cache_name = "losercache";
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  opam2nix = import sources.opam2nix {};
  shell2cache = pkgs.writeScriptBin "shell2cache" ''
    nix-store --query --references $(nix-instantiate shell.nix) | xargs nix-store --realise | xargs nix-store --query --requisites | cachix push ${cache_name}
  '';
in 
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ cachix ansible gnumake terraform terragrunt packer fd nixfmt niv lorri direnv tflint ripgrep opam2nix shell2cache ];
    shellHook = ''
        export MACHINE="tjens"
        cachix use ${cache_name}
    '';
}