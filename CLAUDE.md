# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS configuration repository using flakes and home-manager for managing system and user configurations. Currently configured for a single host named `whitezaziki` running Hyprland window manager on a dual-monitor setup with NVIDIA GPU.

## Common Commands

### System Rebuild
```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake /etc/nixos#whitezaziki

# Test configuration without switching
sudo nixos-rebuild test --flake /etc/nixos#whitezaziki

# Build configuration without activating
sudo nixos-rebuild build --flake /etc/nixos#whitezaziki
```

### Flake Management
```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Show flake metadata
nix flake metadata
```

### Testing and Validation
```bash
# Check flake syntax
nix flake check

# Show what would be built
nix build .#nixosConfigurations.whitezaziki.config.system.build.toplevel --dry-run
```

### User Aliases (from bash config)
```bash
nrs         # sudo nixos-rebuild switch
nnix        # nvim /etc/nixos
confedit    # sudo -E -s nvim /etc/nixos/configuration.nix
snvim       # sudo -E -s nvim
```

## Architecture

### Directory Structure

- `flake.nix` - Main flake configuration defining NixOS system for whitezaziki host
- `hosts/` - Per-host configurations
  - `whitezaziki/` - Current host
    - `configuration.nix` - System-level configuration (bootloader, networking, packages)
    - `home.nix` - User-level home-manager configuration
    - `hardware-configuration.nix` - Auto-generated hardware config
- `nixModules/` - System-level NixOS modules (imported via `nixModules/default.nix`)
  - `catppuccin.nix` - Catppuccin theme system-wide
  - `nvidia.nix` - NVIDIA driver configuration
  - `pipewire.nix` - Audio configuration
  - `font.nix` - System fonts
  - `docker.nix` - Docker setup
  - `greetd.nix` - Login manager (auto-starts Hyprland for user andreas)
- `homeModules/` - User-level home-manager modules (imported directly in home.nix)
  - `hyprland.nix` - Hyprland window manager configuration
  - `waybar.nix` - Status bar configuration
  - `wofi.nix` - Application launcher
  - `tmux.nix` - Terminal multiplexer

### Flake Inputs
- `nixpkgs` - NixOS 25.05 stable channel
- `home-manager` - User environment management (release-25.05)
- `catppuccin` - Catppuccin theme integration (release-25.05)

### Key Design Patterns

1. **Module Organization**: System-level modules (nixModules) are for services, drivers, and system-wide settings. User-level modules (homeModules) are for application configurations managed by home-manager.

2. **Multi-Host Ready**: The structure supports multiple hosts via the `hosts/` directory. To add a new host, create a new directory under `hosts/` with its own `configuration.nix` and `home.nix`, then add it to `flake.nix` outputs.

3. **Catppuccin Theming**: The Frappe flavor is configured both at system level (nixModules/catppuccin.nix) and user level (home.nix with specific app theming like bat, kitty, tmux, cursors).

4. **Hyprland Setup**: Uses greetd as login manager which auto-starts Hyprland for the user. The Hyprland config uses master layout with dual monitors (2560x1080 primary + 1440x900 secondary).

## Hyprland Key Bindings (Current Configuration)

The system uses Hyprland with vim-style navigation and master layout:

- `SUPER+Return` - Launch kitty terminal
- `SUPER+D` - Launch wofi application launcher
- `SUPER+W` - Close active window
- `SUPER+SHIFT+Q` - Exit Hyprland
- `SUPER+H/J/K/L` - Focus window (vim keys)
- `SUPER+SHIFT+H/J/K/L` - Swap windows
- `SUPER+CTRL+H/L` - Adjust master ratio
- `SUPER+ALT+H/L` - Adjust master count
- `SUPER+V` - Toggle floating
- `SUPER+F` - Fullscreen
- `SUPER+1-9` - Switch workspace
- `SUPER+SHIFT+1-9` - Move window to workspace
- `SUPER+Period/Comma` - Focus next/previous monitor
- `SUPER+SHIFT+Period/Comma` - Move window to next/previous monitor

## Adding New Hosts

1. Create directory: `hosts/<hostname>/`
2. Add files: `configuration.nix`, `home.nix`, `hardware-configuration.nix`
3. Update `flake.nix` to add new nixosConfiguration
4. In `configuration.nix`, set `networking.hostName`
5. In home-manager config, adjust username and homeDirectory as needed
6. Run: `sudo nixos-rebuild switch --flake /etc/nixos#<hostname>`

## Adding New Modules

**System Module** (for services, drivers, system-wide settings):
1. Create `.nix` file in `nixModules/`
2. Add import to `nixModules/default.nix`
3. The module will be automatically imported for all hosts

**Home Module** (for user applications):
1. Create `.nix` file in `homeModules/`
2. Add import to relevant `hosts/<hostname>/home.nix`
3. Configure per-user as needed
