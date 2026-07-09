{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    dire.url = "github:Dich0tomy/Dire";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (
      {flake-parts-lib, ...}: {
        systems = ["x86_64-linux" "aarch64-linux"];
        perSystem = {
          pkgs,
          inputs',
          ...
        }: let
        in {
          formatter = pkgs.alejandra;

          packages.default = pkgs.stdenv.mkDerivation {
            pname = "repro";
            version = "0.1.0";

            src = ./.;

            nativeBuildInputs = [
            	pkgs.cmake pkgs.meson pkgs.pkg-config pkgs.ninja
            ];

            buildInputs = [
            pkgs.fmt
            	inputs'.dire.packages.dev
            ];

            configurePhase = ''
              meson setup build
            '';
            buildPhase = ''
              meson compile -C build
            '';
          };

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
