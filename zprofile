# Homebrew (sets PATH, HOMEBREW_PREFIX, etc.)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [ -x "$_brew" ]; then
    eval "$("$_brew" shellenv)"
    break
  fi
done
unset _brew

# (N) drops any directory that doesn't exist
typeset -gU path
path=(
  $HOME/.local/bin(N)
  $HOME/.cargo/bin(N)
  $HOME/.pyenv/shims(N)
  $HOME/.yarn/bin(N)
  $HOME/.config/yarn/global/node_modules/.bin(N)
  $path
)

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-g -i -M -R -S -w -X -z-4'
[ -z "$LANG" ] && export LANG='en_US.UTF-8'

# Machine-specific environment
[ -f "$HOME/.zprofile.local" ] && . "$HOME/.zprofile.local"
