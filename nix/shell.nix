{
  pkgs,
  nativeDeps,
  buildDeps,
  ...
}:

let baseDevShellAttrs = {
		hardeningDisable = ["all"];

		packages = nativeDeps ++ [
			pkgs.act
			pkgs.just
		];

		buildInputs = buildDeps;
};
in 
{
	devGcc = (pkgs.mkShell.override { stdenv = pkgs.gcc12.stdenv;  } baseDevShellAttrs);
}
