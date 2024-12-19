{
  description = "nokamute flake to setup everything";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nokamute = pkgs.callPackage ./default.nix { };
      in
      with pkgs;
      {
        packages.default = nokamute;

        devShells.default = mkShell rec {
          buildInputs = [
            cargo-make
            cargo
            clippy
          ] ++ nokamute.buildInputs; 
        };
      }
    );
}
