{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (
      {
        flake-parts-lib,
        withSystem,
        ...
      }: {
        systems = ["x86_64-linux"];
        perSystem = {pkgs, ...}: let
          libdwarf = pkgs.stdenv.mkDerivation rec {
            pname = "libdwarf";
            version = "0.9.2";

            configureFlags = ["--enable-shared" "--disable-nonshared"];

            src = pkgs.fetchFromGitHub {
              owner = "davea42";
              repo = "libdwarf-code";
              rev = "v${version}";
              sha256 = "sha256-z5JIf8Qybu1IiuQeFjPvrh8b22l/RagYZRPJRv6rBws=";
            };

            cmakeBuildType = "debug";

            nativeBuildInputs = [
              pkgs.cmake
            ];

            buildInputs = [
              pkgs.zlib.dev
            ];
          };
          cpptrace = pkgs.stdenv.mkDerivation rec {
            pname = "cpptrace";
            version = "0.5.4";

            src = pkgs.fetchFromGitHub {
              owner = "jeremy-rifkin";
              repo = "cpptrace";
              rev = "v${version}";
              sha256 = "sha256-ZNYIXl+rM7uTBTj2S7jcuJNnVypwyH1lryDaWefREm4=";
            };

            cmakeBuildType = "debug";

            cmakeFlags = [
              "-DCPPTRACE_USE_EXTERNAL_LIBDWARF=1"
              "-DCPPTRACE_USE_EXTERNAL_ZSTD=1"
            ];

            nativeBuildInputs = [
              pkgs.cmake
            ];

            buildInputs = [
              pkgs.zstd.dev
              pkgs.zlib.dev
              libdwarf
            ];

            postInstall = ''
              mkdir -p $out/lib/pkgconfig
              substituteAll ${./pkg-config/cpptrace.pc} $out/lib/pkgconfig/cpptrace.pc
            '';
          };
        in {
          formatter = pkgs.alejandra;

          packages.libdwarf = libdwarf;

          packages.default = pkgs.stdenv.mkDerivation {
            pname = "repro";
            version = "0.1.0";

            src = ./.;

            nativeBuildInputs = [
              pkgs.meson
              pkgs.cmake
              pkgs.ninja
              pkgs.pkg-config
            ];

            buildInputs = [
              cpptrace
            ];
          };

          devShells.default = pkgs.mkShell.override {stdenv = pkgs.llvmPackages_17.stdenv;} {
            hardeningDisable = ["all"];

            packages = [
              cpptrace
              pkgs.meson
              pkgs.cmake
              pkgs.ninja
              pkgs.pkg-config
            ];
          };
        };
      }
    );
}
