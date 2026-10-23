{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  cairo,
  gtksourceview3,
  pango,
  fontconfig,
  tinyxml-2,
  gtkmm3,
  gtksourceviewmm,
}:

stdenv.mkDerivation rec {
  pname = "microtex";
  version = "unstable-2024-05-01";

  src = fetchFromGitHub {
    owner = "NanoMichael";
    repo = "MicroTeX";
    rev = "0e3707f6dafebb121d98b53c64364d16fefe481d";
    hash = "sha256-U6zqh+VqoLtlE0IwgfwjY9zt8e5/2R3cqf5fWXwoIi0=";
  };

  postPatch = ''
    substituteInPlace src/platform/cairo/graphic_cairo.cpp \
      --replace-fail '#include <fontconfig/fontconfig.h>' '#include <fontconfig/fontconfig.h>
#include <fontconfig/fcfreetype.h>'
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    cairo
    gtksourceview3
    pango
    fontconfig
    tinyxml-2
    gtkmm3
    gtksourceviewmm
  ];

  meta = with lib; {
    description = "A dynamic, cross-platform, and embeddable LaTeX rendering library";
    homepage = "https://github.com/NanoMichael/MicroTeX";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
