# Homebrew Formulae for yabai

Official Homebrew tap for Apple Developer ID signed releases of **yabai** with macOS 27 compatibility and stability fixes.

## Quick Start

```sh
brew tap Christian-SC26/formulae
brew install yabai
```

Or install directly in one step:

```sh
brew install Christian-SC26/formulae/yabai
```

## Upgrading

Whenever a new release is published:

```sh
brew update
brew upgrade yabai
```

## Switching from upstream yabai

If you previously installed yabai from `asmvik/formulae` (or `koekeishiya/formulae`):

```sh
brew uninstall yabai
brew install Christian-SC26/formulae/yabai
```

All your configuration (`~/.yabairc` and `~/.config/yabai/yabairc`) and hotkeys remain completely intact.
