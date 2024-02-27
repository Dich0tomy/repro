{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {
        pkgs,
        inputs',
        system,
        ...
      }: let
        buildDeps = [pkgs.fmt];
        nativeDeps = [pkgs.cmake pkgs.pkg-config];
      in {
        formatter = pkgs.alejandra;
        devShells = let
          baseDevShellAttrs = {
            hardeningDisable = ["all"];

            packages =
              nativeDeps
              ++ [
                pkgs.act
                pkgs.just
              ];

            buildInputs = buildDeps;
          };
        in {
          devGcc = pkgs.mkShell.override {stdenv = pkgs.gcc12.stdenv;} baseDevShellAttrs;
        };
      };
    };
}
