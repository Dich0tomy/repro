{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ { ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {
        pkgs,
        inputs',
        system,
        lib,
        self',
        ...
      }: let
        buildDeps = [ pkgs.fmt ];
        nativeDeps = [ pkgs.cmake pkgs.pkg-config ];

        rootDir = ./.;
      in {
        devShells = import ./nix/shell.nix {
          inherit pkgs buildDeps nativeDeps;
        };
      };
    };
}
