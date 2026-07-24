#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -f audio/clear_spanish_*.wav audio/clear_spanish_*.aiff
echo "Old Spanish audio removed."
echo "Now double-click START_APP.command to regenerate it."
read -p "Press Return to close..."
