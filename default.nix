let
	sources = import ./npins;
	pkgs = import sources.nixpkgs {};
in
	pkgs.stdenv.mkDerivation {
		pname = "repro";
		version = "0.1.0";

		src = builtins.path {
			path = ./.;
			name = "repro";
		};

		buildInputs = [
			pkgs.fmt
			(pkgs.drogon.overrideAttrs (_: { doInstallCheck = true; }))
		];

		configurePhase = "cmake -S . -B build";
		buildPhase = ''
			cmake --build build
		'';

		installPhase = ''
			mkdir -p $out/bin
			mv build/repro $out/bin
		'';

		nativeBuildInputs = [
			pkgs.gcc14
			pkgs.cmake
			pkgs.pkg-config
		];
 }
