let
	sources = import ./npins;
	pkgs = import sources.nixpkgs {};
in
	pkgs.mkShell.override {stdenv = pkgs.gcc14Stdenv;} {
		hardeningDisable = ["all"];

		packages = [
			pkgs.fmt
			pkgs.drogon

			pkgs.cmake
			pkgs.ninja
			pkgs.pkg-config
		];
	}
