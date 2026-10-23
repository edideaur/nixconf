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
    rev = "8e9ea1699dd5a4f728c7cb0628373b5c3fe8e0e6";
    hash = "sha256-4qZ28qD9bOqR0m0a1f0a2b3c4d5e6f7a8b9c0d1e2f3=";
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
