# --- Shell behavior ---
setopt INTERACTIVE_COMMENTS  # allow # comments at the prompt
setopt AUTO_CD               # cd by typing a directory name
setopt NO_BEEP               # no bell on errors
setopt NO_FLOW_CONTROL       # free up Ctrl-S / Ctrl-Q

# --- History ---
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY         # share history between sessions (implies EXTENDED_HISTORY)
setopt HIST_IGNORE_ALL_DUPS  # drop older duplicates of a re-run command
setopt HIST_IGNORE_SPACE     # don't save commands starting with a space

# --- ls colors ---
# GNU ls (Linux) and newer macOS ls support --color; dircolors is GNU-only
if ls --color=auto -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
else
  # Older macOS ls
  export CLICOLOR=1
fi

# --- Key bindings ---
bindkey -v
export KEYTIMEOUT=1

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^B" backward-word
bindkey "^F" forward-word

# --- Completion ---
fpath=(~/.zsh/completion $fpath)
if (( $+commands[brew] )); then
  # Prefix is two levels up from the brew binary, e.g. /opt/homebrew/bin/brew
  fpath=("${HOMEBREW_PREFIX:-${commands[brew]:h:h}}/share/zsh/site-functions" $fpath)
fi
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# --- Tools (only loaded when installed) ---
# fzf
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
  if _fzf_init="$(fzf --zsh 2>/dev/null)"; then
    eval "$_fzf_init"
  else
    # Older fzf packages (e.g. Debian) ship the scripts separately
    for _fzf_script in /usr/share/doc/fzf/examples/{key-bindings,completion}.zsh; do
      [ -f "$_fzf_script" ] && source "$_fzf_script"
    done
    unset _fzf_script
  fi
  unset _fzf_init
fi
# Plain history search when fzf's Ctrl-R isn't available
(( $+widgets[fzf-history-widget] )) || bindkey "^R" history-incremental-search-backward

# nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

  # Switch to the .nvmrc version when entering a project that uses a different one
  load-nvmrc() {
    local nvmrc="$(nvm_find_nvmrc)"
    if [ -n "$nvmrc" ] && [ "$(nvm version "$(<"$nvmrc")")" != "$(nvm version)" ]; then
      nvm use
    fi
  }
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# --- Plugins (only loaded when installed) ---
# Searches Homebrew (macOS) and common Linux package locations
_plugin_dirs=(
  ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share}
  /opt/homebrew/share
  /usr/local/share
  /usr/share
  /usr/share/zsh/plugins
)

# Sources the first match for a plugin; returns 1 if it isn't installed
source_plugin() {
  local dir
  for dir in $_plugin_dirs; do
    if [ -f "$dir/$1/$1.zsh" ]; then
      source "$dir/$1/$1.zsh"
      return 0
    fi
  done
  return 1
}

source_plugin zsh-autosuggestions

if source_plugin zsh-history-substring-search; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# Must be sourced last among the plugins
source_plugin zsh-syntax-highlighting

unset _plugin_dirs
unfunction source_plugin

# --- Local overrides and aliases ---
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# --- Prompt ---
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
