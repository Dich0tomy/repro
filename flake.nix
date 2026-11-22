{
  description = "repro";

  outputs =
    { nixpkgs, self }:
    let
      systems = [ "x86_64-linux" ];
      eachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      formatter = eachSystem (pkgs: pkgs.nixfmt-tree);

      devShells = eachSystem (
        pkgs:
        let
          llvm = pkgs.llvmPackages_23;
        in
        {
          default = pkgs.mkShell.override { stdenv = pkgs.useMoldLinker llvm.stdenv; } {
            hardeningDisable = [ "all" ];

            nativeBuildInputs = [
              pkgs.cmake
              pkgs.ninja
              pkgs.pkg-config

              pkgs.postgresql_19
            ];
          };
        }
      );
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
}
