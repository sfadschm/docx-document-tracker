#!/bin/bash

# Setup script error handling
set -euo pipefail

# Get directory link
thisdir=$(dirname $(readlink -f "$0"))

# Enable pandoc for .docx diffs if installed
command -v "pandoc" >/dev/null 2>&1
if [[ ! $? -ne 0 ]]; then
  echo "Add local configuration for diffing with pandoc..."
  git config --local diff.pandoc.textconv "pandoc --to=markdown"
  git config --local diff.pandoc.prompt "false"
  git config --local diff.pandoc.binary "true"
else
  echo "Cannot find 'pandoc'. Run this script again after"
  echo "installing pandoc to enable diffs for .docx files."
fi

# Enable pdf2txt.py for .pdf diffs
echo "Add local configuration for diffing with pdf2txt..."
git config --local diff.pdf.textconv "pdf2txt.py"
git config --local diff.pdf.binary "true"

# Rebase the hook lookup directory
echo "Relink the git hook lookup path..."
git config --local core.hooksPath "hooks"

# Exit on user confirmation
echo
read -p "Press enter to close."
exit 0