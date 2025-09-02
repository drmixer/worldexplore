#!/usr/bin/env bash
set -euo pipefail

# Install Rokit (Roblox toolchain manager) and Rojo
if ! command -v rokit >/dev/null 2>&1; then
  curl -sSf https://raw.githubusercontent.com/rojo-rbx/rokit/main/scripts/install.sh | bash
fi

echo 'export PATH="$HOME/.rokit/bin:$PATH"' >> "$HOME/.bashrc"
export PATH="$HOME/.rokit/bin:$PATH"

# Initialize a rokit toolchain for this repo and install Rojo
rokit init || true
rokit add rojo-rbx/rojo@7.5.1
rokit install

echo "✅ Rokit & Rojo installed:"
rojo --version || true

# Make a build dir
mkdir -p build
