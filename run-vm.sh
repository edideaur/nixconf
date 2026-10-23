#!/usr/bin/env bash
# run-vm.sh - Helper script to build and launch the NixOS QEMU VM
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "==> Ensuring Git tracks all configuration files..."
git add -A

export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

echo "==> Building NixOS QEMU VM..."
nix --extra-experimental-features "nix-command flakes" \
    --option ssl-cert-file /etc/ssl/certs/ca-certificates.crt \
    build .#nixosConfigurations.T14.config.system.build.vm

echo "==> Launching NixOS VM..."
./result/bin/run-T14-vm
