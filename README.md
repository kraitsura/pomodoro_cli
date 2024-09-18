# Pomodoro CLI

A simple command-line Pomodoro timer with ASCII art display.

## Features

- Customizable work and break durations
- Large ASCII art time display
- Progress bar
- Animated clock face

## Installation

### Automatic Installation (Unix-like systems)

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/pomodoro-cli.git
   ```
2. Navigate to the project directory:
   ```
   cd pomodoro-cli
   ```
3. Run the installation script:
   ```
   ./install.sh
   ```

### Manual Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/pomodoro-cli.git
   ```
2. Navigate to the project directory:
   ```
   cd pomodoro-cli
   ```
3. Install the package:
   ```
   pip install --user .
   ```
4. Add the Python user bin directory to your PATH:
   ```
   export PATH=$PATH:$(python3 -m site --user-base)/bin
   ```
   You may want to add this line to your `.bashrc` or `.zshrc` file to make it permanent.

## Usage

After installation, you can use the Pomodoro timer by running:

```
pomo
```

This will start a Pomodoro session with default settings (25 minutes work, 5 minutes break).

To customize the work and break times, use the following options:

```
pomo -w WORK_TIME -b BREAK_TIME
```

For example:

```
pomo -w 30 -b 10
```

This will start a Pomodoro session with 30 minutes work time and 10 minutes break time.

## Uninstallation

To uninstall the Pomodoro CLI, you can use the provided uninstall script:

1. Navigate to the project directory:
   ```
   cd pomodoro-cli
   ```
2. Run the uninstall script:
   ```
   ./uninstall.sh
   ```

This script will remove the Pomodoro CLI package and clean up any PATH modifications made during installation.

If you installed the package manually, you can uninstall it using pip:

```
pip uninstall pomodoro-cli
```

Remember to remove any PATH modifications you made manually in your `.bashrc` or `.zshrc` files.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
