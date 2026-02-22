#!/bin/bash
set -euo pipefail

# Only run in remote (cloud) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Ensure C++ build tools and linter are installed
if ! command -v g++ &>/dev/null || ! command -v clang-tidy &>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y g++ clang-tidy
fi
