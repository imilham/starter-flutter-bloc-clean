#!/bin/bash
# ─── Firebase Config Copier ───
# Add this as a "Run Script" build phase in Xcode (Runner target),
# BEFORE the "Copy Bundle Resources" phase.
#
# Script: /bin/bash "$SRCROOT/scripts/copy_firebase_config.sh"
#
# Reads the flavor from flavor.xcconfig and copies the matching
# GoogleService-Info.plist into the Runner directory.

SRCROOT_DIR="${SRCROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
FLAVOR_FILE="$SRCROOT_DIR/Flutter/flavor.xcconfig"

# Default to sandbox if no flavor file exists
FLAVOR="sandbox"
if [ -f "$FLAVOR_FILE" ]; then
  # Extract the bundle ID to determine flavor
  BUNDLE_ID=$(grep "PRODUCT_BUNDLE_IDENTIFIER" "$FLAVOR_FILE" | cut -d'=' -f2 | tr -d ' ')
  if [ "$BUNDLE_ID" = "em.starter.app" ]; then
    FLAVOR="live"
  else
    FLAVOR="sandbox"
  fi
fi

PLIST_SRC="$SRCROOT_DIR/config/$FLAVOR/GoogleService-Info.plist"
PLIST_DEST="$SRCROOT_DIR/Runner/GoogleService-Info.plist"

if [ ! -f "$PLIST_SRC" ]; then
  echo "warning: GoogleService-Info.plist not found for flavor '$FLAVOR' at $PLIST_SRC"
  echo "warning: Firebase will not be configured. Add your plist to ios/config/$FLAVOR/"
  exit 0
fi

cp "$PLIST_SRC" "$PLIST_DEST"
echo "✓ Copied GoogleService-Info.plist for flavor: $FLAVOR"
