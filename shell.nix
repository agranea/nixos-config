{ ... }:
let 
  sources = import ./nix/sources.nix;
  pkgs = import ./nix/pkgs.nix {};
in 
  pkgs.mkShell {
    buildInputs = with pkgs; [ 
      git
      ansible
      gnumake
      fd
      # packages.yarn-ex
      nixfmt
      niv
      direnv
      ripgrep
      shell2cache
      nodejs
      rundocs
      yarn
    ];
}