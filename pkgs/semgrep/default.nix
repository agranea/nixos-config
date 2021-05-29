let 
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  semgrep_src = pkgs.fetchFromGitHub {
      owner = "returntocorp";
      repo = "semgrep";
      rev = "280758e2f3818a9394f9f5c21f7c700549024007";
      sha256 = "0s46h49gn539s6bfn5pdkpbzbz42psiggp573m9xdiih1ynjn8fd";
  };
in 
with pkgs;

stdenv.mkDerivation {
  name = "semgrep";
  src = semgrep_src;
  buildInputs = [ python3 opam dune_2 ocaml ocamlPackages.ppx_deriving ocamlPackages.atdgen ocamlPackages.cmdliner ocamlPackages.alcotest ];
  buildPhase = ''
    make
  '';
}