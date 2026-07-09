{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs }: {
		formatter = pkgs.x86_64-linux.nixfmt-tree;

		devShells.x86_64-linux.default = pkgs.mkShell.override {stdenv = pkgs.useMoldLinker pkgs.gcc14Stdenv;} {
			hardeningDisable = ["all"];
			nativeBuildInputs = [pkgs.cmake];
		};
	}
}
