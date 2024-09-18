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

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Create a temporary virtual environment
python3 -m venv temp_env

# Activate the virtual environment
source temp_env/bin/activate

# Install PyInstaller and your package
pip install pyinstaller
pip install .

# Use PyInstaller to create the executable
pyinstaller --onefile --name pomo pomodoro.py

# Deactivate and remove the temporary virtual environment
deactivate
rm -rf temp_env

# Get the user's home directory
HOME_DIR=$(eval echo ~$USER)

# Create .local/bin directory if it doesn't exist
mkdir -p "$HOME_DIR/.local/bin"

# Move the executable to .local/bin
if [ -f dist/pomo ]; then
    mv dist/pomo "$HOME_DIR/.local/bin/"
    echo "Executable created and moved to $HOME_DIR/.local/bin/pomo"
else
    echo "Error: Executable not created. Check the PyInstaller output for errors."
    exit 1
fi

# Clean up PyInstaller build files
rm -rf build dist pomo.spec

# Add .local/bin to PATH if it's not already there
LOCAL_BIN="$HOME_DIR/.local/bin"
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    if [ "$OS" == "macOS" ]; then
        # For macOS, update both .bash_profile and .zshrc
        echo "export PATH=\$PATH:$LOCAL_BIN" >> "$HOME_DIR/.bash_profile"
        echo "export PATH=\$PATH:$LOCAL_BIN" >> "$HOME_DIR/.zshrc"
        echo "Added .local/bin directory to PATH in .bash_profile and .zshrc"
    elif [ "$OS" == "Linux" ]; then
        # For Linux, update .bashrc
        echo "export PATH=\$PATH:$LOCAL_BIN" >> "$HOME_DIR/.bashrc"
        echo "Added .local/bin directory to PATH in .bashrc"
    else
        echo "Unknown OS. Please add $LOCAL_BIN to your PATH manually."
    fi
    echo "Please restart your terminal or source your shell configuration file to update your PATH."
fi

echo "Pomodoro CLI has been installed successfully!"
echo "You can now use the 'pomo' command to start the Pomodoro timer."
