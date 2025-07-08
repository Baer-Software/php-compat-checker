#!/bin/bash

# Usage:
#   ./check-compatibility.sh [-r] [--log=output.log] [--exclude=pattern] <path> <php-version> [more-versions...]

usage() {
  echo "Usage: $0 [-r] [--log=output.log] [--exclude=pattern] <path> <php-version> [more-versions...]"
  echo
  echo "Options:"
  echo "  -r                   Recursively scan directories"
  echo "  --log=<file>         Save output to a log file"
  echo "  --exclude=<pattern>  Exclude files matching the pattern (can be used multiple times)"
  exit 1
}

# Defaults
RECURSIVE=0
LOGFILE=""
EXCLUDES=()

# Parse arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -r)
      RECURSIVE=1
      shift
      ;;
    --log=*)
      LOGFILE="${1#*=}"
      shift
      ;;
    --exclude=*)
      EXCLUDES+=("${1#*=}")
      shift
      ;;
    -*)
      echo "Unknown option: $1"
      usage
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

# Restore positional arguments
set -- "${POSITIONAL[@]}"

# Check required args
if [ $# -lt 2 ]; then
  usage
fi

CODE_PATH="$1"
shift
VERSIONS=("$@")

# Validate input path
if [ ! -e "$CODE_PATH" ]; then
  echo "❌ Error: Path '$CODE_PATH' does not exist."
  exit 1
fi

# Ensure dependencies
if [ ! -f "vendor/bin/phpcs" ]; then
  echo "📦 Installing dependencies..."
  composer install
fi

# Build file list
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

# Apply exclusions
for exclude in "${EXCLUDES[@]}"; do
  FILES=$(echo "$FILES" | grep -v "$exclude")
done

if [ -z "$FILES" ]; then
  echo "⚠️ No PHP files found after applying exclusions."
  exit 0
fi

# Run checks
echo "🔍 Checking PHP compatibility for: $CODE_PATH"
[ "$LOGFILE" != "" ] && echo "" > "$LOGFILE"

for version in "${VERSIONS[@]}"; do
  echo "➡ PHP $version"
  if [ "$LOGFILE" != "" ]; then
    {
      echo "➡ PHP $version"
      vendor/bin/phpcs -p --standard=PHPCompatibility --runtime-set testVersion "$version" $FILES
      echo ""
    } >> "$LOGFILE"
  else
    vendor/bin/phpcs -p --standard=PHPCompatibility --runtime-set testVersion "$version" $FILES
    echo ""
  fi
done

[ "$LOGFILE" != "" ] && echo "✅ Results written to $LOGFILE"
