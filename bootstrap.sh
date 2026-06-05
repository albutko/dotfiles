#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf '\nWARN: %s\n' "$*" >&2
}

have() {
  command -v "$1" >/dev/null 2>&1
}

use_homebrew_path() {
  local brew_bin

  case "$(uname -s)" in
    Darwin)
      for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$brew_bin" ]]; then
          eval "$("$brew_bin" shellenv)"
          return
        fi
      done
      ;;
    Linux)
      brew_bin=/home/linuxbrew/.linuxbrew/bin/brew
      if [[ -x "$brew_bin" ]]; then
        eval "$("$brew_bin" shellenv)"
      fi
      ;;
  esac
}

clone_if_missing() {
  local repo="$1"
  local dest="$2"

  if [[ -e "$dest" ]]; then
    log "Skipping ${dest}; already exists"
    return
  fi

  log "Cloning ${repo} to ${dest}"
  git clone --depth=1 "$repo" "$dest"
}

install_homebrew() {
  if have brew; then
    return
  fi

  use_homebrew_path
  have brew && return

  if ! have curl; then
    warn "curl is required to bootstrap Homebrew. Install curl first, then rerun this script."
    exit 1
  fi

  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  use_homebrew_path

  if ! have brew; then
    warn "Homebrew installed, but brew is not on PATH. Open a new shell, then rerun this script."
    exit 1
  fi
}

install_brew_packages() {
  local packages_to_install=()
  local package_specs=(
    "git:git"
    "neovim:nvim"
    "tmux:tmux"
    "lazygit:lazygit"
    "zoxide:zoxide"
    "zsh:zsh"
    "stow:stow"
  )
  local spec
  local formula
  local command

  for spec in "${package_specs[@]}"; do
    formula="${spec%%:*}"
    command="${spec#*:}"

    if have "$command"; then
      log "Skipping ${formula}; ${command} already exists"
    else
      packages_to_install+=("$formula")
    fi
  done

  if (( ${#packages_to_install[@]} == 0 )); then
    log "All Homebrew utilities already exist"
    return
  fi

  log "Installing missing zshrc utilities with Homebrew"
  brew install "${packages_to_install[@]}"
}

main() {
  local omz_dir="${ZSH:-$HOME/.oh-my-zsh}"
  local custom_dir="${ZSH_CUSTOM:-$omz_dir/custom}"
  local tmux_plugins_dir="$HOME/.tmux/plugins"

  install_homebrew
  install_brew_packages

  clone_if_missing "https://github.com/ohmyzsh/ohmyzsh.git" "$omz_dir"

  mkdir -p "$custom_dir/themes" "$custom_dir/plugins"
  mkdir -p "$tmux_plugins_dir"
  clone_if_missing "https://github.com/romkatv/powerlevel10k.git" "$custom_dir/themes/powerlevel10k"
  clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$custom_dir/plugins/zsh-autosuggestions"
  clone_if_missing "https://github.com/jeffreytse/zsh-vi-mode.git" "$custom_dir/plugins/zsh-vi-mode"
  clone_if_missing "https://github.com/tmux-plugins/tpm.git" "$tmux_plugins_dir/tpm"

  log "Done"
  printf 'Utilities from zsh/.zshrc are installed. Run `stow zsh p10k` from this repo if you have not linked the dotfiles yet.\n'
}

main "$@"
