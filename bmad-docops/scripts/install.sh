#!/bin/bash
# BMAD DocOps Nextra 4 Installation Script
# Run from your BMAD project root

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="${1:-docs}"

echo "🚀 BMAD DocOps - Nextra 4 Installation"
echo "======================================="
echo ""

# Check if docs directory exists
if [ -d "$DOCS_DIR" ]; then
    echo "⚠️  Directory '$DOCS_DIR' already exists."
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    rm -rf "$DOCS_DIR"
fi

# Create docs directory
echo "📁 Creating $DOCS_DIR directory..."
mkdir -p "$DOCS_DIR"

# Copy templates
echo "📋 Copying templates..."
cp -r "$SCRIPT_DIR/templates/"* "$DOCS_DIR/"

# Copy workflows to bmad-method if exists
if [ -d "bmad-method/workflows" ]; then
    echo "📋 Copying workflows to bmad-method..."
    cp "$SCRIPT_DIR/workflows/"*.md "bmad-method/workflows/"
fi

# Copy module config if bmad-method exists
if [ -d "bmad-method/modules" ]; then
    echo "📋 Copying module config..."
    mkdir -p "bmad-method/modules/docops-nextra"
    cp "$SCRIPT_DIR/module/module.yaml" "bmad-method/modules/docops-nextra/"
fi

# Create .doc-manifest.yaml
echo "📄 Creating documentation manifest..."
cat > "$DOCS_DIR/.doc-manifest.yaml" << 'EOF'
# Documentation Manifest - BMAD DocOps
# Auto-generated - tracks documentation state

version: "1.0"
framework: nextra
nextra_version: "4.x"
generated_at: "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

source_artifacts:
  product_brief: ../planning_artifacts/product-brief.md
  prd: ../planning_artifacts/prd.md
  architecture: ../planning_artifacts/architecture.md

content_structure:
  - getting-started/
  - guides/
  - api/
  - concepts/

feature_mapping: {}
story_docs: {}
pending_changes: []
EOF

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "  1. cd $DOCS_DIR"
echo "  2. npm install"
echo "  3. npm run dev"
echo ""
echo "Visit http://localhost:3000 to see your docs."
echo ""
echo "BMAD Commands:"
echo "  *paige di  - Initialize docs from planning artifacts"
echo "  *paige da  - Analyze story for doc needs"
echo "  *paige ds  - Sync documentation changes"
