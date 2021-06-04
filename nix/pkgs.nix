{ ... }:

let
  cache_name = "losercache";
  sources = import ./sources.nix { inherit pkgs; };
  overlay = self: super: {
    #packages = self.callPackages ./packages.nix {};
    nodejs = super.nodejs-14_x;
    shell2cache = pkgs.writeScriptBin "shell2cache" ''
      nix-store --query --references $(nix-instantiate shell.nix) | xargs nix-store --realise | xargs nix-store --query --requisites | cachix push ${cache_name}
    '';
    rundocs = pkgs.writeScriptBin "rundocs" ''
      ${pkgs.nodePackages.nodemon}/bin/nodemon -e md -x ${pkgs.nodePackages.serve}/bin/serve ./docs -w ./docs
    '';
    inherit sources;
  };
  pkgs = import sources.nixpkgs {
    overlays = [ overlay ];
  };
in
  pkgs