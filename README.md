# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Tool | Description |
| --- | --- | --- |
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | i3-like tiling window manager for macOS |
| `alacritty` | [Alacritty](https://alacritty.org/) | GPU-accelerated terminal emulator |
| `ghostty` | [Ghostty](https://ghostty.org/) | Fast, native terminal emulator |
| `nvim` | [LazyVim](https://www.lazyvim.org/) | Neovim distribution with sensible defaults and plugin presets |
| `tmux` | [tmux](https://github.com/tmux/tmux) | Terminal multiplexer for persistent sessions and splits |
| `p10k` | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Fast, customizable zsh prompt theme |
| `zshrc` | zsh + [oh-my-zsh](https://ohmyz.sh/) | Shell config with plugins, aliases, and PATH setup |

## Setup

Clone the repo:

```sh
git clone https://github.com/<you>/dotfiles ~/dotfiles
cd ~/dotfiles
```

Install the utilities used by `zsh/.zshrc`:

```sh
./bootstrap.sh
```

Stow target is set to `$HOME` via `.stowrc`. Symlink everything:

```sh
stow */
```

Or pick individual packages:

```sh
stow nvim tmux zsh
```

To remove symlinks for a package:

```sh
stow -D nvim
```

## Local overrides

`~/.zshrc` sources these if present (kept out of the repo):

- `~/.creds` — credentials / API keys
- `~/.env_vars` — extra environment variables
- `~/.zshrc.work` — work-specific shell config
