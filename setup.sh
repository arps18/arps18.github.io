#!/usr/bin/env bash
# setup.sh — One-shot setup for Arpan Patel's Hugo portfolio
# Run this from inside the arpan-portfolio/ directory

set -e

echo "🚀 Setting up Arpan Patel's portfolio website..."
echo ""

# Check Hugo is installed
if ! command -v hugo &> /dev/null; then
    echo "❌ Hugo is not installed."
    echo ""
    echo "Install it first:"
    echo "  macOS:   brew install hugo"
    echo "  Linux:   sudo snap install hugo"
    echo "  Windows: choco install hugo-extended"
    echo ""
    echo "Make sure you install the EXTENDED version (required by PaperMod)."
    exit 1
fi

# Check Hugo version is extended
if ! hugo version | grep -q "extended"; then
    echo "⚠️  You have Hugo installed but not the EXTENDED version."
    echo "PaperMod requires hugo-extended. Please reinstall."
    exit 1
fi

echo "✅ Hugo $(hugo version | awk '{print $2}') detected"
echo ""

# Initialize git if not already
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
fi

# Add PaperMod as a submodule
if [ ! -d themes/PaperMod ]; then
    echo "🎨 Adding PaperMod theme as submodule..."
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    git submodule update --init --recursive
else
    echo "✅ PaperMod theme already present"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Add a profile photo at static/images/profile.png (150x150 recommended)"
echo "  2. Add your resume PDF at static/resume.pdf"
echo "  3. Run the dev server:  hugo server -D"
echo "  4. Open http://localhost:1313 in your browser"
echo ""
echo "When ready to deploy, see the README.md for GitHub Pages instructions."
