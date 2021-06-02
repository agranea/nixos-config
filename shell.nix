{ ... }:
let 
  cache_name = "losercache";
  pkgs = import sources.nixpkgs {};
  shell2cache = pkgs.writeScriptBin "shell2cache" ''
    nix-store --query --references $(nix-instantiate shell.nix) | xargs nix-store --realise | xargs nix-store --query --requisites | cachix push ${cache_name}
  '';
in 
  pkgs.mkShell {
    buildInputs = with pkgs; [ 
      git
      ansible
      gnumake
      terraform
      terragrunt
      packer
      fd
      packages.yarn-ex
      nixfmt
      niv
      lorri
      direnv
      tflint
      ripgrep
      opam2nix
      shell2cache
      nodejs
    ];
}