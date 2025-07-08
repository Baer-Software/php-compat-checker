#!/bin/bash

# Usage: ./check-compatibility.sh /path/to/code 7.4 8.0 8.1

if [ $# -lt 2 ]; then
  echo "Usage: $0 <path-to-code> <php-version> [more-versions...]"
  exit 1
fi

# Ensure composer dependencies are installed
if [ ! -f "vendor/bin/phpcs" ]; then
  echo "Installing dependencies..."
  composer install
fi

CODE_PATH="$1"
shift
VERSIONS=("$@")

echo "🔍 Checking PHP compatibility for: $CODE_PATH"
echo

for version in "${VERSIONS[@]}"; do
  echo "➡ PHP $version"
  vendor/bin/phpcs -p --standard=PHPCompatibility --runtime-set testVersion "$version" "$CODE_PATH"
  echo
done
