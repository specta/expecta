#!/usr/bin/env sh

TEMPLATES_DIR="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATES_DIR="$TEMPLATES_DIR/File Templates"
EXPECTA_TEMPLATES_DIR="$FILE_TEMPLATES_DIR/Expecta Templates"
echo "Removing $EXPECTA_TEMPLATES_DIR"
rm -rf "$EXPECTA_TEMPLATES_DIR"
echo "Finished"
