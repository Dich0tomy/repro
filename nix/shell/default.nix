{pkgs, ...}: {
  devShells.default = pkgs.mkShell.override {stdenv = pkgs.llvmPackages_17.stdenv;} {
    hardeningDisable = ["all"];
    packages = [
      pkgs.just
      pkgs.meson
      pkgs.cmake
      pkgs.ninja
      pkgs.pkg-config
      pkgs.rmlui

      # Why do I even have to specify glfw3?
      pkgs.glfw
    ];
  };
}
