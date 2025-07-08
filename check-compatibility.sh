#!/bin/bash

# Usage:
#   ./check-compatibility.sh [-r] <path-to-code> <php-version> [more-versions...]

# Helper: print usage
usage() {
  echo "Usage: $0 [-r] <path-to-code> <php-version> [more-versions...]"
  echo
  echo "Options:"
  echo "  -r    Recursively scan directories"
  exit 1
}

# Check if minimum arguments are provided
if [ $# -lt 2 ]; then
  usage
fi

# Defaults
RECURSIVE=0

# Handle -r flag
if [ "$1" == "-r" ]; then
  RECURSIVE=1
  shift
fi

# Get path and versions
CODE_PATH="$1"
shift
VERSIONS=("$@")

# Validate input path
if [ ! -e "$CODE_PATH" ]; then
  echo "❌ Error: Path '$CODE_PATH' does not exist."
  exit 1
fi

# Install dependencies if needed
if [ ! -f "vendor/bin/phpcs" ]; then
  echo "📦 Installing dependencies..."
  composer install
fi

# Prepare file list
if [ -f "$CODE_PATH" ]; then
  FILES="$CODE_PATH"
elif [ -d "$CODE_PATH" ]; then
  if [ "$RECURSIVE" -eq 1 ]; then
    FILES=$(find "$CODE_PATH" -type f -name "*.php")
  else
    FILES=$(find "$CODE_PATH" -maxdepth 1 -type f -name "*.php")
  fi
else
  echo "❌ Error: Invalid path '$CODE_PATH'"
  exit 1
fi

# Check each version
echo "🔍 Checking PHP compatibility for: $CODE_PATH"
echo

for version in "${VERSIONS[@]}"; do
  echo "➡ PHP $version"
  vendor/bin/phpcs -p --standard=PHPCompatibility --runtime-set testVersion "$version" $FILES
  echo
done
