{
  stdenv,
  cmake,
  glfw,
  freetype,
  fetchFromGitHub,
  xorg,
}:
stdenv.mkDerivation (self: {
  pname = "rmlui";
  version = "5.1";

  src = fetchFromGitHub {
    owner = "mikke89";
    repo = "RmlUi";
    rev = "${self.version}";
    sha256 = "sha256-sjQ6NBFejz/EjpmslSqVSRHqz8VNOOmdWYDQbY2H9uc=";
  };

  enableParalleBuilding = true;
  strictDeps = true;

  nativeBuildInputs = [cmake];

  buildInputs = [xorg.libX11 freetype];

  propagatedBuildInputs = [glfw];

  postInstall = ''
    mkdir -p $out/lib/pkgconfig
    mkdir -p $out/include

    cp -r $src/Backends $out/include/RmlUi

    substitute \
    	${./rmlui.pc} \
    	$out/lib/pkgconfig/rmlui.pc \
    	--subst-var out \
    	--subst-var version
  '';
})
