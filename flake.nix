{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable-pinned.url = "github:NixOS/nixpkgs/e58d02aeef744515d6055c99517a6d368b2686f2";

    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        pkgsUnstable = inputs.nixpkgs-unstable-pinned.legacyPackages.${system};
      in {
        devShells.default =
          pkgs.mkShell.override {
            stdenv = pkgs.gcc13Stdenv; # To compile with GCC
            #stdenv = pkgsUnstable.llvmPackages_17.libcxxStdenv; # To compile with Clang
          } {
            hardeningDisable = ["fortify"];

            packages = [
              pkgs.cmake
              (pkgs.clang-tools_17.override { enableLibcxx = true; })
            ];
          };
      };
    };
}
