{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    dire.url = "github:Dich0tomy/Dire";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (
      { flake-parts-lib, ... }: {
        systems = ["x86_64-linux" "aarch64-linux"];
        perSystem = {pkgs, inputs', ...}: let
        in {
          formatter = pkgs.alejandra;

          devShells.default = pkgs.mkShell.override {stdenv = pkgs.llvmPackages_17.stdenv;} {
            hardeningDisable = ["all"];

            packages = [
              pkgs.meson
              pkgs.cmake
              pkgs.ninja
              pkgs.pkg-config

							pkgs.fmt

              inputs'.dire.packages.dev
            ];
          };
        };
      }
    );
}
