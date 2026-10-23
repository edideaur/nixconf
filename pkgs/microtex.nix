{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  cairo,
  gtksourceview4,
  pango,
  fontconfig,
}:

stdenv.mkDerivation rec {
  pname = "microtex";
  version = "unstable-2024-05-01";

  src = fetchFromGitHub {
    owner = "NanoMichael";
    repo = "MicroTeX";
    rev = "0e3707f6dafebb121d98b53c64364d16fefe481d";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    cairo
    gtksourceview4
    pango
    fontconfig
  ];

  meta = with lib; {
    description = "A dynamic, cross-platform, and embeddable LaTeX rendering library";
    homepage = "https://github.com/NanoMichael/MicroTeX";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
