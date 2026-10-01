# Homebrew (sets PATH, HOMEBREW_PREFIX, etc.)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [ -x "$_brew" ]; then
    eval "$("$_brew" shellenv)"
    break
  fi
done
unset _brew

typeset -gU path
path=("$HOME/.local/bin" $path)

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LESS='-g -i -M -R -S -w -X -z-4'
[ -z "$LANG" ] && export LANG='en_US.UTF-8'
