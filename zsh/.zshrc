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

plugins=(git zsh-autosuggestions zsh-vi-mode tmux)

#brew autocompletion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload bashcompinit && bashcompinit

# Set neovim as editor
export EDITOR=nvim

# Aliases
alias n=nvim
alias t=tmux
alias sz="source ~/.zshrc"
alias zc="nvim ~/.zshrc"
alias lg="lazygit"
alias my-prs="gh pr list --author '@me'"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

eval "$(zoxide init zsh)"

if [[ -r "$HOME/.local.zsh" ]]; then
  source "$HOME/.local.zsh"
fi


if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
