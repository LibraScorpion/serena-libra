#!/bin/bash

# OpenCode Installation Script with Claude Sonnet 4 Support

set -e

echo "🚀 Installing OpenCode with Claude Sonnet 4 support..."

# Create installation directory
INSTALL_DIR="$HOME/.opencode/bin"
mkdir -p "$INSTALL_DIR"

# Copy binary
echo "📦 Installing binary to $INSTALL_DIR..."
cp opencode "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/opencode"

# Setup configuration if it doesn't exist
CONFIG_FILE="$HOME/.opencode.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚙️  Setting up configuration..."
    cp sample-config.json "$CONFIG_FILE"
    echo "📝 Configuration created at $CONFIG_FILE"
    echo "⚠️  Please edit $CONFIG_FILE and add your OpenRouter API key!"
else
    echo "✅ Configuration already exists at $CONFIG_FILE"
fi

# Add to PATH if not already there
SHELL_RC=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ] && [ -f "$SHELL_RC" ]; then
    if ! grep -q "$INSTALL_DIR" "$SHELL_RC"; then
        echo "🔧 Adding $INSTALL_DIR to PATH in $SHELL_RC..."
        echo "" >> "$SHELL_RC"
        echo "# OpenCode" >> "$SHELL_RC"
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$SHELL_RC"
        echo "✅ Added to PATH. Please restart your shell or run: source $SHELL_RC"
    else
        echo "✅ PATH already configured"
    fi
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Next steps:"
echo "1. Edit $CONFIG_FILE and add your OpenRouter API key"
echo "2. Restart your shell or run: source $SHELL_RC"
echo "3. Run: opencode --help"
echo ""
echo "To test Claude Sonnet 4:"
echo "opencode -p \"Hello from Claude Sonnet 4!\" -f json"
echo ""
echo "Happy coding! 🚀"
