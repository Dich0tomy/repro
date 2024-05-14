{
  outputs = {
    nixpkgs,
    parts,
    devenv,
    ...
  } @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.devenv.flakeModule ];

      perSystem = {
        pkgs,
        lib,
        ...
      }: {
				devenv.shells.default = {
					enterShell = "echo hello from devenv :)";
				};
      };
    };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
  };
}
