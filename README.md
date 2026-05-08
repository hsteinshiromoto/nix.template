# Nix Flake Templates

Collection of Nix flakes for reproducible development environments.

## Available Templates

### python-dev

Python development environment with OpenMP support.

**Features:**
- Multi-shell support: nushell (default), zsh, bash
- Atuin shell history integration
- Automatic `.env` file loading

**Usage:**
```bash
# Initialize a new project
nix flake init -t .#python-dev

# Enter the devshell
nix develop           # nushell (default)
nix develop .#zsh     # zsh
nix develop .#bash    # bash
```

### rust-dev

Rust development environment.

**Usage:**
```bash
nix flake init -t .#rust-dev
nix develop
```

## Prerequisites

- Nix with flakes enabled (`experimental-features = nix-command flakes` in `~/.config/nix/nix.conf`)

## License

MIT - see LICENSE file.
