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
    hash = "sha256-k0kUfD7n4q7Puh1R5ZfV5O2K6tD1Z4n2jY4v2g4f8q0=";
  };

  cargoLock = {
    lockFile = null;
    outputHashes = { };
  };

  doCheck = false;

  meta = with lib; {
    description = "Extremely fast rm replacement written in Rust";
    homepage = "https://github.com/tekacs/fast-rm";
    license = licenses.mit;
    mainProgram = "fast-rm";
  };
}
