# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set powerlevel10k theme
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

plugins=(git zsh-autosuggestions zsh-vi-mode tmux)

#brew autocompletion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az
eval $(thefuck --alias)
eval "$(direnv hook zsh)"

sys_python="$HOME/Library/Python/3.11/bin"
export PATH="$PATH:${sys_python}"

if [ -f ~/.creds ]; then
  source ~/.creds
fi

if [ -f ~/.env_vars ]; then
  source ~/.env_vars
fi

if [ -f ~/.zshrc.work ]; then
  source ~/.zshrc.work
fi

# Set neovim as editor
export EDITOR=nvim

# Aliases
alias n=nvim
alias t=tmux
alias sz="source ~/.zshrc"
alias zc="nvim ~/.zshrc"
alias lg="lazygit"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

. "$HOME/.cargo/env"

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

eval "$(zoxide init zsh)"


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
