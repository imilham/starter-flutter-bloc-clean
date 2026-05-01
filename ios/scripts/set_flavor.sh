#!/bin/bash
# ─── Flavor Config Resolver ───
# This script is called by the Xcode pre-action in each scheme.
# It copies the flavor-specific xcconfig into flavor.xcconfig so
# Debug.xcconfig / Release.xcconfig can #include it.
#
# Usage (Xcode scheme pre-action):
#   /bin/bash "$SRCROOT/scripts/set_flavor.sh" sandbox
#   /bin/bash "$SRCROOT/scripts/set_flavor.sh" live

FLAVOR="${1:-sandbox}"
SRCROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FLAVOR_FILE="$SRCROOT_DIR/Flutter/${FLAVOR}.xcconfig"
DEST_FILE="$SRCROOT_DIR/Flutter/flavor.xcconfig"

if [ ! -f "$FLAVOR_FILE" ]; then
  echo "error: Flavor xcconfig not found: $FLAVOR_FILE"
  exit 1
fi

cp "$FLAVOR_FILE" "$DEST_FILE"
echo "✓ Applied flavor: $FLAVOR"
