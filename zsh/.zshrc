# Homebrew must be initialized before any startup integrations (including Herdr)
# because some shells launched by multiplexers are not login shells and skip
# ~/.zprofile.
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Enable Powerlevel11k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-vi-mode)

#brew autocompletion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# herdr completions (cached; delete ~/.cache/herdr-completions to regenerate)
if command -v herdr >/dev/null 2>&1; then
  if [[ ! -f "$HOME/.cache/herdr-completions/_herdr" ]]; then
    mkdir -p "$HOME/.cache/herdr-completions"
    herdr completion zsh > "$HOME/.cache/herdr-completions/_herdr"
  fi
  FPATH="$HOME/.cache/herdr-completions:${FPATH}"
fi

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload bashcompinit && bashcompinit

# Set neovim as editor
export EDITOR=nvim

# Aliases
alias n=nvim
alias h=herdr
alias t=tmux # fallback multiplexer
alias sz="source ~/.zshrc"
alias zc="nvim ~/.zshrc"
alias lg="lazygit"
alias my-prs="gh pr list --author '@me'"

# eza (modern ls replacement) — fall back to plain ls if eza is missing
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto"
  alias ll="eza -l --icons=auto --git"
  alias la="eza -la --icons=auto --git"
  alias lt="eza --tree --level=2 --icons=auto"
else
  alias ll="ls -l"
  alias la="ls -la"
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

eval "$(zoxide init zsh)"

# fzf shell integration (Ctrl-T files, Alt-C cd) + atuin (Ctrl-R history).
# zsh-vi-mode overwrites keybindings on init, so load both via its hook;
# atuin last so it owns Ctrl-R.
zvm_after_init() {
  source <(fzf --zsh)
  eval "$(atuin init zsh)"

  # Sync vi-mode registers with the macOS clipboard (vim's clipboard=unnamed):
  # yank/delete/change also pbcopy, p/P paste from pbpaste. Wraps the plugin's
  # functions instead of reimplementing them so zvm internals can change freely.
  if (( ${+functions[zvm_vi_yank]} && ! ${+functions[zvm_vi_yank_orig]} )); then
    local f
    for f in zvm_vi_yank zvm_vi_delete zvm_vi_change zvm_vi_put_after zvm_vi_put_before; do
      functions[${f}_orig]=$functions[$f]
    done
    zvm_vi_yank()       { zvm_vi_yank_orig;   print -rn -- "$CUTBUFFER" | pbcopy }
    zvm_vi_delete()     { zvm_vi_delete_orig; print -rn -- "$CUTBUFFER" | pbcopy }
    zvm_vi_change()     { zvm_vi_change_orig; print -rn -- "$CUTBUFFER" | pbcopy }
    zvm_vi_put_after()  { CUTBUFFER=$(pbpaste); zvm_vi_put_after_orig }
    zvm_vi_put_before() { CUTBUFFER=$(pbpaste); zvm_vi_put_before_orig }
  fi
}

# clip: pipe into it to copy, `clip file...` copies file contents,
# bare `clip` prints the clipboard
clip() {
  if (( $# > 0 )); then
    cat -- "$@" | pbcopy
  elif [[ -t 0 ]]; then
    pbpaste
  else
    pbcopy
  fi
}

if [[ -r "$HOME/.local.zsh" ]]; then
  source "$HOME/.local.zsh"
fi


if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

. "$HOME/.atuin/bin/env"

# ── Portkey + Codex (v1.1.0) ──
# ── End Portkey + Codex ──
