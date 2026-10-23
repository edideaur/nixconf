{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "fast-rm";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "tekacs";
    repo = "fast-rm";
    rev = "d605af0e68039effc3d5e86fe642eaa0f240e974";
    hash = "sha256-0p+rTeyg4CVBanLIxdTgJ+SO6A588ItZxjybaD1DvuE=";
  };

  cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  doCheck = false;

  meta = with lib; {
    description = "Extremely fast rm replacement written in Rust";
    homepage = "https://github.com/tekacs/fast-rm";
    license = licenses.mit;
    mainProgram = "fast-rm";
  };
}
