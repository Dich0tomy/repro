{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;

      perSystem = {
        pkgs,
        system,
        self',
        ...
      }: {
        formatter = pkgs.alejandra;

        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [(_: prev: {rmlui = prev.callPackage ./nix/rmlui {};})];
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "repro";
          version = "0.1.0";

          src = builtins.path {
            path = ./.;
            name = "repro";
          };

          nativeBuildInputs = [
            pkgs.meson
            pkgs.cmake
            pkgs.ninja
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.rmlui
            pkgs.xorg.libX11
            pkgs.freetype
            pkgs.glfw
          ];

          installPhase = ''
            mkdir -p $out/bin
            cp repro $out/bin
          '';
        };

        devShells.default = pkgs.mkShell.override {stdenv = pkgs.llvmPackages_17.stdenv;} {
          hardeningDisable = ["all"];
          inputsFrom = [self'.packages.default];
        };
      };
    };
}
