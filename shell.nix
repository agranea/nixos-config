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
      nixfmt
      niv
      direnv
      ripgrep
      shell2cache
      nodejs
      rundocs
      yarn
      lorri
    ];
    shellHook = ''
      echo "${pkgs.packages.yarn-ex.agra-friend}"
    '';
}