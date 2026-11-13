# run-vm-windows.ps1 - Build and launch the NixOS QEMU VM from Windows via WSL2
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$wslPath = (wsl wslpath -a "$scriptDir").Trim()

if (-not $wslPath) {
    throw "Could not translate the repository path to a WSL path. Is WSL2 installed?"
}

Write-Host "==> Repository (WSL): $wslPath"
Write-Host "==> Building and launching VM inside WSL2..."
wsl bash -lc "cd '$wslPath' && ./run-vm.sh"
