{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      overlays = [
        (_: prev: {
          rmlui = prev.callPackage ./rmlui {};
        })
      ];
    };
  };
}
