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

# Ensure Flutter SDK is installed
if ! command -v flutter &>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y curl git unzip xz-utils
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 /home/user/flutter
  echo 'export PATH="/home/user/flutter/bin:$PATH"' >> "$CLAUDE_ENV_FILE"
  export PATH="/home/user/flutter/bin:$PATH"
  flutter precache
  dart --disable-analytics
  flutter --disable-analytics
fi
