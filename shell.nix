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
  
   shellHook
    = ''
      echo "Agranea"
      echo "NOTE: you may need to export GITHUB_TOKEN if you hit rate limits with niv"
      echo "Commands:
        * niv update <package> - update package
        * persistgraphql <src> allowList.json - generates an allowList.json to limit graphql queries
        * export GOPATH="\$\(pwd\)/.go" - enable vgo2nix to use the pwd as it's source
        * node2nix -l - update node packages, -l if there's a lock file
      "
    '';
}