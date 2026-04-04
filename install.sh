#!/bin/bash

# Super Pencil Skill Installer
# This script installs the super-pencil skill to your OpenCode skills directory

set -e

SKILL_NAME="super-pencil"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS and determine skills directory
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash/WSL)
    SKILLS_DIR="$(cygpath -u "$USERPROFILE")/.config/opencode/skills"
    echo "Detected Windows system"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    SKILLS_DIR="$HOME/.config/opencode/skills"
    echo "Detected macOS system"
else
    # Linux
    SKILLS_DIR="$HOME/.config/opencode/skills"
    echo "Detected Linux system"
fi

echo "Skills directory: $SKILLS_DIR"

# Create skills directory if it doesn't exist
if [ ! -d "$SKILLS_DIR" ]; then
    echo "Creating skills directory..."
    mkdir -p "$SKILLS_DIR"
fi

# Remove existing installation if present
if [ -d "$SKILLS_DIR/$SKILL_NAME" ]; then
    echo "Removing existing installation..."
    rm -rf "$SKILLS_DIR/$SKILL_NAME"
fi

# Copy skill files
echo "Installing $SKILL_NAME skill..."
cp -r "$SCRIPT_DIR" "$SKILLS_DIR/$SKILL_NAME"

# Verify installation
if [ -f "$SKILLS_DIR/$SKILL_NAME/SKILL.md" ]; then
    echo ""
    echo "✅ Installation successful!"
    echo ""
    echo "Skill location: $SKILLS_DIR/$SKILL_NAME"
    echo ""
    echo "To use this skill, load it in your AI assistant:"
    echo "  Load skill: $SKILL_NAME"
    echo ""
else
    echo "❌ Installation failed!"
    exit 1
fi
