#!/usr/bin/env sh

SOURCE_DIR=$(dirname "$0")
TEMPLATES_DIR="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_DIR="$TEMPLATES_DIR/File Templates"
EXPECTA_TEMPLATES_DIR="$FILE_TEMPLATES_DIR/Expecta Templates"

echo "Installing templates to $EXPECTA_TEMPLATES_DIR"
mkdir -p "$EXPECTA_TEMPLATES_DIR"
cp -R "$SOURCE_DIR/Expecta.xctemplate" "$EXPECTA_TEMPLATES_DIR"
echo "Finished"
