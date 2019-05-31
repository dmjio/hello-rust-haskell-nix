{ pkgs ? import <nixpkgs> {}
}:
let
  rust = import ./rust { inherit pkgs; };
  haskellPkg = pkgs.haskellPackages.callCabal2nix "haskell" ./haskell { inherit rust; };
in
  haskellPkg
