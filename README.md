# Vicinae Power Menu

![License](https://img.shields.io/badge/license-MIT-green)
![Version](https://img.shields.io/github/v/release/v81d/vicinae-power-menu)

**Vicinae Power Menu** is a dedicated power menu for [**Vicinae**](https://github.com/vicinaehq/vicinae), designed to integrate seamlessly with your environment. It allows you to control your session easily within the launcher.

---

## Prerequisites

Before installing **Vicinae Power Menu**, make sure your system meets the following requirements:

### System Requirements

- **Operating System:** Linux (tested on CachyOS, an Arch derivative, but should work on most distros)
- **Init System:** `systemd` (other init systems are not supported unless you edit the helper script yourself)
- **Display Server:** Wayland (supports Hyprland, Sway, GNOME, Plasma); X11 is not guaranteed

### Software Dependencies

- **Node.js** ≥ 18.x
- **npm** (comes with Node.js)
- **Git** (for cloning the repository)
- **make** and **gcc** (optional, only needed if building native modules)
- **Vicinae** to display the menu
- **bash** (required for `helper.sh` script)

### Permissions

- Ability to execute scripts (`chmod +x`)
- Permission to create directories in `~/.local/share`

---

## Features

* Simple, fast, and responsive.
* Can be customized to your preferences.
* Fully supports several environments out of the box.

---

## Installation

1. Clone the repository:

```bash
git clone https://github.com/v81d/vicinae-power-menu.git
cd vicinae-power-menu
```
```
```

2. Copy the helper script to the dedicated directory:

```bash
mkdir -p ~/.local/share/vicinae-power-menu
cp scripts/helper.sh ~/.local/share/vicinae-power-menu
chmod +x ~/.local/share/vicinae-power-menu/helper.sh
```

3. Install dependencies and run the extension in development mode:

```bash
npm install
```

4. Build the production bundle:

```bash
npm run build
```

---

## Setup

1. Make sure the helper script `helper.sh` is placed inside the folder `~/.local/share/vicinae-power-menu`:

```bash
cp scripts/helper.sh ~/.local/share/vicinae-power-menu
chmod +x ~/.local/share/vicinae-power-menu/helper.sh
```

2. Set the script to automatically run as a daemon. Steps vary depending on your desktop environment or window manager:

```ini
exec-once = ~/.local/share/vicinae-power-menu/helper.sh  # For Hyprland
```

You can also create a dedicated `~/.config/autostart` service that calls the script on startup.

---

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve the project.

---

## License

This project is licensed under the **MIT License**.

You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this software, provided that the original copyright notice and this permission notice are included in all copies or substantial portions of the software.

For the full license text, see https://mit-license.org.
