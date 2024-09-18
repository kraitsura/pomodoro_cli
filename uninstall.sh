#!/bin/bash

# Function to check the operating system
check_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux"
    else
        echo "Unknown"
    fi
}

# Get the OS
OS=$(check_os)

# Get the user's home directory
HOME_DIR=$(eval echo ~$USER)

# Remove the executable
rm -f "$HOME_DIR/.local/bin/pomo"

# Remove the .local/bin directory from PATH in shell configuration files
LOCAL_BIN="$HOME_DIR/.local/bin"
ESCAPED_LOCAL_BIN=$(echo "$LOCAL_BIN" | sed 's/[\/&]/\\&/g')

if [ "$OS" == "macOS" ]; then
    # For macOS, update both .bash_profile and .zshrc
    if [ -f "$HOME_DIR/.bash_profile" ]; then
        sed -i '' "/export PATH=\$PATH:$ESCAPED_LOCAL_BIN/d" "$HOME_DIR/.bash_profile"
    fi
    if [ -f "$HOME_DIR/.zshrc" ]; then
        sed -i '' "/export PATH=\$PATH:$ESCAPED_LOCAL_BIN/d" "$HOME_DIR/.zshrc"
    fi
    echo "PATH modification removed from .bash_profile and .zshrc (if they exist)."
elif [ "$OS" == "Linux" ]; then
    # For Linux, update .bashrc
    if [ -f "$HOME_DIR/.bashrc" ]; then
        sed -i "/export PATH=\$PATH:$ESCAPED_LOCAL_BIN/d" "$HOME_DIR/.bashrc"
    fi
    echo "PATH modification removed from .bashrc (if it exists)."
else
    echo "Unknown OS. Please remove $LOCAL_BIN from your PATH manually."
fi

echo "Pomodoro CLI has been uninstalled successfully!"
echo "Please restart your terminal or source your shell configuration file to update your PATH."

# Optionally, remove the entire .local/bin directory if it's empty
if [ -d "$HOME_DIR/.local/bin" ] && [ -z "$(ls -A "$HOME_DIR/.local/bin")" ]; then
    rm -rf "$HOME_DIR/.local/bin"
    echo "Removed empty .local/bin directory."
fi
