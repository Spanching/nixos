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
- `homeModules/` - User-level home-manager modules (imported via `homeModules/default.nix`)
  - `hyprland.nix` - Hyprland window manager configuration
  - `waybar.nix` - Status bar configuration
  - `wofi.nix` - Application launcher
  - `tmux.nix` - Terminal multiplexer
  - `neovim.nix` - Neovim editor configuration
  - `catppuccin.nix` - User-level Catppuccin theming

### Flake Inputs
- `nixpkgs` - NixOS 25.05 stable channel
- `home-manager` - User environment management (release-25.05)
- `catppuccin` - Catppuccin theme integration (release-25.05)

### Module Structure Pattern

This configuration follows a strict modular structure for organization and multi-host flexibility:

#### Home Manager Modules (`homeModules/`)

All home-manager modules are:
1. **Imported centrally** via `homeModules/default.nix` - This file contains the imports list for all home modules
2. **Program-specific** - Each module is in its own file (e.g., `neovim.nix`, `hyprland.nix`, `tmux.nix`)
3. **Self-contained** - Each module contains all configuration for that specific program

**Future multi-host support**: When adding new hosts that need fewer features, modules will use enable boolean configurations to allow selective activation per-host. For now, all modules are enabled by default for the single host.

Example structure:
```nix
# homeModules/default.nix
{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./neovim.nix
    # ... all home modules
  ];
}
```

#### System Modules (`nixModules/`)

System-level modules follow the same pattern:
1. **Imported centrally** via `nixModules/default.nix` - This file contains the imports list for all system modules
2. **Purpose-specific** - Each module handles one system aspect (e.g., `nvidia.nix`, `docker.nix`, `pipewire.nix`)
3. **Service/driver focused** - For system-wide services, drivers, and settings

**Future multi-host support**: Similar to home modules, enable booleans will be added when multiple hosts need different system configurations.

Example structure:
```nix
# nixModules/default.nix
{ config, pkgs, ... }:
{
  imports = [
    ./nvidia.nix
    ./pipewire.nix
    ./docker.nix
    # ... all system modules
  ];
}
```

#### Adding New Packages - IMPORTANT

**When adding new packages or applications, ALWAYS follow this pattern:**

1. **Determine if it's a system or home module**:
   - System module: Services, drivers, system-wide settings → `nixModules/`
   - Home module: User applications, dotfiles, program configs → `homeModules/`

2. **Create a dedicated module file**:
   - Create `homeModules/<program>.nix` or `nixModules/<service>.nix`
   - Configure the program/service completely within that file

3. **Add to the appropriate default.nix**:
   - Add import to `homeModules/default.nix` or `nixModules/default.nix`

4. **Never add packages directly** to `configuration.nix` or `home.nix` unless they are trivial one-liner packages without configuration

This pattern ensures:
- Clean separation of concerns
- Easy per-host customization in the future
- Maintainable, modular configuration
- Clear organization

### Key Design Patterns

1. **Module Organization**: System-level modules (nixModules) are for services, drivers, and system-wide settings. User-level modules (homeModules) are for application configurations managed by home-manager.

2. **Multi-Host Ready**: The structure supports multiple hosts via the `hosts/` directory. To add a new host, create a new directory under `hosts/` with its own `configuration.nix` and `home.nix`, then add it to `flake.nix` outputs.

3. **Catppuccin Theming**: The Frappe flavor is configured at user level (homeModules/catppuccin.nix with specific app theming like bat, kitty, tmux, cursors).

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

See the **Module Structure Pattern** section above for detailed guidelines. Quick reference:

**System Module** (for services, drivers, system-wide settings):
1. Create `.nix` file in `nixModules/`
2. Add import to `nixModules/default.nix`
3. The module will be automatically imported for all hosts

**Home Module** (for user applications):
1. Create `.nix` file in `homeModules/`
2. Add import to `homeModules/default.nix`
3. The module will be automatically imported for all users

**IMPORTANT**: Always follow the modular pattern - do NOT add packages directly to `configuration.nix` or `home.nix` unless they are trivial one-liners without configuration. Each program/service should have its own dedicated module file.
